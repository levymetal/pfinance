# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'page:change', ->
  FastClick.attach(document.body)

  # drawChart()

  $entry_amount = $('#entry_from_amount')

  $entry_amount.val('0.00') if $entry_amount.val() == ''

  $entry_amount.on 'keydown', (e) ->
    e.preventDefault()

    # automatically control decimal points
    current = parseFloat $entry_amount.val()

    if e.keyCode >= 48 and e.keyCode <= 57
      number = e.keyCode - 48

      $entry_amount.val( ( Math.round( ( current * 10 + number / 100 ) * 100 ) / 100).toFixed(2)  )

    else if e.keyCode == 8
      current = current.toFixed(2).toString()
      $entry_amount.val( ( parseFloat( current.substring(0, current.length - 1) ) / 10 ).toFixed(2) )

  $('.root-category', '#month-categories').on 'click', (e) ->
    e.preventDefault()

    $(this).closest('li').toggleClass('show-sub-categories');

  $('#select-category').on 'click', (e) ->
    e.preventDefault()

    $('#category-name').val('').trigger('keyup')

    $('#category-overlay').addClass('visible')
    $('html,body').animate({scrollTop: 0}, 0)

  $options = $('option', '#entry_category_id')

  select_category_option = ( $elem ) ->
    $('#category-name').blur()
    $('#category-overlay').removeClass('visible')
    $('html,body').animate({scrollTop: 0}, 0)

    $('#select-category').html( $elem.find('span').text() )
    $('#new_category_name').val( $elem.find('span').text() )
    $('#entry_category_id').val( $elem.attr('data-value') )

  $('#category-list').on 'click', 'li', (e) ->
    e.preventDefault();

    select_category_option $(this)

  $('#category-name').on 'keyup', (e) ->
    if e.keyCode == 13
      select_category_option( $('li', '#category-list').first() ) 
      return

    term = $(this).val().toLowerCase()

    $('#category-list').html('')
    $options.each ->
      if $(this).text().toLowerCase().indexOf( term ) != -1
        $('#category-list').append('<li data-value="' + $(this).val() + '"><span>' + $(this).html() + '</span></li>')

    if ( $('#category-list').html() == '' )
        $('#category-list').append('<li>Create "<span>' + $(this).val() + '</span>"</li>')
