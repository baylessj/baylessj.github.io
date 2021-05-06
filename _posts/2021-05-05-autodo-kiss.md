---
title: Starter's Web App Stack: K.I.S.S.
---

I've spent the last couple of years working in the evenings on my side project, [autodo](). This really is not a very complicated app, but I've taken a long and winding path towards making it work. I started out with a mobile app, only to realize that I needed a proper backend to persist the data across devices. 

I then looked online for an ideal stack for a first-timer's web app. These resources largely said "Build with what you know", which wasn't much help for someone who had never built a web app before. The few suggestions I saw pointed to a separated frontend and backend, with React and some sort of REST API on the backend. I used Django to use my python knowledge. I attempted to deploy this setup on a Digital Ocean VPS and found it to be a mess. I struggled with Apache configs, SSL certificates, and REST API interaction with the frontend. I gave this up after about 6 months without managing to make a working app.

In the last few months, I have started rebuilding autodo from scratch. This time around, I am trying to reduce the number of frameworks and complicated pieces to the app. This involves two major changes -- using Django as the MVC framework it was intended to be, and deploying on Heroku. Many of my earlier troubles were with DevOps things, and Heroku manages that for
me now. Using Heroku was only possible (with my level of knowledge, anyhow) by making the switch to Django only. This means that I miss out on some of the nice UI benefits of React, but getting a working app out in the world without a huge operatioms headache is worth it.



