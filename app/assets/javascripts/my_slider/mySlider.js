var slider;
slider = function(){

  var slides = $(".slide");
  var currentIndex = 0;
  var fadeTime = 700; //the time to fade in and out (in ms)

  // // fade out all except the first slide
  // slides.each(function( idx, element ){
  //   var slide = $(element);
  //   if (slide.index() != 0) {
  //     // slide.fadeOut();
  //   }
  // });


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
   *  clicking the next-control button will make the slider show the next
   *  slide
   */
  $(".next-control").click(function() {
    var targetIndex = currentIndex + 1;

    if (targetIndex > slides.length - 1) {
      targetIndex = 0;
    }

    changeToSlide( targetIndex );
  });


  /**
   *  clicking the prev-control button will make the slider show the next
   *  slide
   */
  $(".prev-control").click(function() {
    var targetIndex = currentIndex - 1;

    if (targetIndex < 0) {
      targetIndex = slides.length - 1;
    }

    changeToSlide( targetIndex );
  });

};

$(document).on("page:load", slider);
