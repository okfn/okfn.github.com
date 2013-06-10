---
layout: post
author: Gregor Aisch
lightbox: true
title: Speeding Up Your PyBossa App
username: gka
---

Thanks to the free [crowd-crafting](http://crowdcrafting.org) tool [PyBossa](http://dev.pybossa.com/), nowadays the biggest challenge for successful crowd-sourcing is engaging users for participating in tasks, and to keep that motivation at a high level over time. Therefor the user experience of crowd-sourcing apps plays a crucial role.

After participating in quite a few tasks myself, I found that the loading time in between two tasks was the most annoying thing. Doing crowd-sourcing tasks often feels like doing something stupid, and you really want to get things done as fast as possible. Sometimes it needs just a single click to solve a task, but then it takes seconds to load the next one.

This is because all existing apps where designed in a synchronous fashion. The client requests a new task and presents it to the user as soon as it has been loaded. *After* the user has solved the task, the result is submitted and *after* the result has been stored a new task is requested and so on.

<a rel="lightbox" title="Process flow in current PyBossa apps" href="/img/pybossa-workflow-old.png">![current workflow](/img/pybossa-workflow-old.png)</a>

 (click to enlarge)

Some apps even need to load additional information, such as images or data coming from external APIs. This loading time accumulates quickly, and will most probably lower the motivation of your users!

## Pre-loading subsequent tasks == magic

The idea for reducing the loading time is actually pretty simple: We let the app load the next task *while* the user is solving the current one. This results in a parallel process as described in the following chart:

<a rel="lightbox" title="Process flow in current PyBossa apps" href="/img/pybossa-workflow-new.png">![proposed workflow](/img/pybossa-workflow-new.png)</a>

To implement this in PyBossa, we needed to change the PyBossa API a little bit (thanks @[teleyinex](https://github.com/PyBossa/pybossa/commit/4f5bdd4698a1ac21f3021347cd9ec08e68f18bdc)). Before that change consecutive calls to the [newtask endpoint](http://pybossa.readthedocs.org/en/latest/model.html#requesting-a-new-task-for-current-user) would return the same task again and again, until the user has solved it. Now with the newly introduced parameter **offset** you can request the next tasks in line.

Another requirement for pre-loading of tasks is to keep the entire app on one page as otherwise the cached task would be lost. The rest of this post describes a smart way to implement this using [jQuery.Deferred](http://api.jquery.com/category/deferred-object/).

## Smart implementation using jQuery.Deferred

Looking from our PyBossa app, the pre-loading of the next task and the user solving the current one are two asynchronous actions running in parallel. We have to wait until both are completed before we can proceed to the next task.

[This article](http://eng.wealthfront.com/2012/12/jquerydeferred-is-most-important-client.html) reminded me of a smart way to implement this using jQuery.Deferred. The following function shows everything we need for our main loop.

{% highlight javascript %}
function run(task) {
    var nextLoaded = loadTask(1),
        taskSolved = presentTask(task);
    $.when(nextLoaded, taskSolved).done(run);
}
{% endhighlight %}

To start the loop, we need to load the first task and pass it to run.

{% highlight javascript %}
loadTask().done(run);
{% endhighlight %}

Now let's take a look at ``loadTask()``. The parameter offset is passed to the API. After the task and everything else we might need is loaded we mark the deferred as resolved and pass the task over the done handler. Finally we return a 'locked' version of the deferred object.

{% highlight javascript %}
function loadTask(offset) {
    offset = offset || 0;
    var taskLoaded = $.Deferred();
    $.getJSON('/api/app/'+appid+'/newtask?offset=' + offset, function(task) {
        // load more data if you need
        // and then, resolve Deferred
        taskLoaded.resolve(task);
    });
    return taskLoaded.promise();
}
{% endhighlight %}

We can use exactly the same method to model the user action. Therefor ``presentTask()`` will returned a deferred object, too. It gets resolved as soon as the user has solved the task and the answer is correctly submitted to PyBossa.

{% highlight javascript %}
function presentTask(task) {
    var taskSolved = $.Deferred();
    // update presenter html
    $('.question').html(task.question);
    // wait for user action
    $('button.submit').off('click').on('click', function() {
        var answer = { foo: "Bar" }; // fetch answer from UI
        pybossa.saveTask(task.id, answer).done(function() {
            taskSolved.resolve();            
        });
    });
    return taskSolved.promise();
}
{% endhighlight %}

And that's it.

This method will significantly speed up your PyBossa app, especially if you need to fetch data from third party APIs. Remind yourself that even a speedup of a few seconds is a huge benefit for your voluntary users, as they are likely to go through this process quite often. And you really don't want to waste their time, do you?

_Update:_ Why not try the [FlickrPerson demo app the speedy way](http://crowdcrafting.org/app/flickrperson2/newtask)?

