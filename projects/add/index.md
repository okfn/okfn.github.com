---
title: Projects - Add a project
layout: two-column
bodyclass: code
---

# Add a project

__I actually don’t know how this bit works!__
Rufus or another labs member – do you fancy writing this introductory paragraph?

## Steps to add a project

To add a project, you should first have [signed up as a labs member](/members/signup/).
We also strongly recommend [joining the mailing list and following Labs on twitter](/contact/).

1. Put together a brief bit of info about yourself. It has 2 parts, some
   structured data of form `item: value` at the top followed by some free text
   (your bio). Here's what it should look like (all items are optional except
   those marked as required):

        ---
        layout: project [REQUIRED]
        title: {the project title e.g. Awesome Data Visualiser} [REQUIRED]
        projecturl: {URL of an external project webpage}
        imageurl: {URL to a project image or logo of around 450px by 250px}
        type: {project type e.g. Library, Service, Hack}
        tags: {relevant tags e.g. Javascript}
        author: {author(s) names e.g. Joe Bloggs}
        authorurl: {a URL for the author e.g. joebloggsblogs.com}
        github_user: {the github user who owns the repo e.g. okfn}
        github_repo: {the github repo name e.g. awesome-data-visualiser}
        slug: {a URL-friendly version of the title e.g. awesome-data-visualiser} [REQUIRED]
        permalink: /projects/{slug}/index.html [REQUIRED]
        ---

        A brief description of the project – Who is it for? What problem does it solve?
        you can use html!

   Here's an example:

        ---
        layout: project
        title: Kartograph
        projecturl: http://kartograph.org/
        imageurl: http://kartograph.org/showcase/eastcoast/eastcoast-90dpi_export.png
        type: Library
        tags: Visualization
        author: Gregor Aisch
        authorurl: http://driven-by-data.net/
        github_user: kartograph
        github_repo: kartograph.js
        permalink: /projects/kartograph/index.html
        slug: kartograph
        ---

        Kartograph is a simple and lightweight framework for building interactive
        map applications without Google Maps or any other mapping service. It was
        created with the needs of designers and data journalists in mind.

2. Get this added to the [Labs Github repo][repo] (and thereby to the website).
   There are 2 options:

    * More geeky route: add this info to the repo yourself via fork and pull
      &ndash; instructions below
    * Less geeky route: email it to labs@okfn.org and we'll take care of it for
      you

3. Think about writing a blog to give a longer-form explanation of your project,
   appropriate for a more general audience.

### Geek Route

This assumes you know how to add stuff to a git repo on github (preferably via fork and pull).

1. We need to add the info above to the [Labs website repo on github][repo]

2. Fork the [repo][]

3. Create a file at this location

        projects/_posts/yyyy-mm-dd-{slug}.html

   where yyyy-mm-dd is the date you added the project. As an example, if
   your project’s slug were `awesome-data-visualiser` and today's date were
   2013-05-17 you would create

        projects/_posts/2013-05-17-awesome-data-visualiser.html

4. Add the info you prepared above. Save the file.

5. Commit and push.

6. Submit a pull request

[repo]: https://github.com/okfn/okfn.github.com/
