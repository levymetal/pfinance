# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  $('#entry_amount').val('0.00')

  $('#entry_amount').on 'keydown', (e) ->
    e.preventDefault()

    # automatically control decimal points
    current = parseFloat $(this).val()

    if e.keyCode >= 48 and e.keyCode <= 57
      number = e.keyCode - 48

      $(this).val( ( Math.round( ( current * 10 + number / 100 ) * 100 ) / 100).toFixed(2)  )

    else if e.keyCode == 8
      current = current.toFixed(2).toString()
      $(this).val( ( parseFloat( current.substring(0, current.length - 1) ) / 10 ).toFixed(2) )


  
drawChart = ->
  categories = [['Task', 'Cats']];
  $('.categories p').each ->
    categories.push([$('span:first-child', this).text(), parseFloat($('span:last-child', this).text())])

  data = google.visualization.arrayToDataTable(categories);

  # console.log(categories)

  options = {
    title: '',
    colors: ['#7fcaff', '#7f97ff', '#ffd77e', '#e77fff', '#ff9c7e', '#62f5c8', '#a77fff', '#ffbd7e', '#caf562', '#ff7fb0', '#fff17e', '#f3ff7e']
    pieSliceText: 'label',
    legend: 'none'
  };

  chart = new google.visualization.PieChart(document.getElementById('piechart'));
  chart.draw(data, options);

google.load("visualization", "1", {packages:["corechart"]});
google.setOnLoadCallback(drawChart);

$(document).ready ready 
$(document).on 'page:load', ready 
$(document).on 'page:load', drawChart 