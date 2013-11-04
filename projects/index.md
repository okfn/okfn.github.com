---
title: Labs Projects
layout: default
bodyclass: code
---

# Labs Projects

<div class="results">
  {% for project in site.categories.projects %}
    <div class="record">
      <div class="image">
        {% if project.imageurl %}
          <img src="{{project.imageurl}}" alt="{{project.title}}" />
        {% endif %}
      </div>
      <h2>
        <a href="{{project.projecturl}}" target="_blank">{{project.title}}</a>
      </h2>
      {% if project.author %}
        <h2>
          <small>by <a href="{{project.authorurl}}" target="_blank">{{project.author}}</a></small>
        </h2>
      {% endif %}
      <div class="rhs">
        <p class="description">{{project.content}}</p>
        {% if project.github_repo %}
          <p><img src="/img/github.png" /> <a href="https://github.com/{{project.github_user}}/{{project.github_repo}}">Github</a></p>
          <iframe src="http://ghbtns.com/github-btn.html?user={{project.github_user}}&repo={{project.github_repo}}&type=watch&count=true"
              allowtransparency="true" frameborder="0" scrolling="0" width="110" height="20"></iframe>
          <iframe src="http://ghbtns.com/github-btn.html?user={{project.github_user}}&repo={{project.github_repo}}&type=fork&count=true"
              allowtransparency="true" frameborder="0" scrolling="0" width="95" height="20"></iframe>
        {% endif %}
      </div>
    </div>
    <div style="clear: both;"></div>
  {% endfor %}
</div>
