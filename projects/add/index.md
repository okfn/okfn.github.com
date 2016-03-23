---
title: Projects - Add a project
layout: two-column
bodyclass: code
---

# Add a project

Criteria for listing a project on Labs:

* Fit with [the set of general Labs community principles](/about/#principles).
  These aren't super strict but we suggest you read these through and consider
  whether your project fits (or what you could change to make it fit)
* You are an "Official Contributor" - to list a project as a Labs project you
  need to be an [Official Contributor][contributor]. We do make exceptions so
  if you think your project is super-deserving of this privilege you can [get
  in touch][contact] -- or even just submit the pull request and we can
  discuss there

[contact]: /contact/
[contributor]: /about/#contributors


## Steps to add a project

To add a project, you should have [signed up as a labs
member](/members/signup/).  We also strongly recommend [joining the mailing
list and following Labs on twitter](/contact/).

Then, two small additions need to be made to the
[Labs Github repository](https://github.com/okfn/okfn.github.com/) (thereby to this website).
This can be done in one of two ways:


- the geek route
- the non-geek route



## Geek Route

1. Fork this site's [repository](https://github.com/okfn/okfn.github.com/)


2. Create a file at this location

        projects/_posts/yyyy-mm-dd-{slug}.html

   where yyyy-mm-dd is the date you added the project. As an example, if
   your project’s slug were `awesome-data-visualizer` and today's date were
   2013-05-17 you would create

        projects/_posts/2013-05-17-awesome-data-visualizer.html


3. To the file add a project title and a general description. Here's what it should look like:

        ---
        title: {the project title e.g. Awesome Data Visualizer} [REQUIRED]
        ---

        A brief description of the project. You can use html (or markdown - if
        markdown please make sure the file you create to hold the info (see
        below) uses .md extension rather than .html)!

        Things to include are:

        - What is it
        - Who is it for?
        - What problem does it solve?
        - How someone could contribute

    Here's an example:

        ---
        title: Kartograph
        ---

        Kartograph is a simple and lightweight framework for building interactive
        map applications without Google Maps or any other mapping service. It was
        created with the needs of designers and data journalists in mind.


4. Add a new row to the [_data/projects.csv](https://github.com/okfn/okfn.github.com/blob/master/_data/projects.csv) CSV file, right below the header line. Edit the row to include
various pieces of information about your project. If you look at the information provided for other 
projects this should guide you on how to add yours. Here's an overview of some of the CSV file
fields:


    {: .table .table-striped }
    CSV field | Description
    --- | --- | ---
    **``title [REQUIRED]``**     | ``The title field should exactly match the title speficied in the file created in step 2``
    **``slug [REQUIRED]``**      | ``URL-friendly version of the title e.g. awesome-data-visualizer``
    **``permalink [REQUIRED]``** | ``Should take the form /projects/{slug}/index.html, where {slug} is the value of the slug field``
    ``projecturl``           | ``URL of an external project webpage e.g. http://awesomedatavisualizer.org``
    ``imageurl``             | ``URL to a project image or logo of around 235px by 150px``
    ``tags``                 | ``List of relevant tags e.g. [django, google spreadsheets]``
    ``tagline``              | ``One-liner description of project``
    ``author``               | ``Author(s) name(s) e.g. Joe Bloggs``
    ``maintainers``          | ``List of labs username(s) of those who maintain the project``
    ``contributors``         | ``List of labs username(s) of those who contribute to the project``
    ``github_repo``          | ``The github repo name e.g. awesome-data-visualizer``
    ``github_user``          | ``The github user who owns the repository e.g. okfn``
    ``language``             | ``List of languages the project uses e.g. [python, javascript]``
    ``type``                 | ``List from the following project types: [library, data, webapp, running service, tool]``


5. Save your changes, commit and push to your fork


6. Submit a pull request


## Non-geek Route

Sent an email to us at labs@okfn.org, with the as much of the following information as is available:

1. The title of the project
2. A link to the project
3. A link to the git repository
4. The git repository owner (e.g. github username)
5. The author(s) and contributor(s) name(s)
6. The maintainer(s) name(s)
7. The languages used by the project (e.g. python, javascript)

