# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'ready page:load', ->
  FastClick.attach(document.body)

  drawChart()

  $entry_amount = $('#entry_amount')

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

  $('a', '#month-toggle').on 'click', (e) ->
    e.preventDefault() 

    if $(this).hasClass('categories') 
      $('#months-wrapper')
        .removeClass('dates')
        .addClass('categories')
    else
      $('#months-wrapper')
        .addClass('dates')
        .removeClass('categories')

    $('html, body').animate({scrollTop: $(this).offset().top - 65}, 600)

  $('#month-categories').on 'click', (e) ->
    e.preventDefault()

    $(this).toggleClass('show-day');

  $('#select-category').on 'click', (e) ->
    e.preventDefault()

    $('#category-overlay').addClass('visible')
    $('html,body').animate({scrollTop: 0}, 0)

    $('#category-name').val('').trigger('keyup').focus()

  $options = $('option', '#entry_category_id')

  select_category_option = ( $elem ) ->
    $('#category-name').blur()
    $('#category-overlay').removeClass('visible')
    $('html,body').animate({scrollTop: 0}, 0)
    $('#select-category').html( $elem.html() )
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
        $('#category-list').append('<li data-value="' + $(this).val() + '">' + $(this).html() + '</li>')



  


  
drawChart = ->
  return unless $('.root-category').length

  categories = [['Task', 'Cats']];
  $('.root-category').each ->
    categories.push([$('h2', this).text(), parseFloat($('h3', this).data('amount'))])

  data = google.visualization.arrayToDataTable(categories);

  # console.log(categories)

  options = {
    title: '',
    colors: ['#6f4e3a', '#f3675d', '#ffa9a5', '#ffbb96', '#ffef88', '#ffdf68', '#c5da87', '#e2f4dc', '#3f99ed', '#e74f75', '#c83c40', '#ff9945']
    # colors: ['#3f99ed', '#ec5078', '#ca3b47', '#e94444', '#ff993d', '#ffbf4b', '#cde171', '#487dbe', '#6f4d3a', '#ffa9a4', '#ffbb96', '#e2f4dc']
    pieSliceText: 'label',
    legend: 'none'
  };

  chart = new google.visualization.PieChart(document.getElementById('piechart'));
  chart.draw(data, options);

google.load("visualization", "1", {packages:["corechart"]});