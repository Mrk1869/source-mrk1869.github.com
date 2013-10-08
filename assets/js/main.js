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
  $(".image-on-frame").css('visibility','visible').hide().fadeIn(800);
});
