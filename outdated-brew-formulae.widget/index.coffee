#command: "/usr/local/bin/brew update > /dev/null && /usr/local/bin/brew outdated"
command: "/usr/local/bin/brew outdated"

refreshFrequency: 3600000 # 60 minutes by default

style: """
  // Position the widget on your screen
  top 60px
  left 10px

  // Change the style of the widget
  color #fff
  font-family Helvetica Neue
  padding 10px 10px 5px

  .container
    position: relative
    clear: both

  .list
    padding-top: 3px
    width=100%

  .list-item
    font-size: 0.7em
    font-weight: 300
    color: rgba(#fff, .75)
    text-shadow: 0 1px 0px rgba(#000, .7)

  .widget-title
    font-size 0.8em
    text-transform uppercase
    font-weight 300
"""

render: -> """
  <div class="container">
    <div class="widget-title">Outdated Brew Formulae</div>
    <div id="formulae" class="list">
    </div>
  </div>
"""

update: (output, domElement) ->

  domElement.innerHTML = '<div class="container"><div class="widget-title">Outdated Brew Formulae</div><div id="formulae" class="list"></div></div>'

  formulae = output.split('\n')
  list = $(domElement).find('#formulae')

  addFormula = (formula) ->
    item = "<div class=\"list-item\">#{formula}</div>"
    list.append item

  if formulae.length == 0
    addFormula "No outdated formulae!"
  else
    for formula, i in formulae
      addFormula formula
