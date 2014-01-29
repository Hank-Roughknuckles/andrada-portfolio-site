# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ -> #DOM Ready

  $(".close, .overlay").click ->
    $(".overlay").hide()
    $(".content_#{currentLightbox}").hide()
    $(".content_preview .content_#{currentLightbox}").show()

    currentLightbox = -1;


  #Gridster stuff
  dragged = false
  currentLightbox = -1;

  $(".gridster ul").gridster
    widget_margins: [10, 10]
    widget_base_dimensions: [200, 200]
    draggable: {
      start: (e, ui, $widget) ->
        dragged = true;
    }

  gridster = $(".gridster ul").gridster().data('gridster');

  $(".gridster ul li").click ->
    if dragged is true
      dragged = false
    else
      numberRegex = /[0-9]/
      currentLightbox = @id.match(numberRegex)
      $(".overlay").show()
      $(".content_#{currentLightbox}").show()

  $(".gridster ul li").mouseup ->
    if dragged is true
      tiles = getPositions()
      $("#serialized_array").val JSON.stringify(tiles)
      $(".edit_grid_position").submit()
      dragged = false

  getPositions = ->
    tilePositions = []
    $(".gridster ul li").each (i, element) ->
      unless !element.id.match(/tile_[0-9]/)
        current = 
          row:          $(element).attr('data-row')
          col:          $(element).attr('data-col')
          sizex:        $(element).attr('data-sizex')
          sizey:        $(element).attr('data-sizey')
          databaseID:   element.id.match(/[0-9]/)[0]

        tilePositions.push current

    return tilePositions

