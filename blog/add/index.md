---
layout: blog
title: Adding Material to the Data Wrangling Blog
---

# Adding a Blog Post

New posts are very welcome. This website is managed as a [github repo][repo] using jekyll and deployed via github pages. You can submit posts in 2 ways:

## Using Google Docs (less geeky)

1. Write up your post in a google doc
   * use markdown or html formatting if you can
2. [Get in touch][contact] (email may be best) and we'll get it up online

## Direct to the repo (more geeky)

Using "Fork and pull" on the [github repo][repo]:

[repo]: https://github.com/okfn/okfn.github.com
[contact]: /contact/

1. Blog posts go in `blog/_post/` folder. As per jekyll convention they should be
   named `yyyy-mm-dd-{slug-for-post}.md`

   If your post is html rather than markdown just change extension from `.md` to `.html`.

2. Add content. The structure should be:

        ---
        layout: post
        author: {Your Name}
        username: [optional] {your-user-name-if-you-have-one}
        title: {Title Like This - this is used both in page and html title}
        ---

        content in html or markdown goes here .... 
   
   Note: make sure your title doesn't contain a colon (:) this will break
   the YAML notation and stop the page from rendering.

3. Add and commit the file then submit the pull request (if you are not pushing direct to the main repo)

