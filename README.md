This is jekyll-based site for running http://okfnlabs.org/.

## Instructions

### Adding your member info

To add yourself to the member list you need to add a small bit of info to a file in the members/_posts folder of the [labs site repo][repo]. Step-by-step:

[repo]: https://github.com/okfn/okfn.github.com

1\. Fork the [repo][]

2\. Create a file in members/_posts/yyyy-mm-dd-{your-handle/username}.html

3\. Put in the file this info about yourself:

    ---
    layout: person
    handle: {your-unique-username}
    name: {your-full-name}
    area: {a terse description of your primary area of activity e.g. Software Developer, Data Wrangler, Blogger ...}
    github: {github-username}
    twitter: {twitter-username-not-url}
    web: {home page}
    img: {a link to a small square image around 200px by 200px - your gravatar is perfect}
    place: {e.g. London, UK or Tokyo, Japan}
    ---

    Free text description - you can use html!

Here's an example:

    ---
    layout: person
    handle: rgrp
    name: Rufus Pollock
    area: Data Wrangler
    github: rgrp
    twitter: rufuspollock
    web: http://rufuspollock.org/
    img: /img/people/rgrp.png
    place: London, UK
    ---

    Rufus is ... {description follows}

4\. Save the file. Commit. Submit a pull request.

