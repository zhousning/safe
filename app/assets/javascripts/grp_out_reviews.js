$(".grp_out_reviews").ready(function() {
  if ($(".grp_out_reviews.index").length > 0) {
     

    var url = '/grp_out_reviews/query_list';
    fct_date_event("#day-pdt-rpt-table", url)

    $("#day-pdt-rpt-table").on('click', 'button.log-show-btn', function(e) {
      $('#logModal').modal();
      var that = e.target
      var data_id = that.dataset['id'];
      var url = "/grp_out_reviews/" + data_id + "/query_info";
      $.get(url).done(function (data) {
        var emq = data;
        var attch = '';
        var header_title = '';
        var emq_table = '';
        for (var i=0; i<emq.length; i++) {
          var j = i + 1
          header_title += emq[i].search_date + '  |  ' + emq[i].title;
           
          emq_table += "<p class='text-left'>" + emq[i].content + "</p>"; 
           
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

