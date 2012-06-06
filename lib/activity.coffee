$ = jQuery

GITHUB = 'https://github.com'

util =
  truncate: (s, l=50, append="&hellip;") ->
    o = s[0...l]
    if s.length > l
      o += append
    o

  humanTime: (date) ->
    now = new Date()
    del = now - date
    secs = del / 1000
    if secs < 5
      return "just now"
    if secs < 60
      return "#{Math.floor(secs)}s ago"
    mins = secs / 60
    if mins < 60
      return "#{Math.floor(mins)}m ago"
    hours = mins / 60
    if hours < 24
      return "#{Math.floor(hours)}h ago"
    days = hours / 24
    return "#{Math.floor(days)}d ago"

  parseISO8601: (string) ->
    # The following code adapted from Paul Sowden's ISO8601 conversion code
    regexp = "([0-9]{4})(-([0-9]{2})(-([0-9]{2})" +
             "(T([0-9]{2}):([0-9]{2})(:([0-9]{2})(.([0-9]+))?)?" +
             "(Z|(([-+])([0-9]{2}):([0-9]{2})))?)?)?)?"

    d = string.match(new RegExp(regexp))
    offset = 0
    date = new Date(d[1], 0, 1)
    date.setMonth d[3] - 1  if d[3]
    date.setDate d[5] if d[5]
    date.setHours d[7] if d[7]
    date.setMinutes d[8] if d[8]
    date.setSeconds d[10] if d[10]
    date.setMilliseconds Number("0." + d[12]) * 1000 if d[12]
    if d[14]
      offset = (Number(d[16]) * 60) + Number(d[17])
      offset *= (if (d[15] is "-") then 1 else -1)
    offset -= date.getTimezoneOffset()
    time = (Number(date) + (offset * 60 * 1000))

    out = new Date()
    out.setTime Number(time)

    return out

