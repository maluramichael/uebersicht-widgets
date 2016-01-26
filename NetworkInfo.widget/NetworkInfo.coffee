#--------------------------------------------------------------------------------------
# Please Read
#--------------------------------------------------------------------------------------
# The images used in this widget are from the Noun Project (http://thenounproject.com).
#
# They were created by the following individuals:
#   Ethernet by Michael Anthony from The Noun Project
#   Wireless by Piotrek Chuchla from The Noun Project
#
#--------------------------------------------------------------------------------------

# Execute the shell command.
command: "NetworkInfo.widget/NetworkInfo.sh"

# Set the refresh frequency (milliseconds).
refreshFrequency: 20000

# Render the output.
render: (output) -> """
  <table id='services'></table>
"""

# Update the rendered output.
update: (output, domEl) ->
  dom = $(domEl)

  # Parse the JSON created by the shell script.
  data = JSON.parse output
  html = ""

  # Loop through the services in the JSON.
  for svc in data.service

    # Start building our table cell.
    html += "<td class='service'>"

    # If there is an IP Address, we should show the connected icon. Otherwise we show the disable icon.
    # If there is no IP Address, we show "Not Connected" rather than the missing IP Address.
    if svc.ipaddress == ''
      html += "  <img class='icon' src='NetworkInfo.widget/images/" + svc.name + "_disabled.png'/>"
      html += "  <p class='primaryInfo'>Not Connected</p>"
    else
      html += "  <img class='icon' src='NetworkInfo.widget/images/" + svc.name + ".png'/>"
      html += "  <p class='primaryInfo'>" + svc.ipaddress + "</p>"

    # Show the Mac Address.
    html += "  <p class='secondaryInfo'>" + svc.macaddress + "</p>"
    html += "</td>"

  # Set our output.
  $(services).html(html)

# Widget Settings
settings:
    lang: 'de'
    militaryTime: true
    colors:
      default: 'rgba(0, 0, 0, .75)'
      accent: 'rgba(255, 255, 255, .75)'
      background: 'rgba(255, 255, 255, .1)'
    shadows:
      box: '0 0 1.25em rgba(0, 0, 0, .3)'
      text: '0 0 0.625em rgba(0, 0, 0, .25)'

# CSS Style
style: """
  margin:0
  padding: 1rem 2rem
  right:15px
  top: 15px
  overflow: hidden

  .service
    text-align:center
    padding:2px

  .icon
    height:32px
    width:32px

  .primaryInfo, .secondaryInfo
    font-family: Helvetica Neue
    padding:0px
    margin:2px

  .divider
    display: block
    width: 0.2rem
    height: 100%
    margin: 0 1rem
    background: #{ @settings.colors.accent }

  .primaryInfo
    font-size:1.5em
    font-weight:200
    color: rgba(#fff,0.75)

  .secondaryInfo
    font-size:1em
    color: rgba(#fff, 0.5)
"""
