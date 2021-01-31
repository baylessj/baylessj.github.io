---
layout: post
tags: [software]
title: C++ in the Background of React with WebAssembly and WebWorkers
image:
  - src: wasm.webp
    alt: "WebAssembly Logo"
  - src: emscripten.png
    alt: "Emscripten Logo"
  - src: react.png
    alt: "React Logo"
---

My side project of choice at the moment is [Squiggles](https://github.com/baylessj/robotsquiggles).
Squiggles is a library that makes it easy to create bezier curve paths, or "Squiggles",
for robots. I wrote the library in C++.

After completing the initial development of the core library I started development
of a web-based GUI for drawing out these paths. My goal for this GUI is to provide
an easier way to prototype paths by both overlaying the paths on the robot's
field and generating the paths to confirm that they are possible. The second part
requires running the C++ code based on input from the user in the browser. C++
does not natively run client-side so we need to compile the C++ to a format the
browser can use. This is where [WebAssembly](https://webassembly.org/) comes in.

## WebAssembly

{% assign image = page.image[0] %}
{% include srcset-sizes.html %}

WebAssembly is a relatively new technology that allows compiled code to run in
the browser. The WebAssembly itself is stored as a long string of hex. Most
WebAssembly compilers, including [Emscripten](https://emscripten.org/) like I'm using, also generate a
Javascript file that aids in loading the compiled code.

{% assign image = page.image[1] %}
{% include srcset-sizes.html %}

I used Emscripten to compile the Squiggles C++ code to WebAssembly and a Javascript
file. Emscripten is a very powerful tool and, as a result, takes a bit of
configuration to get working just right for this use case.

```shell
emcc $SRCS -s WASM=1 -s MODULARIZE=1 \
-s EXTRA_EXPORTED_RUNTIME_METHODS='[\"ccall\", \"cwrap\"]' \
-s EXPORT_NAME=\"'squiggles'\" -s SINGLE_FILE=1 -I main/include \
--std=gnu++17 -o squiggles.js
```

The snippet above is the script I run to build the Squiggles WebAssembly.

- `-s WASM=1` This flag specifies that we want emcc to output WebAssembly.
- `-s MODULARIZE=1` This flag exports the generated Javascript as a named module.
- `-s EXTRA_EXPORTED_RUNTIME_METHODS='[\"ccall\", \"cwrap\"]'` This flag makes [these](https://emscripten.org/docs/porting/connecting_cpp_and_javascript/Interacting-with-code.html#interacting-with-code-ccall-cwrap) functions available in the generated Javascript.
- `-s EXPORT_NAME=\"'squiggles'\"` This flag names our generated module "Squiggles".
- `-s SINGLE_FILE=1` This flag tells emcc to put the WebAssembly in the generated Javascript rather than in a standalone file.
- `-I main/include` This is the path to the C++ code's include directory.

TODO add a section about the shim code

## WebWorker

Generating paths with Squiggles takes a decent bit of time, at least in terms of
UI responsiveness. We don't want to run the generation directly from the main
Javascript app because it would block the user from doing anything in the meantime.
The solution for this is the [WebWorker](https://developer.mozilla.org/en-US/docs/Web/API/Web_Workers_API/Using_web_workers).

We will use the WebWorker to asynchronously load the WebAssembly and run the
generation. Our UI interacts with the worker by passing messages. Let's look at
the "load" message as an example.

```js
/**
 * This exists to capture all the events that are thrown out of the worker
 * into the worker. Without this, there would be no communication possible
 * with our project.
 */
onmessage = function (e) {
  switch (e.data.msg) {
    case "load": {
      // Import Webassembly script
      self.importScripts("./squiggles.js");
      waitForWasm(function (success) {
        if (success) postMessage({ msg: e.data.msg });
        else throw new Error("Error on loading Squiggles lib");
      });
      break;
    }
    default:
      break;
  }
};
```

Above our worker will, after getting the "load" message, import the WebAssembly
file and then wait on the browser to make its functions callable (`waitForWasm`).
When this process is complete and Squiggles is ready we send a message back to
the UI.

Once we've loaded the WebAssembly we can use this same message API to call
Squiggles' path generation.

## React Integration

{% assign image = page.image[2] %}
{% include srcset-sizes.html %}

Ordinarily we could just stick the generated WebAssembly/JS and WebWorker in the
site's static assets and be good to go. I'm using [React](https://reactjs.org/), though, which adds
a bit more complexity. We'll create a wrapper class in the React app to interact
with the WebWorker.

```js
load() {
  this._status = {};
  this.worker = new Worker("robotsquiggles/js/squiggles.worker.js"); // load worker

  // Capture events and save [status, event] inside the _status object
  this.worker.onmessage = (e) => (this._status[e.data.msg] = ["done", e]);
  this.worker.onerror = (e) => (this._status[e?.data?.msg] = ["error", e]);
  return this._dispatch({ msg: "load" });
}
```

The above function creates the worker and sets up the message passing. We'll
call this first and then use `this.worker.postMessage` to use the worker.

The code above took me a while to troubleshoot. I kept trying to access the
worker file at `/js/squiggles.worker.js` since that is the file's location
relative to the root of the project. This would get me an error about an incorrect
"MIME" type of `text/html`. React was automatically prepending the `robotsquiggles`
value from the project's `homepage` value in `package.json`, and when it couldn't
find a file at the requested location, returned the contents of index.html.
Getting the path to the javascript file right was all it took to get the file
loaded.

```js
await squiggles.load();
const val = await squiggles.test();
```

We then call the promises defined by our wrapper in an async function in the GUI
code.

Credit to opencv-js-webworker repo
