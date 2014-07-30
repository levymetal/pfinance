$(document).on 'ready page:load page:restore', ->
  $('body').removeClass('loading')

$(document).on 'page:before-change', ->
  opts =
    lines: 13 # The number of lines to draw
    length: 13 # The length of each line
    width: 3 # The line thickness
    radius: 19 # The radius of the inner circle
    corners: 0 # Corner roundness (0..1)
    rotate: 0 # The rotation offset
    direction: 1 # 1: clockwise, -1: counterclockwise
    color: "#666" # #rgb or #rrggbb or array of colors
    speed: 1 # Rounds per second
    trail: 36 # Afterglow percentage
    shadow: false # Whether to render a shadow
    hwaccel: false # Whether to use hardware acceleration
    className: "spinner" # The CSS class to assign to the spinner
    zIndex: 2e9 # The z-index (defaults to 2000000000)
    top: "50%" # Top position relative to parent
    left: "50%" # Left position relative to parent

  target = document.getElementById("spinner")
  spinner = new Spinner(opts).spin(target)

  $('body, #spinner').addClass('loading')

$(document).on 'ready page:load', ->
  $('form').on 'submit', ->
    $('body').addClass('loading')