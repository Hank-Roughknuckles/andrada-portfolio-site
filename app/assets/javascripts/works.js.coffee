# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ -> #DOM Ready

  dragged = false
  currentLightbox = -1;

  $(".gridster ul").gridster
    widget_margins: [10, 10]
    widget_base_dimensions: [200, 200]
    draggable: {
      start: (e, ui, $widget) ->
        dragged = true;
    }

  $(".gridster ul li").click ->
    if dragged is true
      dragged = false
    else
      numberRegex = /[0-9]/
      currentLightbox = @id.match(numberRegex)
      $(".overlay").show()
      $(".content_#{currentLightbox}").show()

  $(".close, .overlay").click ->
    #Close lightbox, but not the one that's inside .content_preview
    $(".overlay").hide()
    $(".content_#{currentLightbox}").hide()
    $(".content_preview .content_#{currentLightbox}").show()

    currentLightbox = -1;
