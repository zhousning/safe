$(".grp_drills").ready(function() {
  if ($(".grp_drills.index").length > 0) {
     

    var url = '/grp_drills/query_list';
    fct_date_event("#day-pdt-rpt-table", url)

    $("#day-pdt-rpt-table").on('click', 'button.log-show-btn', function(e) {
      $('#logModal').modal();
      var that = e.target
      var data_id = that.dataset['id'];
      var url = "/grp_drills/" + data_id + "/query_info";
      $.get(url).done(function (data) {
        var emq = data;
        var emq_table = '<tr><th></th><th>时间</th><th>负责人</th><th>站点</th><th></th></tr>';
        for (var i=0; i<emq.length; i++) {
          var j = i + 1
          emq_table += '<tr>'; 
          emq_table += "<td>" + j + "</td>"; 
           
          emq_table += "<td>" + emq[i].title + "</td>"; 
           
          emq_table += "<td>" + emq[i].content + "</td>"; 
           
          emq_table += "<td>" + emq[i].place + "</td>"; 
           
          emq_table += "<td>" + emq[i].train_time + "</td>"; 
           
          emq_table += "<td>" + emq[i].address + "</td>"; 
          
          emq_table += '</tr>'; 
        }
        $("#log-day-emq-ctn").html(emq_table);
      });
    });
  }
});

