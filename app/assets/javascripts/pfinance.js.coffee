$(document).on 'ready page:load page:restore', ->
  $('body').removeClass('loading')

$(document).on 'page:before-change', ->
  $('body').addClass('loading')