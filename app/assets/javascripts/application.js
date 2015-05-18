  // This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require select2

$(document).ready(function(){

  $('.toggle_button').bind("click", function() {
    var blogID = $(this).attr("id");
    var divelement = document.getElementById('archive_btn_'+blogID);
    if(divelement.style.display == 'none'){
      divelement.style.display = 'block';


      document.getElementById('edit_btn_'+blogID).style.display='none';
      document.getElementById('live_btn_'+blogID).style.display='none';

      console.log("if");
    }
    else{
      divelement.style.display = 'none';
      console.log("else");
    }
  });

  $(".js-example-basic-multiple").select2({
    placeholder: "Categories",
    allowClaer: true
  });


  $("#buttonUploader").bind("click", function () {
    $("#imageUploader").trigger("click");
  });

  $('#imageUploader').change(function(data) {
    setTimeout(function(){
      var fileUpload = new FileReader;
      var file = document.getElementById("imageUploader").files[0];
      var image = new Image();
      setTimeout(function(){
        fileUpload.onload = function (e){
        return function (e){
          image.src = e.target.result;
          $("#base64Image").val(e.target.result);
          $("#displayImage").css("background-image", "url('" + image.src + "')");
        }
      }(file);
      fileUpload.readAsDataURL(file);
      });
    });
  });


  $(".archive_button").click(function(){
    var blogID = $(this).attr("id");
    $.ajax({      
      url:"/ajax/blogs/" + blogID + "/archive",
      type: "PUT",
      dataType:'json',
      beforeSend: function(xhr) {
        xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
        
      },
      error:function(data){ 
          
      },
      success:function(data){
        if(data.is_archived == true){
          $("#"+blogID).html("Archived");
        }
        else{
          $("#"+blogID).html("Archive");
        }
      }
    });
  });


  $(".go_live_button").click(function(){
    var blogID = $(this).attr("id");
    $.ajax({      
      url:"/ajax/blogs/" + blogID + "/live",
      type: "PUT",
      dataType:'json',
      beforeSend: function(xhr) {
        xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
        
      },
      error:function(data){ 
          
      },
      success:function(data){
        if(data.is_draft == true){
          $("#"+blogID).html("Live");
          $(".archive_button").show();
        }
        else{
          $(".go_live_button").hide();
          $(".edit_button").hide();
          $(".archive_button").show();
        }
      }
    });

    var blogID = $(this).attr("value");
    var divelement = document.getElementById('archive_btn_'+blogID);
    divelement.style.display = 'block';
    document.getElementById('edit_btn_'+blogID).style.display='none';
    document.getElementById('live_btn_'+blogID).style.display='none';
    


  });
});