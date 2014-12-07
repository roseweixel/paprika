$(document).ready(function(){

  $('.story').on('click', function(event){
    event.preventDefault();
    $("body .row .col-md-1").remove();
    $("body .row").prepend( '<div class="col-md-1"><h5>Rank</h5></div>' );
    var $this = $(this);
    $("#chart").html("");
    
    $.ajax({url: $this.attr('href'), dataType: 'JSON'}).done(function(result){
      debugger;
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
        width: 580,
        height: 250,
        min: -50,
        max: 850,
        series: [ {
                color: 'steelblue',
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
      window.open(result['url'], 'window name', 'window settings');
     });
  });

});