helpers =
  github:
    who: (c) ->
      """
      <img src='http://www.gravatar.com/avatar/#{c.actor.gravatar_id}?s=20'>
      <a href='#{GITHUB}/#{c.actor.login}'>#{c.actor.login}</a>
      """

    repoUrl: (c) ->
      "#{GITHUB}/#{c.repo.name}"

    repo: (c) ->
      "<a href='#{helpers.github.repoUrl(c)}'>#{c.repo.name}</a>"

    titleForDefault: (c) ->
      "did something"

    titleForCommitCommentEvent: (c) ->
      """
      commented on
      <a href='#{c.payload.comment.html_url}'>#{c.payload.comment.commit_id[...7]}</a>
      on #{helpers.github.repo(c)}
      """

    titleForCreateEvent: (c) ->
      "created a #{c.payload.ref_type} on #{helpers.github.repo(c)}"

    titleForDownloadEvent: (c) ->
      """
      created a new
      <a href='#{helpers.github.repoUrl(c)}/downloads'>download</a>
      on #{helpers.github.repo(c)}
      """

    titleForForkEvent: (c) ->
      "forked #{helpers.github.repo(c)}"

    titleForIssueCommentEvent: (c) ->
      """
      commented on issue
      <a href='#{c.payload.issue.html_url}#issuecomment-#{c.payload.comment.id}'>##{c.payload.issue.number}</a>
      on #{helpers.github.repo(c)}
      """

    titleForIssuesEvent: (c) ->
      "#{c.payload.action} issue <a href='#{c.payload.issue.html_url}'>##{c.payload.issue.number}</a> on #{helpers.github.repo(c)}"

    titleForPullRequestEvent: (c) ->
      "#{c.payload.action} pull request <a href='#{c.payload.pull_request.html_url}'>##{c.payload.pull_request.number}</a> on #{helpers.github.repo(c)}"

    titleForPushEvent: (c) ->
      branch = c.payload.ref.split('/')[2]
      if branch
        "pushed to <strong>#{branch}</strong> on #{helpers.github.repo(c)}"
      else
        "pushed to #{helpers.github.repo(c)}"

    titleForWatchEvent: (c) ->
      "#{c.payload.action} watching #{helpers.github.repo(c)}"

    detailsForDefault: (c) ->
      "More #{c.type} details here &hellip;"

    detailsForCommitCommentEvent: (c) ->
      util.truncate(c.payload.comment.body)

    detailsForCreateEvent: (c) ->
      o = []

      if c.payload.ref_type == "tag"
        o.push "Tagged "
      else
        o.push "Created ref "

      o.push "<a href='#{helpers.github.repoUrl(c)}/tree/#{c.payload.ref}'>#{c.payload.ref}</a>"

      o.join('')

    detailsForDownloadEvent: (c) ->
      """
      #{util.truncate(c.payload.download.description)}
      """

    detailsForForkEvent: (c) ->
      "&rarr; <a href='#{c.payload.forkee.html_url}'>#{c.payload.forkee.html_url}</a>"

    detailsForIssueCommentEvent: (c) ->
      util.truncate(c.payload.comment.body)

    detailsForIssuesEvent: (c) ->
      "#{util.truncate(c.payload.issue.title)}"

    detailsForPullRequestEvent: (c) ->
      "#{util.truncate(c.payload.pull_request.title)}"

    detailsForPushEvent: (c) ->
      maxCommits = 3
      o = []

      for commit in c.payload.commits[0...maxCommits]
        o.push "#{util.truncate(commit.message, 50, '')}<a href='#{helpers.github.repoUrl(c)}/commit/#{commit.sha}'>&hellip;</a>"

      if c.payload.commits.length > maxCommits
        o.push "and #{c.payload.commits.length - maxCommits} more&hellip;"

      o.join("<br>")

    detailsForWatchEvent: (c) ->
      ""

    title: (ev) ->
      c = ev.content
      t = helpers.github["titleFor#{c.type}"] or helpers.github.titleForDefault
      "#{helpers.github.who(c)} #{t(c)}"

    details: (ev) ->
      c = ev.content
      d = helpers.github["detailsFor#{c.type}"] or helpers.github.detailsForDefault
      "#{d(c)}"

  mailinglists:
    who: (ev) ->
      ev.from.replace(/"([^"]+)"(.+)/, "$1")

    whichList: (ev) ->
      ev.subject.replace(/\[([^\]]+)\](.+)/, "$1")

    title: (ev) ->
      """
      <strong>#{helpers.mailinglists.who(ev)}</strong>
      <a href="#{ev.url}">emailed</a>
      <strong>#{helpers.mailinglists.whichList(ev)}</strong>
      """

    details: (ev) ->
      subj = ev.subject.replace(/\[([^\]]+)\]\s+(.+)/, "$2")
      "#{util.truncate(subj, 50, '')}<a href='#{ev.url}'>&hellip;</a>"

  default:
    title: (ev) -> "Default title"
    details: (ev) -> "Default details"

render = (ev) ->
  date = util.humanTime(util.parseISO8601(ev.date))
  title = helpers[ev.type]?.title ? helpers.default.title
  details = helpers[ev.type]?.details ? helpers.default.details

  """
  <div class='event'>
    <p class='title'>
      <span class='when'>#{date}</span>
      <span class='what'>#{title(ev)}</span>
    </p>
    <p class='details'>#{details(ev)}</p>
  </div>
  """

class Activity
  constructor: (@element, @options) ->
    self = this

    $(@element).addClass('activity').addClass('loading')

    $.ajax
      url: @options.url
      dataType: 'jsonp'
      jsonpCallback: '__dashscrapeCallback'

    .done (data) ->
      self.data = data
      self.go()

  go: () ->
    $(@element).removeClass('loading')
    this.drawEvents @data.reverse()[0...(@options.events or 10)]

  drawEvents: (events) ->
    for e in events
      res = render(e)
      $(res).appendTo(@element)

jQuery.fn.activity = (options) ->
  if not options['url']
    console.error "Activity plugin needs 'url' key!"
    return this

  new Activity(this, options)

  return this
