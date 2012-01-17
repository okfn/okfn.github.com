CSS and LESS files
==================
The CSS files in this folder are included on the actual page by ../style.css.

Static CSS files
----------------
bootstrap.css     > Twitter Bootstrap standard edition
carousel.css      > Customised version of the (bloated,awful) css file that ships with jCarousel
                    which we use on the front page.
okfn.css          > Auto-generated file. Do not modify this by hand.

DO NOT MODIFY OKFN.CSS BY HAND!
===============================
Did you get that? Good. It is compiled from various .less files.

The LESS files
--------------
okfn.css is not a handwritten CSS file though. It is compiled by the lessc compiler.

To update it, modify::
  okfn.less          > To change the core page structure
  okfn-content.less  > To change the style of one page's content
  wordpress.less     > To change the way we render Wordpress' auto generated HTML.
  tom-mixins.less    > If you are Tom, and you want to add a new clever function to the library.

Then run::
  lessc okfn.less

... and the Less compiler will do the hard work for you.
To read about Less and get hold of that compiler, visit http://lesscss.org/.
