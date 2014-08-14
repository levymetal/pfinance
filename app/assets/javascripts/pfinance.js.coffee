$(document).on 'ready page:change page:restore', ->
  $('body').removeClass('loading')

$(document).on 'page:before-change', ->
  opts =
    length: 13 # The length of each line
    width: 3 # The line thickness
    radius: 19 # The radius of the inner circle
    corners: 0 # Corner roundness (0..1)
    color: '#666' # #rgb or #rrggbb or array of colors
    speed: 1 # Rounds per second
    trail: 36 # Afterglow percentage

  target = document.getElementById('spinner')
  spinner = new Spinner(opts).spin(target)

  $('body, #spinner').addClass('loading')

$(document).on 'ready page:change', ->
  $('form').on 'submit', ->
    $('body').addClass('loading')