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
        date.setMonth d[3] - 1    if d[3]
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
        who: (ev) ->
            avatar = ev.person.avatar or 'http://www.gravatar.com/avatar/00000000000000000000000000000000?d=mm&s=50'
            """
            <a href="#{avatar}"><img src='#{avatar}'></a>
            <a href='#{ev.person.permalink}'>#{ev.person.display_name}</a>
            """

        repoUrl: (c) ->
            "#{GITHUB}/#{c.repo.full_name}"

        repo: (c) ->
            "<a title='#{c.repo.full_name} on GitHub' href='#{helpers.github.repoUrl(c)}'>#{c.repo.full_name}</a>"

        titleForDefault: (c) ->
            "did something"

        titleForCommitCommentEvent: (c) ->
            """
            commented on
            <a href='#{c.github_payload.comment.html_url}'>#{c.github_payload.comment.commit_id[...7]}</a>
            on #{helpers.github.repo(c)}
            """

        titleForCreateEvent: (c) ->
            "created a #{c.github_payload.ref_type} on #{helpers.github.repo(c)}"

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
            <a href='#{c.github_payload.issue.html_url}#issuecomment-#{c.github_payload.comment.id}'>##{c.github_payload.issue.number}</a>
            on #{helpers.github.repo(c)}
            """

        titleForIssuesEvent: (c) ->
            "#{c.github_payload.action} issue <a href='#{c.github_payload.issue.html_url}'>##{c.github_payload.issue.number}</a> on #{helpers.github.repo(c)}"

        titleForPullRequestEvent: (c) ->
            "#{c.github_payload.action} pull request <a href='#{c.github_payload.pull_request.html_url}'>##{c.github_payload.pull_request.number}</a> on #{helpers.github.repo(c)}"

        titleForPushEvent: (c) ->
            branch = c.github_payload.ref.split('/')[2]
            if branch
                "pushed to <strong>#{branch}</strong> on #{helpers.github.repo(c)}"
            else
                "pushed to #{helpers.github.repo(c)}"

        titleForWatchEvent: (c) ->
            "#{c.github_payload.action} watching #{helpers.github.repo(c)}"

        detailsForDefault: (c) ->
            "More #{c.type} details here &hellip;"

        detailsForCommitCommentEvent: (c) ->
            util.truncate(c.github_payload.comment.body)

        detailsForCreateEvent: (c) ->
            o = []

            if c.github_payload.ref_type == "tag"
                o.push "Tagged "
            else
                o.push "Created ref "

            o.push "<a href='#{helpers.github.repoUrl(c)}/tree/#{c.github_payload.ref}'>#{c.github_payload.ref}</a>"

            o.join('')

        detailsForDownloadEvent: (c) ->
            """
            #{util.truncate(c.github_payload.download.description)}
            """

        detailsForForkEvent: (c) ->
            "&rarr; <a href='#{c.github_payload.forkee.html_url}'>#{c.github_payload.forkee.html_url}</a>"

        detailsForIssueCommentEvent: (c) ->
            util.truncate(c.github_payload.comment.body)

        detailsForIssuesEvent: (c) ->
            "#{util.truncate(c.github_payload.issue.title)}"

        detailsForPullRequestEvent: (c) ->
            "#{util.truncate(c.github_payload.pull_request.title)}"

        detailsForPushEvent: (c) ->
            maxCommits = 3
            o = []

            for commit in c.github_payload.commits[0...maxCommits]
                o.push "#{util.truncate(commit.message, 50, '')}<a href='#{helpers.github.repoUrl(c)}/commit/#{commit.sha}'>&hellip;</a>"

            if c.github_payload.commits.length > maxCommits
                o.push "and #{c.github_payload.commits.length - maxCommits} more&hellip;"

            o.join("<br>")

        detailsForWatchEvent: (c) ->
            ""

        title: (ev) ->
            t = helpers.github["titleFor#{ev.type}"] or helpers.github.titleForDefault
            "#{helpers.github.who(ev)} #{t(ev)}"

        details: (ev) ->
            d = helpers.github["detailsFor#{ev.type}"] or helpers.github.detailsForDefault
            "#{d(ev)}"

    mailman:
        title: (ev) ->
            avatar = ev.person.avatar or 'http://www.gravatar.com/avatar/00000000000000000000000000000000?d=mm&s=50'
            """
            <a href="#{avatar}"><img src='#{avatar}'></a>
            <a href='#{ev.person.permalink}'>#{ev.person.display_name}</a>
            <a href="#{ev.link}">emailed</a>
            <strong>#{ev.mailman.name}</strong>
            """
        details: (ev) ->
            subj = ev.subject.replace(/\[([^\]]+)\]\s+(.+)/, "$2")
            "#{util.truncate(subj, 50, '')}<a href='#{ev.link}'>&hellip;</a>"

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
        if console
            console.log 'error',e

    drawEvents: () ->
        @element.empty()
        for e in @events
            res = render(e)
            $(res).appendTo(@element)

jQuery.fn.activity = (options) ->
    if not options['url']
        if console then console.error "Activity plugin needs 'url' key!"
        return this

    new Activity(this, options)

    return this
