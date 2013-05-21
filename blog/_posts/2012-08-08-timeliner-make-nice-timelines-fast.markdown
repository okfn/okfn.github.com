---
layout: post
title: Timeliner - Make Nice Timelines Fast
snapshot: timeliner
author: Rufus Pollock
username: rgrp
---

As part of the [Recline][] launch I put together quickly some very simple demo apps one of which was called Timeliner:

<http://timeliner.reclinejs.com/>

[Recline]: http://reclinejs.com/

This uses the Recline timeline component (which itself is a relatively thin wrapper around the *excellent* [Verite timeline][1]) plus the Recline Google docs backend to provide an easy way for people to make timelines backed by a Google Docs spreadsheet.

As an example of use, I started work on a ["spending stories" timeline about the bankruptcy of US cities (esp in California)][3] as a result of the "Great Recession" ([source spreadsheet][2]). I've also created an example [timeline of major wars][3], a screenshot of which I've inlined:
    
[4]: http://timeliner.reclinejs.com/?backend=gdocs&url=https://docs.google.com/spreadsheet/ccc?key=0Aon3JiuouxLUdFROanhQOVh0NUhyOXNxRDdkc0tEZFE%23gid=0">

[3]: http://timeliner.reclinejs.com/?backend=gdocs&url=https://docs.google.com/spreadsheet/ccc?key=0Aon3JiuouxLUdDQ3QlJhOHJnS2x0NkxibUp1YnYwR1E%23gid=0#explorer

<img src="http://farm9.staticflickr.com/8285/7508403206_420de3ce5e_b.jpg" style="width: 600px;; margin: auto; display: block; margin-top: 20px;" />

[1]: http://timeline.verite.co/
[2]: <https://docs.google.com/spreadsheet/ccc?key=0Aon3JiuouxLUdDQ3QlJhOHJnS2x0NkxibUp1YnYwR1E#gid=0>

### Code

Source code for the Timeliner is here: <https://github.com/okfn/timeliner>

If you have suggestions for improvements, want to see the ones that already exist, or, *gasp*, find a bug please see the issue tracker: <https://github.com/okfn/timeliner/issues>

