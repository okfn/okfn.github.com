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
      <img src='#c.person.avatar'>
      <a href='#c.person.permalink'>#{c.person.display_name}</a>
      """

    repoUrl: (c) ->
      return ''
      "#{GITHUB}/#{c.repo.name}"

    repo: (c) ->
      return ''
      "<a title='#{c.repo.name} on GitHub' href='#{helpers.github.repoUrl(c)}'>#{c.repo.name}</a>"

    titleForDefault: (c) ->
      "did something"

    titleForCommitCommentEvent: (c) ->
      return ''
      """
      commented on
      <a href='#{c.payload.comment.html_url}'>#{c.payload.comment.commit_id[...7]}</a>
      on #{helpers.github.repo(c)}
      """

    titleForCreateEvent: (c) ->
      return ''
      "created a #{c.payload.ref_type} on #{helpers.github.repo(c)}"

    titleForDownloadEvent: (c) ->
      return ''
      """
      created a new
      <a href='#{helpers.github.repoUrl(c)}/downloads'>download</a>
      on #{helpers.github.repo(c)}
      """

    titleForForkEvent: (c) ->
      return ''
      "forked #{helpers.github.repo(c)}"

    titleForIssueCommentEvent: (c) ->
      return ''
      """
      commented on issue
      <a href='#{c.payload.issue.html_url}#issuecomment-#{c.payload.comment.id}'>##{c.payload.issue.number}</a>
      on #{helpers.github.repo(c)}
      """

    titleForIssuesEvent: (c) ->
      return ''
      "#{c.payload.action} issue <a href='#{c.payload.issue.html_url}'>##{c.payload.issue.number}</a> on #{helpers.github.repo(c)}"

    titleForPullRequestEvent: (c) ->
      return ''
      "#{c.payload.action} pull request <a href='#{c.payload.pull_request.html_url}'>##{c.payload.pull_request.number}</a> on #{helpers.github.repo(c)}"

    titleForPushEvent: (c) ->
      return ''
      branch = c.payload.ref.split('/')[2]
      if branch
        "pushed to <strong>#{branch}</strong> on #{helpers.github.repo(c)}"
      else
        "pushed to #{helpers.github.repo(c)}"

    titleForWatchEvent: (c) ->
      return ''
      "#{c.payload.action} watching #{helpers.github.repo(c)}"

    detailsForDefault: (c) ->
      return ''
      "More #{c.type} details here &hellip;"

    detailsForCommitCommentEvent: (c) ->
      return ''
      util.truncate(c.payload.comment.body)

    detailsForCreateEvent: (c) ->
      return ''
      o = []

      if c.payload.ref_type == "tag"
        o.push "Tagged "
      else
        o.push "Created ref "

      o.push "<a href='#{helpers.github.repoUrl(c)}/tree/#{c.payload.ref}'>#{c.payload.ref}</a>"

      o.join('')

    detailsForDownloadEvent: (c) ->
      return ''
      """
      #{util.truncate(c.payload.download.description)}
      """

    detailsForForkEvent: (c) ->
      return ''
      "&rarr; <a href='#{c.payload.forkee.html_url}'>#{c.payload.forkee.html_url}</a>"

    detailsForIssueCommentEvent: (c) ->
      return ''
      util.truncate(c.payload.comment.body)

    detailsForIssuesEvent: (c) ->
      return ''
      "#{util.truncate(c.payload.issue.title)}"

    detailsForPullRequestEvent: (c) ->
      return ''
      "#{util.truncate(c.payload.pull_request.title)}"

    detailsForPushEvent: (c) ->
      return ''
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
      return ''
      c = ev.content
      t = helpers.github["titleFor#{c.type}"] or helpers.github.titleForDefault
      "#{helpers.github.who(c)} #{t(c)}"

    details: (ev) ->
      return ''
      c = ev.content
      d = helpers.github["detailsFor#{c.type}"] or helpers.github.detailsForDefault
      "#{d(c)}"

  mailman:
    who: (ev) ->
      return ''
      ev.from.replace(/"([^"]+)"(.+)/, "$1")

    whichList: (ev) ->
      return ''
      ev.subject.replace(/\[([^\]]+)\](.+)/, "$1")

    title: (ev) ->
      return ''
      """
      <strong>#{helpers.mailman.who(ev)}</strong>
      <a href="#{ev.url}">emailed</a>
      <strong>#{helpers.mailman.whichList(ev)}</strong>
      """

    details: (ev) ->
      return ''
      subj = ev.subject.replace(/\[([^\]]+)\]\s+(.+)/, "$2")
      "#{util.truncate(subj, 50, '')}<a href='#{ev.url}'>&hellip;</a>"

  default:
    title: (ev) -> "Default title"
    details: (ev) -> "Default details"

render = (ev) ->
  date = util.humanTime(util.parseISO8601(ev.timestamp))
  title = helpers[ev._activity_type]?.title ? helpers.default.title
  details = helpers[ev._activity_type]?.details ? helpers.default.details

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
  events: []

  constructor: (@element, @options) ->
    self = this

    $(@element).addClass('activity').addClass('loading')

    $.each @options.url, (i,url)=>
        $.ajax
          url: url
          dataType: 'jsonp'
          success: @gotEvents
          error: @error

  gotEvents: (jsonObject) =>
      @events = @events.concat(jsonObject.data)
      @events.sort (a,b) -> return if a.timestamp>b.timestamp then -1 else 1
      #@events = @events[0...(@options.events or 10)]
      window.events = @events
      $(@element).removeClass('loading')
      this.drawEvents()

  error: (e) ->
    console.log 'error',e

  drawEvents: () ->
    @element.empty()
    for e in @events
      res = render(e)
      $(res).appendTo(@element)

jQuery.fn.activity = (options) ->
  if not options['url']
    console.error "Activity plugin needs 'url' key!"
    return this

  new Activity(this, options)

  return this
