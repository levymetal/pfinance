$(document).on 'ready page:load', ->
  $('body').removeClass('loading')

$(document).on 'click', 'a', ->
  $('body').addClass('loading')