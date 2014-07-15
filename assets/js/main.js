$(function(){

  // entry fade
  $(".entries-body").hover(function(){
    rollIn($(this));
  }, function(){
    rollOut($(this));
  });
  $(".entries-body").click(function(){
    rollOut($(this));
  });

  $(".page-button").hover(function(){
    rollIn($(this));
  }, function(){
    rollOut($(this));
  });
  $(".page-button").click(function(){
    rollOut($(this));
  });


  // hatena ster
  Hatena.Star.EntryLoader.headerTagAndClassName = ['div','hatena-star'];

  // image fade
  $(".image-fade").css('visibility','visible').hide().fadeIn(800);

  // twitter
  $(".twitter-tweet").addClass('tw-align-center');

  // getTitleofLinkedPage
  var $titles = $(".linkedTitle");
  $titles.each(function(i){
    var title = "";
    $.ajax({
      type:'GET',
      url:$(this).attr("href"),
      dataType:'html',
      success:function(data, textStatus, jqXHR){
        var title = data.match(/<title>(.*)<\/title>/)[1];
        if(title != ""){
          $($titles[i]).text(title);
        }else{
          $($titles[i]).parent('li').remove();
        }
      }
    });
  });
});

function rollIn(body){
  body.stop().animate({backgroundColor:"#386ca5", color:"#ffffff"}, 150);
  body.children(".entries-title").stop().animate({color:"#ffffff"}, 150);
}

function rollOut(body){
  body.stop().animate({backgroundColor:"#ffffff", color:"#333333"}, 200);
  body.children(".entries-title").stop().animate({color:"#007edf"}, 200);
}
