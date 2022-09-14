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
        var emq_table = '<tr><th>时间</th><th>地点</th><th>人数</th></tr>';
        var attch = '';
        var header_title = '';
        for (var i=0; i<emq.length; i++) {
          var j = i + 1
          header_title += emq[i].title;

          emq_table += '<tr>'; 
           
          emq_table += "<td>" + emq[i].train_time + "</td>"; 
           
          emq_table += "<td>" + emq[i].address + "</td>"; 
          
          emq_table += "<td>" + emq[i].number + "</td>"; 

          emq_table += '</tr>'; 

          emq_table += "<tr><td class='text-left' colspan='3'>" + emq[i].content + "</td></tr>"; 

          $.each(emq[i].imgs, function(k, v) {
            attch += "<p>" + k + "</p>" + "<img class='w-100' src='" + v + "'>";
          });
          $.each(emq[i].attchs, function(k, v) {
            attch += "<p><a href='" + v + "'>" + k + "</a></p>";
          });
        }
        $("#log-day-pdt-rpt-header").html(header_title);
        $("#log-day-emq-ctn").html(emq_table);
        $("#log-attch-ctn").html(attch)
      });
    });
  }
});

