$(".grp_trains").ready(function() {
  if ($(".grp_trains.index").length > 0) {
     

    var url = '/grp_trains/query_list';
    fct_date_event("#day-pdt-rpt-table", url)

    $("#day-pdt-rpt-table").on('click', 'button.log-show-btn', function(e) {
      $('#logModal').modal();
      var that = e.target
      var data_id = that.dataset['id'];
      var url = "/grp_trains/" + data_id + "/query_info";
      $.get(url).done(function (data) {
        var emq = data;
        var emq_table = '<tr><th>时间</th><th>标题</th><th>地点</th></tr>';
        var attch = '';
        for (var i=0; i<emq.length; i++) {
          var j = i + 1
          emq_table += '<tr>'; 
           
          emq_table += "<td>" + emq[i].train_time + "</td>"; 

          emq_table += "<td>" + emq[i].title + "</td>"; 
           
          emq_table += "<td>" + emq[i].address + "</td>"; 
          
          emq_table += '</tr>'; 

          emq_table += "<tr><td colspan='3'>" + emq[i].content + "</td></tr>"; 

          $.each(emq[i].imgs, function(k, v) {
            console.log(k + v);
            attch += "<p>" + k + "</p>" + "<img class='w-100' src='" + v + "'>";
          });
          $.each(emq[i].attchs, function(k, v) {
            attch += "<a href='" + v + ">" + k + "</a>";
          });
        }
        $("#log-day-emq-ctn").html(emq_table);
        $("#log-attch-ctn").html(attch)
      });
    });
  }
});

