$(document).on 'ready page:load page:restore', ->
  $('body').removeClass('loading')

$(document).on 'page:before-change', ->
  $('body').addClass('loading')

$(document).on 'ready page:load', ->
  $('form').on 'submit', ->
    $('body').addClass('loading')