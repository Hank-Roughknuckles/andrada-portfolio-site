// var slider; //uncomment when turbolinks is re-enabled
// slider = function(){ //uncomment when turbolinks is re-enabled
$(function(){

  var slides = $(".slide");
  var currentIndex = 0;
  var fadeTime = 700; //the time to fade in and out (in ms)

  /**
   *  changeToSlide()
   *
   *  This changes the currently shown slide to the one indicated by
   *  targetIndex
   */
  function changeToSlide( targetIndex ) {
    slides.eq(currentIndex).fadeOut(fadeTime);
    slides.eq(targetIndex).fadeIn(fadeTime);
    currentIndex = targetIndex;
  }
  

  /**
   *  clicking the next_control button will make the slider show the next
   *  slide
   */
  $(".next_control").click(function() {
    var targetIndex = currentIndex + 1;

    if (targetIndex > slides.length - 1) {
      targetIndex = 0;
    }

    changeToSlide( targetIndex );
  });


  /**
   *  clicking the prev_control button will make the slider show the next
   *  slide
   */
  $(".prev_control").click(function() {
    var targetIndex = currentIndex - 1;

    if (targetIndex < 0) {
      targetIndex = slides.length - 1;
    }

    changeToSlide( targetIndex );
  });

});
// }; //uncomment when turbolinks is re-enabled

//un-comment this when you re-enable turbolinks
// $(document).on("page:load", slider);
