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

});