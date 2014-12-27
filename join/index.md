---
title: Join and Get Involved
layout: default
bodyclass: join
---

<h1>Join the Community</h1>

<div class="row">
  <div class="span8">
    <p>We're a collaborative community which anyone can join &ndash; new participants and contributors are made <em>very</em> welcome!</p>

    <h2>Just hangout (or observe from a distance!)</h2>
    <p>That's OK, we understand you may want to get a feel of how things operate before you dive in ;-0. If you want to start out dipping your toe in the water we suggest:</p>

    <ul>
      <li><a href="https://twitter.com/intent/user?screen_name=OKFNLabs">Following us on twitter</a> &ndash; and send us a message!</li>
      <li><a href="/contact/">Joining the mailing list</a> &ndash; and say hello, we'd love to hear from you!</li>
    </ul>

    <p>You can also get a sense of what folks are up to by taking a look at the <a href="/projects/">Projects</a> or the <a href="https://github.com/okfn/ideas/issues">Ideas List</a> (especially the <a href="https://github.com/okfn/ideas/issues?labels=In+progress">in progress ones</a>).</p>

    <h2>Jump straight in!</h2>

    <p>Why not just jump straight in :-) &ndash; there's loads of cool stuff to do! Not sure about something, or just want to chat with someone just <a href="/contact/">get in touch</a>. <strong>Already have something you're working on you'd like to share? We'd be delighted to hear about it &ndash; hop on the <a href="/contact/">mailing list or send us a tweet</a></strong>.</p>

    <div class="well">
      <h3>Some Simple Stuff</h3>
      <p>We've got a variety of simple things we'd like to do to improve this website and our community.</p>
      <p><a href="https://github.com/okfn/okfn.github.com/labels/Easy">Check out this list here &raquo;</a></p>
    </div>
    <div class="well">
      <h3>Data Wrangling</h3>
      <p>For example, <a href="http://community.openspending.org/contribute/data/">Get government finances into Openspending</a> &ndash; turn ugly government data into clean spreadsheets and beautiful visualizations.</p>
      <p>Take a <a href="http://schoolofdata.org/">course at the School of Data</a> &ndash; or <a href="http://schoolofdata.org/data-expeditions/guide-for-guides/">help run one</a>!</p>
      <p>Or, take a <a href="https://github.com/okfn/ideas/issues?labels=Data+Wrangling&sort=updated&state=open">look at our data wrangling related ideas</a></p>
    </div>
    <div class="well">
      <h3>Coding, Visualizing, Designing</h3>
      <p>The classics! We love data tools and beautiful infographics. Come help make more and improve what <a href="/projects/">we have</a>! If you're stuck for inspiration you can browse our <a href="/ideas/">list of ideas for new tools, apps and visualizations</a> &ndash; and remember, <a href="/ideas/#new">new ideas are very welcome</a>!</p>
    </div>
    <div class="well">
      <h3>Outreach and Engagement</h3>
      <p>Help run and attend events including hangouts and open data parties, write and edit posts for the blog, evangelize and engage around our projects.</p>
      <p>If you're interested please <a href="/contact/">give us a bell  (email may be best here!)</a>.</p>
    </div>

  </div>

  <div class="span4">
    <h3 style="margin-top: 0;">Events &amp; Meetups</h3>
    <p>There are lots of opportunities to meet up with others both online and in person. Listed here are a few near-term ones &ndash; you can find more on the <a href="/events/">events page</a>.</p>
    {% include events.html %}

    <h2 id="get-recognized">Get Recognized!</h2>
    <p>As a member, your contributions will, in part, be recognized via a badge associated with your username.  Currently, we are issuing the following badges:</p>
    {% for badge in site.data.badges %}
    <div class="badgeholder">
      <div id="{{ badge.first.first }}"><span class="icon-{{ badge.first | map: 'icon' }}"></span></div>
      <div>{{ badge.first | map: 'text' }}</div>
    </div>
    <p>{{ badge.first | map: 'description' }}</p>
    {% endfor %}

  </div>
</div>
