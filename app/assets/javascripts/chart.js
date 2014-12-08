$(document).ready(function(){

  $('.story').on('click', function(event){
    event.preventDefault();
    var $this = $(this);
    $('#chart').html("");
    $('.bullet').remove();
    $('#saying').text('');

    //Editing the heading when a topic is clicked
    var bulletHTML = '<span class="bullet"> •</span>'
    $topic = $(this).text()
    var message = " what happened: " + $topic + "."
    showText('#saying', message, 0);
    $this.append(bulletHTML)
    
    //Appending Rank Y-Axis Title
    // $('.chart-row .rank').remove();
    // $('.chart-row').prepend('<div class="rank col-md-1">Rank</div>')
  
    //Creating the chart
    $.ajax({url: $this.attr('href'), dataType: 'JSON'}).done(function(result){
      var data = [];
      var headlines = {};
      var abstracts = {};
      var ids = {};
      var ranks = {};

      for (var i = 0; i < result.length; i++){
        var coordinates = {};
        coordinates["x"] = moment(result[i].published_date, "YYYY-MM-DD").unix();
        // coordinates["x"] = new Rickshaw.Fixtures.Time(result[i].published_date);
        // coordinates["x"] = i + 1;
        coordinates["y"] = 800 - result[i].rank;
        if (result[i].name) {
          headlines[moment(result[i].published_date, "YYYY-MM-DD").unix()] = result[i].formatted_name;
          abstracts[moment(result[i].published_date, "YYYY-MM-DD").unix()] = result[i].formatted_abstract;
          ids[moment(result[i].published_date, "YYYY-MM-DD").unix()] = result[i].id;
          ranks[moment(result[i].published_date, "YYYY-MM-DD").unix()] = result[i].rank;
        }
        data.push(coordinates);
      }

      var graph = new Rickshaw.Graph( {
        element: document.querySelector("#chart"),
        renderer: 'line',
        width: 900,
        height: 400,
        min: -50,
        max: 850,
        series: [ {
                color: '#FF4D00',
                data: data
        } ]
      } );

      var axes = new Rickshaw.Graph.Axis.Time( { graph: graph } );

      new Rickshaw.Graph.Axis.Y({
        element: document.getElementById('axis0'),
        graph: graph,
        orientation: 'left',
        tickFormat: Rickshaw.Fixtures.Number.formatKMBT
      });

      var hoverDetail = new Rickshaw.Graph.HoverDetail( {
        graph: graph,
        formatter: function(series, x, y) {

          if (headlines[x] !== undefined) {

          var content = '<div id=' + ids[x] + ' class="headline">' 
            + headlines[x] + ' (Rank: '+ ranks[x] + ')</div>'
            + '<br><div class="abstract">' 
            + abstracts[x] + '</div>';
          return content;

          } else {
            return nil;
          }
          
        }
      } );

      graph.render();

    });
  });

  $('body').on('click','svg path',function(e){
    var $articleId = $(this).parent().siblings('.detail').children('.item.active').children('div').attr('id');
     $.ajax({url: '/articles/' + $articleId, dataType: 'JSON'}).done(function(result){
      window.open(result['url'], '_blank');
     });
  });

});

var showText = function (target, message, index) {    
  if (index < message.length) { 
    $(target).append(message[index++]); 
    setTimeout(function () { showText(target, message, index); }, Math.random() * 20); 
  } 
}

