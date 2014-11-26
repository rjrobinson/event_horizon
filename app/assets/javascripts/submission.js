$(function(){
  $("div.filename").click(function(){
    $(this).siblings("div.body").slideToggle();
  });
});
