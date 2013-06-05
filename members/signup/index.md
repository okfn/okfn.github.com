---
title: Members - Signup
layout: two-column
bodyclass: members
---

# Sign up as a Labs Member

Anyone may sign up as a Member &ndash; just follow the sign-up steps below.
Not sure what this Member thing is all about? You can find out [more about
Membership here][members].

[members]: /members/

## Sign-up Steps

Signing up involves a few simple steps that should only take a minute or
two. The key part is providing some information so that you can be listed
on [on the members page][members].

We also strongly recommend [joining the mailing list and following Labs on twitter](/contact/).

1. Put together a brief bit of info about yourself. It has 2 parts, some
   structured data of form `item: value` at the top followed by some free text
   (your bio). Here's what it should look like (all items are optional except
   those marked as required):

        ---
        layout: person [REQUIRED]
        username: {your-unique-username} [REQUIRED]
        title: {your-full-name e.g. Joe Bloggs} [REQUIRED]
        area: {terse description of your main activity area e.g. Software Developer, Data Wrangler, Blogger ...}
        email: {your.name@website.org}
        github: {github-username}
        twitter: {twitter-username}
        web: {home page}
        img: {a link to a small square image around 200px by 200px - your gravatar is perfect}
        place: {e.g. London, UK or Nairobi, Kenya}
        permalink: /members/{your-username}/index.html [REQUIRED]
        ---

        A paragraph bio or description about yourself and your interests -
        you can use html!

   Here's an example:

        ---
        layout: person
        username: rgrp
        title: Rufus Pollock
        area: Data Wrangler
        email: rufus.pollock@okfn.org
        github: rgrp
        twitter: rufuspollock
        web: http://rufuspollock.org/
        img: /img/people/rgrp.png
        place: London, UK
        permalink: /members/rgrp/index.html
        ---

        Rufus is an avid hacker on small data tools, an enthusiastic collector
        of new datasets and an out-of-hours data investigator. Skills include
        python, javascript, sysadmin and data wrangling.

2. Get this added to the [Labs Github repo][repo] (and thereby to the website).
   There are 2 options:

    * More geeky route: add this info to the repo yourself via fork and pull
      &ndash; instructions below
    * Less geeky route: email it to labs@okfn.org and we'll take care of it for
      you

### Geek Route

This assumes you know how to add stuff to a git repo on github (preferably via fork and pull).

1. We need to add the info above to the [Labs website repo on github][repo]

2. Fork the [repo][]

3. Create a file at this location

        members/_posts/yyyy-mm-dd-{your-handle}.html

   where yyyy-mm-dd is the date you signed up as a member. As an example, if
   your handle were `awesomeusername` and today's date were 2013-05-17 you
   would create

        members/_posts/2013-05-17-awesomeusername.html

4. Add the info you prepared above. Save the file.

5. Commit and push.

6. Submit a pull request

[repo]: https://github.com/okfn/okfn.github.com/

