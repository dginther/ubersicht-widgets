command: "bash ./PRsRequested.widget/helper.sh"

refreshFrequency: 5000,

render: (output) ->
  """
  <div>
    <div class="header">Pull Requests To Review</div>
        <div class="body">#{output}</div>
      </div>

  """

style: """
    left: 20px
    top: 20px
    color: #fff

    // Statistics text settings
    color #fff
    font-family Helvetica Neue
    background rgba(#444, .7)
    padding 10px
    border-radius 5px
    width 300px


    .header
      text-transform uppercase
      font-size 14px

    .title
      text-transform uppercase
      font-weight bold
      color #28bacb
      font-size 10px

    .url
      text-transform uppercase
      padding-left 5px
      font-size 10px
      a {
        color: white;
      }
  """

update: (output, domEl) ->
  # prep the dom
  bodyDomEl = $(domEl).find(".body").empty()

  # find the tokens
  tokens = output.trim().split('\n')
  titles = [];
  urls = [];

  for token, i in tokens
    if i % 2 is 1
      titles.push token
    else
      urls.push token

  # real dom update
  for title, i in titles
    titleName = urls[i]
    url = title.trim()

    bodyDomEl.append("""
      <div class="row">
        <span class='title'>#{titleName}</span>
        <span class='url'><a href="#{url}">#{url}</a></span>
      </div>
    """)
