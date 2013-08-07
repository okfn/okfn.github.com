---
layout: post
author: Daniel Lombraña González
title: Mapping Antimatter tracks with CrowdCrafting.org
username: teleyinex
---

This last weekend, CERN hosted a very special event: [the 2nd CERN Summer Student Webfest](http://www.citizencyberscience.net/wiki/index.php?title=Main_Page) organized by the [Citizen Cyberscience Centre](http://www.citizencyberscience.net/).

![CERN Summer Student Webfest logo](http://www.citizencyberscience.net/wiki/images/1/1b/Cernwebfest.png)

The Webfest invites CERN summer students to participate in a 48 hours marathon hacking new applications, tools, games, etc. about physics. This year, I participated and worked in a very interesting one: [The Antimatter project](http://crowdcrafting.org/app/antimatter/)

With a team of around 8 persons, we divided the work in different areas and learned about the project and the goals for the CrowdCrafting application.

Michael Doser from CERN and the spokesperson from the [AEgIS experiment](http://aegis.web.cern.ch/aegis/), is studying antimatter.

<iframe width="640" height="360" src="//www.youtube-nocookie.com/embed/8PXSQjjsPUo?rel=0" frameborder="0" allowfullscreen></iframe>

But, what is antimatter? 
----------------------------
The observable Universe is composed almost entirely of matter but we can produce stuff called antimatter in the lab. Antimatter is material composed of antiparticles. So for example, a positron (the antiparticle of an electron) combines with an antiproton to form an antihydrogen atom.

Antiparticles have the same mass as normal matter particles but the opposite charge. When an antiparticle collides with an ordinary matter particle they both obliterate to emit radiation and some other particles - this is called annihilation.

Because of Einstein's weak equivalence principle (gravity doesn't depend on composition) antiparticles should interact gravitationally just like particles of ordinary matter - and that's what scientist's expect to observe - but if they don't then Einstein was wrong...

What's the experiment?
----------------------

The Antihydrogen Experiment: Gravity, Interferometry, Spectroscopy (AEgIS) experiment at CERN shoot antihydrogen atoms horizontally, whereupon they fly (and drop) until they hit a wall made of matter - any matter will do, silicon, silver, paper,... - and annihilate there

On hitting the wall, the antihydrogen annihilates with a nucleus of the wall to produce mostly pions and some other particles - which we'll call starburst.

The starburst travel through a special gel called an emulsion and we can see its tracks. If we trace these tracks to their point of origin then we know exactly where annihilation occurred.

Then as we know the starting position of the antiparticles, the distance they travelled to the point of annihilation and how much they dropped - we can work out how far the antiparticle fell during its journey.

Then we can figure out how antimatter interacts gravitationally.

![AEgIS Experiment Installation](http://i.imgur.com/uVVjKzD.jpg)

Michael Doser gave us access to a set of 99 areas photographed with a microscope, that allows us to see tracks and the starbursts. Each of the areas have 40 pictures. These pictures cover the same area but at a differen depth.

As we discussed about the project, we decided to create a "movie style" task, where the CrowdCrafting application will be playing in a loop all the images for the same area. Then, we will allow the volunteers to map the tracks using their mouse as in any image software. The coordinates of the tracks, starting and ending points, will be saved, and we will use those points to render in real time a 3D model of the tracks thanks to WebGL.

We divided the work between different groups, and we worked together in the different areas:
* Creating of tasks based on the data
* 2D movie style using HTML5 canvas feature
* 3D model of tracks using HTML5 WebGL
* Physics description of the problem and tutorial.

For the 2D Canvas solution we decided to use the popular [Kinetic.JS](http://www.kineticjs.com/) library. This library is very versatile as you can not only render images in the 2D canvas, but also paint lines. 

For the 3D model we decided to use the popular [Three.JS library](http://threejs.org/). We created a 3D area using the Tron colors palette to draw the reported tracks by the users.

Then, we have another group that worked really hard in explaining the physics of the experiment and the tutorial. We even created a [Mozilla Webmaker project](https://juanracasti.makes.org/popcorn/1adt) about it.

At the end of Sunday we had a [fully operational prototype](http://crowdcrafting.org/app/antimatter) that allows you to actually track antimatter in CrowdCrafting:

![Screenshot](https://github-camo.global.ssl.fastly.net/9a7c3a33b5470bf0c42f19f74a7443adf0e116ef/687474703a2f2f692e696d6775722e636f6d2f716b32393067352e706e67)

From here I would like to thank to all the team members because the actually loved the project and push it to the next level. This efforts will help other CrowdCrafting/PyBossa developers to use the new HTML5 Canvas and WebGL features developed for this application, as the source code is already available in Github and can be used as a template for any CrowdCrafting/PyBossa application.

If you want, you can follow the [Github repository](https://github.com/CERNSummerWebfest/antimatter) development of the project.
