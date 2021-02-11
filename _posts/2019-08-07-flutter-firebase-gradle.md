---
layout: post
tags: [flutter, programming, android]
title: "Gradle Configuration for Firebase Usage in Flutter"
---

I recently got started developing a cross-platform app in [Flutter](https://flutter.dev/), a framework developed by Google that uses the [Dart](https://dart.dev/) programming language. One major benefit of the fact that Flutter is created by Google is the _mostly_ easy integration with Google's other services. I have come across one minor exception to this rule in my attempt to integrate [Firebase](https://firebase.google.com/) with my Flutter project, an error regarding `.dex` file generation.

### Original Gradle Modifications

I followed along with Google's guide on modifying my app's [Gradle](https://gradle.org/) configuration files to integrate Firebase services into the app. My Gradle config files after implementing the Google guide's changes were as follows:

`./android/`:

```
buildscript {
    repositories {
        google()
        jcenter()
    }

    dependencies {
        classpath 'com.android.tools.build:gradle:3.2.1'
        classpath 'com.google.gms:google-services:4.3.0'
    }
}

allprojects {
    repositories {
        google()
        jcenter()
    }
}

rootProject.buildDir = '../build'
subprojects {
    project.buildDir = "${rootProject.buildDir}/${project.name}"
}
subprojects {
    project.evaluationDependsOn(':app')
}

task clean(type: Delete) {
    delete rootProject.buildDir
}
```

`./android/app/`:

```
def localProperties = new Properties()
def localPropertiesFile = rootProject.file('local.properties')
if (localPropertiesFile.exists()) {
    localPropertiesFile.withReader('UTF-8') { reader ->
        localProperties.load(reader)
    }
}

def flutterRoot = localProperties.getProperty('flutter.sdk')
if (flutterRoot == null) {
    throw new GradleException("Flutter SDK not found. Define location with flutter.sdk in the local.properties file.")
}

def flutterVersionCode = localProperties.getProperty('flutter.versionCode')
if (flutterVersionCode == null) {
    flutterVersionCode = '1'
}

def flutterVersionName = localProperties.getProperty('flutter.versionName')
if (flutterVersionName == null) {
    flutterVersionName = '1.0'
}

apply plugin: 'com.android.application'
apply from: "$flutterRoot/packages/flutter_tools/gradle/flutter.gradle"

android {
    compileSdkVersion 28

    lintOptions {
        disable 'InvalidPackage'
    }

    defaultConfig {
        applicationId "com.jonathanbayless.autodo"
        minSdkVersion 16
        targetSdkVersion 28
        versionCode flutterVersionCode.toInteger()
        versionName flutterVersionName
        testInstrumentationRunner "android.support.test.runner.AndroidJUnitRunner"
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig signingConfigs.debug
        }
    }
}

flutter {
    source '../..'
}

dependencies {
    testImplementation 'junit:junit:4.12'
    androidTestImplementation 'com.android.support.test:runner:1.0.2'
    androidTestImplementation 'com.android.support.test.espresso:espresso-core:3.0.2'
}

apply plugin: 'com.google.gms.google-services'  // Google Play services Gradle plugin
```

### Too many methods for one Dex file

After I was done following the Google guide I was met with a build error that was not addressed in the Google guide. The addition of the `google-services` package inflated the size of the built project to the point that it exceeded the number of methods allowed in a single `.dex` file.

A `.dex` file is similar to a `.jar` file from typical Java development but is unique to the Android ecosystem. The `.dex` file is used as an intermediary file in developing a `.apk` file that will be loaded onto the Android device. I discovered through this error message that the default Gradle configuration generated with Flutter only uses one `.dex` file to generate the `.apk` file.

The solution I found to this error consisted of two changes: enabling a build flag regarding the `.dex` generation and enabling resource shrinking. The default configuration that only allows for one `.dex` file can be changed by setting the `multiDexEnabled` to `true` in the `defaultConfig` section of the `android` rules.

```
defaultConfig {
    applicationId "com.jonathanbayless.autodo"

    multiDexEnabled true

    versionCode flutterVersionCode.toInteger()
    versionName flutterVersionName
    testInstrumentationRunner "android.support.test.runner.AndroidJUnitRunner"
}
```

The first change alone will solve the build errors, but I was frustrated with the massive increase in size of my application when I was only using a small portion of the Firebase feature set. There are two additional flags available to reduce the size of the `.dex` files and resulting `.apk` file. The `shrinkResources` flag removes unnecessary code that comes by default with the `google-services` package and the `minifyEnabled` just removes any dead code.

```
buildTypes {
    release {
        // TODO: Add your own signing config for the release build.
        // Signing with the debug keys for now, so `flutter run --release` works.
        signingConfig signingConfigs.debug

        shrinkResources true
        minifyEnabled true

    }
}
```

The mix of these three flags reduced the size of my application and got it back to being able to compile.

#### Resulting Gradle File

The `./android/` Gradle config file was not changed at all, it was the same as in the original example. Here is the modified `./android/app/` Gradle file:

```
def localProperties = new Properties()
def localPropertiesFile = rootProject.file('local.properties')
if (localPropertiesFile.exists()) {
    localPropertiesFile.withReader('UTF-8') { reader ->
        localProperties.load(reader)
    }
}

def flutterRoot = localProperties.getProperty('flutter.sdk')
if (flutterRoot == null) {
    throw new GradleException("Flutter SDK not found. Define location with flutter.sdk in the local.properties file.")
}

def flutterVersionCode = localProperties.getProperty('flutter.versionCode')
if (flutterVersionCode == null) {
    flutterVersionCode = '1'
}

def flutterVersionName = localProperties.getProperty('flutter.versionName')
if (flutterVersionName == null) {
    flutterVersionName = '1.0'
}

apply plugin: 'com.android.application'
apply from: "$flutterRoot/packages/flutter_tools/gradle/flutter.gradle"

android {
    compileSdkVersion 28

    lintOptions {
        disable 'InvalidPackage'
    }

    defaultConfig {
        applicationId "com.jonathanbayless.autodo"
        minSdkVersion 16
        targetSdkVersion 28
        multiDexEnabled true
        versionCode flutterVersionCode.toInteger()
        versionName flutterVersionName
        testInstrumentationRunner "android.support.test.runner.AndroidJUnitRunner"
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig signingConfigs.debug
            shrinkResources true
            minifyEnabled true
        }
    }
}

flutter {
    source '../..'
}

dependencies {
    testImplementation 'junit:junit:4.12'
    androidTestImplementation 'com.android.support.test:runner:1.0.2'
    androidTestImplementation 'com.android.support.test.espresso:espresso-core:3.0.2'
}

apply plugin: 'com.google.gms.google-services'  // Google Play services Gradle plugin
```
