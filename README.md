This is jekyll-based site for running <http://okfnlabs.org/>.

## Adding a Blog Post

Note, if you don't have push access to this repo just fork and pull.

1. Blog posts go in blog/_post/ folder. As per jekyll convention they should be named yyyy-mm-dd-{slug-for-post}.md

If your post is html rather than markdown just change extension from md to html.

2. Add content. The structure should be:

        ---
        layout: post
        author: {Your Name}
        title: {Title Like This - this is used both in page and html title}
        ---

        content in html or markdown goes here ....

3. Add and commit the file and then push.

4. Submit the pull request (if you are not pushing direct to the main repo)


## Adding your member information

See <http://okfnlabs.org/members/signup/>

