---
layout: post
author: Daniel Lombraña González
lightbox: true
title: PyBossa.JS or how you can easily create new PyBossa applications
username: teleyinex
---

In the last weeks we have been working hard in order to make easier to develop new PyBossa applications. For this reason, we are happy to announce a new version of PyBossa.JS. This new version introduces several improvements:

 * **Creating an app is much easier!** You only have to override two methods: pybossa.taskLoaded and pybossa.presentTask to fit your app, and call pybossa.run('your-app-slug').
 *  **Pre-loading tasks by default!** Now your app could improve its performance, as the next task for the user will be loaded in the background for you while the user stills solving the first one!
 *  **Automatically update the task URL**. The library will change the browser's URL to the current task automatically, so using services like Disqus for comments is really simple (check the updated version of [Flickr Person Finder](http://crowdcrafting.org/app/flickrperson) for more details!).

As a result of this new version, there are at least two applications using the new PyBossa.JS version:

  * [Flickr Person Finder](http://crowdcrafting.org/app/flickrperson) has been updating, using this new set of features. If you try the application you will see that loading the next task (in this case an image which is usually 1024x1024px big) is almost instantly. Additionally, the app shows how you can use the Disqus service to allow your users to add comments for each task, but only loading them when the user wants.
  * [The Face We Make](http://crowdcrafting.org/app/thefacewemake) is a new application where you have to guess the emoticon that a person is representing in a photo. This app is a joint effort with the official [The Face We Make](http://thefacewemake.org/about/) project by [Dexter Miranda](http://dxtr.com/) and [Daniel Lombraña González](http://daniellombrana.es). The app has been updated for using the new pre-loading of tasks, and once you have completed all of them (only 10 photos!) show you your results, in other words, how many of your guesses are right/wrong.

Finally, we have also added the "missing features" that allow you to create an application without using the API. Right now, you can create an application using only the web forms for creating the application: 
<a rel="lightbox" title="Web form for creating an application" href="/img/pybossa-create-app.png">![Web form for creating an app](/img/pybossa-create-app.png)</a>

You can also add and work in the task presenter (we have included the [CodeMirror plugin](http://codemirror.net), so you will see how it looks your code as you type it!): 
<a rel="lightbox" title="Web form for editing the task presenter" href="/img/pybossa-task-presenter-editor.png">![Web form for editing the task presenter](/img/pybossa-task-presenter-editor.png)</a>

As well as importing the tasks via a CSV file importer (you can even import the CSV file from a Google Spreadsheet!):

<a rel="lightbox" title="Web form for importing tasks from a CSV file" href="/img/pybossa-csv-import.png">![Web form for importing tasks from a CSV file](/img/pybossa-csv-import.png)</a>

The documentation has been updated in order to reflect this new features, and as a result you should be able to write an application really fast. However, we are far from perfect, so any feedback that you can give us will be really good! Thus, please, leave in the comments your feedback or send us an e-mail to info@pybossa.com. We will be more than happy to hear your thoughts on PyBossa!
