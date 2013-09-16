---
layout: post
author: Michael Bauer
title: Using d3 as user input
username: mihi
---

Recently, I was at [Chicas Poderosas](http://chicaspoderosas.org/) in
Bogota - the three day event featured talks on two days and a hackday on
the last. During the event I was approached by
[Natalia](http://cuyabracadabra.wordpress.com/) an industrial designer who
introduced a project of hers:
[Electrocardiogr_ama](http://cuyabracadabra.wordpress.com/electrocardiograma-%C2%B7-%C2%B7-%C2%B7/).
She wanted to build an app with similar features and pitched it on the
hackday.  I've ended up working with Natalia and Knight/Mozilla Opennews Fellow Sonya
Song on the project.

Using [D3](http://d3js.org) for visualizing the output was quite straigt
forward. But then, we wanted to have some easy to use user input - we
graded mood on a scale, but how to represent it best? Numbers from 1-x as
they are often used didn't seem very intuitive (is 1 best or 10 best?).
After thinking about it for a while we had an idea of using a smiley as a
slider - the smiley would smile if happy and look sad if dragged to a sad
status.

see it working here (try draging it up and down):

<iframe src="http://sonya2song.github.io/moodlog/input.html" width="250"
height="350" frameborder="0"></iframe>

To read it's value we use the following code.

<pre><code class="javascript">
function sbmt() {
  smilescale=d3.scale.linear()
    .domain([50,250])
    .range([1,10])

  note=document.getElementById("note").value;
  d3.select("svg > g#smiley").each(function(d) {
    score=smilescale(d.y);
    // XHTTP Post Request follows here
    })
}
</code></pre>

If you want to see it in action: try out the
[Moodlog](http://moodlogr.appspot.com) app, or check out the
[github repo](https://github.com/sonya2song/moodlog). 

User inputs are often not very intuitive, let's make them better!
