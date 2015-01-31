google.load("visualization", "1", {packages:["corechart"]});
google.setOnLoadCallback(drawChart);
function drawChart() {
  var data = new google.visualization.arrayToDataTable([
    ['Driver', 'Navigator'],
    ['Driver',     11],
    ['Navigator',      2]
  ]);

  var options = {
    title: 'My Daily Activities',
    pieHole: 0.4,
    background:'transparent',
  };

  var chart = new google.visualization.PieChart(document.getElementById('donut_single'));
  chart.draw(data, options);
  $('rect').attr('fill', 'none');
}

