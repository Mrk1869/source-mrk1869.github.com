$(function(){
  // tag
  var isTagOpened = false;
  $(".tag-toggle").on("click", function(){
    if(isTagOpened){
      $(".tag-container").fadeOut("slow");
      $(".tag-body").slideToggle();
    }else{
      $(".tag-container").fadeIn("slow");
      $(".tag-body").slideToggle();
    }
    isTagOpened = !isTagOpened;
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
        var title = data.match(/<title>(.*) - Red Magic Manuscripts<\/title>/)[1];
        if(title != ""){
          $($titles[i]).text(title);
        }else{
          $($titles[i]).parent('li').remove();
        }
      }
    });
  });
});
