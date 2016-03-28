 ---
 layout: post
 author: {Alexandre Bonnasseau}
 username: lexman
 title: {Tools for datapackages : make vs tuttle}
 ---
When crafting data from some other data, like packaging public data, using the good tools 
can really ease development process and reliability of the data. 

The venerable ``make`` which have already been used for decades to build software, is a very good option as advocated by Mike Bostock's in his [blog](https://bost.ocks.org/mike/make/). 

## A state-of-the-art Makefile

Let's take an example with crafting [geo-countries](http://github.com/datasets/geo-countries) datapackage. We need to download data from NaturalEarth, extract the zip, convert it to json with ogr (the ''swiss-army-knife'' of maps), and rename a column. Following Mike Bostok's instructions, here's an appropriate ``Makefile`` (that should lie the ``scripts`` folder of the project):

    all: ../data/countries.geojson
    
    ne_10m_admin_0_countries.zip:
    	wget http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/10m/cultural/ne_10m_admin_0_countries.zip

    ne_10m_admin_0_countries.README.html ne_10m_admin_0_countries.VERSION.txt ne_10m_admin_0_countries.dbf ne_10m_admin_0_countries.prj ne_10m_admin_0_countries.shp ne_10m_admin_0_countries.shx: ne_10m_admin_0_countries.zip
    	unzip ne_10m_admin_0_countries.zip

    ne_10m_admin_0_countries.geojson: ne_10m_admin_0_countries.dbf ne_10m_admin_0_countries.prj ne_10m_admin_0_countries.shp ne_10m_admin_0_countries.shx
    	ogr2ogr -select admin,iso_a3  -f geojson ne_10m_admin_0_countries.geojson ne_10m_admin_0_countries.shp
        
    ../data:
    	mkdir ../data

    ../data/countries.geojson: ne_10m_admin_0_countries.geojson ../data
    # Change the name of the fields after conversion
    	cat ne_10m_admin_0_countries.geojson | sed 's/"admin": /"name": /g' | sed 's/"iso_a3": /"ISO3166-1-Alpha-3": /g'  > ../data/countries.geojson


If you're not familiar with Makefiles, the last section reads : "When both files ``ne_10m_admin_0_countries.geojson`` and ``../data`` are available, you can run command ``cat ne_10m_admin_0_countries.geojson | sed 's/"admin": /"name": /g' | sed 's/"iso_a3": /"ISO3166-1-Alpha-3": /g'  > ../data/countries.geojson``
and it will produce file ``../data/countries.geojson``". ``Make`` deduces the commands to be run, starting with the ones where everything is available, until it produces *target* ``all``.


We achieve two very important goals with this ``Makefile`` :
* it covers the whole process even the download part. It's so easy to forget wether we have downloaded ``ne_10m_admin_0_countries.zip`` or ``ne_110m_admin_0_countries.zip`` when it is done by hand. But now every thing is written down so we can keep track of it in our source repository (like git), even if we change our mind.
* Running ``make`` checks the date consistency of the files. That means that if Scottland has gone independent in 2015 it would have created a new country, that Natural Earth would have added. Now you can download the updated version of ``ne_10m_admin_0_countries.zip``. When running ``make`` again, it would notice that the unziped files like ``ne_10m_admin_0_countries.dbf`` and so on are older than their source, so the ``unzip`` command has to be run again ! And so on because ``ne_10m_admin_0_countries.geojson`` would not be up to date, until every depending file is updated.


Even if this is a great improvement over *running-all-the-commands-manually-and-don't-remember-them* as much *custom-script-that-must-start-from-scratch-every-time*, it is not enough to have a fluid and reliable development experience.

## Improve collaboration with ``tuttle``

Before we see in detail two major improvements, let's see the same workflow written in a ``tuttlefile`` (still in folder ``scripts``) :


    file://ne_10m_admin_0_countries.zip <- http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/10m/cultural/ne_10m_admin_0_countries.zip
        wget http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/10m/cultural/ne_10m_admin_0_countries.zip

    file://ne_10m_admin_0_countries.README.html, file://ne_10m_admin_0_countries.VERSION.txt, file://ne_10m_admin_0_countries.dbf, file://ne_10m_admin_0_countries.prj, file://ne_10m_admin_0_countries.shp, file://ne_10m_admin_0_countries.shx <- file://ne_10m_admin_0_countries.zip
        unzip ne_10m_admin_0_countries.zip

    file://ne_10m_admin_0_countries.geojson <- file://ne_10m_admin_0_countries.dbf, file://ne_10m_admin_0_countries.prj, file://ne_10m_admin_0_countries.shp, file://ne_10m_admin_0_countries.shx
        ogr2ogr -select admin,iso_a3  -f geojson ne_10m_admin_0_countries.geojson ne_10m_admin_0_countries.shp
        
    file://../data <-
        cd ..
        mkdir data
        
    file://../data/countries.geojson <- file://ne_10m_admin_0_countries.geojson, file://../data
    # Change the name of the fields after conversion
        cat ne_10m_admin_0_countries.geojson | sed 's/"admin": /"name": /g' | sed 's/"iso_a3": /"ISO3166-1-Alpha-3": /g'  > ../data/countries.geojson

Looks familiar ? 

It is very close to Makefile, except for urls everywhere. Because ``tuttle`` aims at giving a url to every bit of data, in order link them together.

You can see the first section of the tuttlefile clearly states the dependency of file ``ne_10m_admin_0_countries.zip`` to url ``http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/10m/cultural/ne_10m_admin_0_countries.zip``. 
This means that when the online list of countries change, no unusual action is required. You just have to execute ``tuttle run`` as *if you where building the data for the first time*. It will notice the source url has changed and will reprocess dependencies accordingly.


The other difference with ``make`` is not in the syntax, it's in how it deals with changes in the ``tuttlefile``. If you ever worked with the ``ogr2ogr`` command line tool, you know it's impossible to make it right the first time. But if you change the command in a ``Makefile``, unfortunately running ``make`` again won't update the data because the date of the file ``ne_10m_admin_0_countries.geojson`` seem coherent.

To improve this, ``tuttle`` reacts to changes in every command. When you run it, it will first roll back as the previous command as if had never run by deleting whatever data has been produced. Then it will run the updated ogr2ogr command. That's very handy when prototyping because you want focus on your code without side effects caused by remaining data. 

This feature also proves really useful when working in a team. With ``make``, if you change the makefile, you need to send an mail to all your team with instructions of how to clean the workspace (ie : "Please remove file ../data/countries.geojson because I have changed the ogr2ogr command"), and hope nobody misses it because it would lead to undebuggable behaviour. On the other hand ``tuttle`` guaranties the data corresponds exactly the ``tuttlefile``, so you can safely share or merge changes with your fellow contributors.


## Conclusion

If you put both improvements over ``make`` together (remote dependencies and reliably reprocess what have changed), we can set up a system that automatically updates datapackages when either the original data changes or when someone modifies the source code. Pretty cool, huh ?

I hope I've convinced you of the advantages of tuttle for collectively crafting data. If you're interested, the best way to learn more about inline languages, url to databases or online resources, is to read the [main tutorial](https://github.com/lexman/tuttle/master/doc/tuttorial).


And one more thing about the sugar syntax you can expect... You could simplify the first section of the ``tuttlefile`` in only one line :

    file://ne_10m_admin_0_countries.zip <- http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/10m/cultural/ne_10m_admin_0_countries.zip ! download
