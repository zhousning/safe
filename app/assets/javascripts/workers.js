$(".workers").ready(function() {
  if ($(".workers.index").length > 0) {
    $("#item-table").on('click', 'button.worker-show-btn', function(e) {
      $('#newModal').modal();
      var that = e.target
      var data_id = that.dataset['id'];
      var url = "/factories/" + gon.fct + "/workers/" + data_id + "/query_info";
      $.get(url).done(function (data) {
        var emq = data.info;
        var address = data.address;
        var imgs = data.img;
        
        var emq_table = '<tr><th>姓名</th><th>身份证</th><th>电话</th></tr>';
        emq_table += '<tr>'; 
        for (var i=0; i<emq.length; i++) {
          emq_table += "<td>" + emq[i] + "</td>"; 
        }
        emq_table += '</tr>'; 
        $("#day-emq-ctn").html(emq_table);

        var image = ''
        for (var j=0; j<imgs.length; j++) {
           image += "<img class='col-6' src='" + imgs[j] + "'/>" 
        }
        $("#chart-ctn").html(image);
      });
    });
  }
});

function get_workers(method) {
  var $table = $('#item-table');
  var data = [];
  //var data_fct = $('#fct').val();
  //var url = "/factories/" + data_fct + "/" + method + "/query_all";
  var url = "/" + method + "/query_all";
  $.get(url).done(function (objs) {
    $.each(objs, function(index, item) {
      var id = item.id;
      //var button = "<button id='info-btn' class = 'button button-primary button-small mr-1' type = 'button' data-rpt ='" + id + "'>查看</button>" + "<a class='button button-royal button-small mr-1' href='/" + method + "/" + id + "/edit'>编辑</a><a data-confirm='确定删除吗?' class='button button-caution button-small' rel='nofollow' data-method='delete' href='/" + method + "/" + id + "'>删除</a>"
      var button = "<a class='button button-primary button-small mr-1' href='/" + method + "/" + id + "/'>查看</a>" + "<a class='button button-royal button-small mr-1' href='/" + method + "/" + id + "/edit'>编辑</a><a data-confirm='确定删除吗?' class='button button-caution button-small' rel='nofollow' data-method='delete' href='/" + method + "/" + id + "'>删除</a>"
      data.push({
        'id' : index + 1,
         
        'name' : item.name,
         
        'idno' : item.idno,
         
        'phone' : item.phone,
         
        'gender' : item.gender,
         
        'state' : item.state,
         
        'adress' : item.adress,
         
        'desc' : item.desc,
        
        'button' : button 
      });
    });
    $table.bootstrapTable('load', data);
  })
}

//var button = "<button id='info-btn' class = 'button button-primary button-small' type = 'button' data-rpt ='" + item.id + "' data-fct = '" + item.fct_id +"'>查看</button>"; 
//var factory = item.factory;
//var search = "<a class='button button-royal button-small mr-1' href='/factories/" + factory + "/" + method + "/" + id + "/edit'>编辑</a><a data-confirm='确定删除吗?' class='button button-caution button-small' rel='nofollow' data-method='delete' href='/factories/" + factory + "/" + method + "/" + id + "'>删除</a>"
