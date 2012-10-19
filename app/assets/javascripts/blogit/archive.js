// Supporting functions for the display of post archives

jQuery(function(){
  $("a[data-blogit-click-to-toggle-children]").click(function(event){
    event.preventDefault();
    $(this).siblings('ul').toggle();
  })
})