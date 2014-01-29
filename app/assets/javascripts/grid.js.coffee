$ -> #DOM Ready

  #Gridster stuff
  dragged = false
  currentLightbox = -1;

  $(".gridster ul").gridster
    widget_margins: [5, 5]
    widget_base_dimensions: [138, 138]
    draggable: {
      start: (e, ui, $widget) ->
        dragged = true;
    }

  gridster = $(".gridster ul").gridster().data('gridster');

  #if #drag_disabled exists, then don't let the user drag tiles
  if $("#drag_disabled").length > 0
    console.log "Drag is disabled"
    console.log $("#drag_disabled")
    gridster.disable();

  $(".gridster ul li").mouseup ->
    if dragged is true
      setTimeout(savePositions, 200)
    else
      numberRegex = /[0-9]/
      currentLightbox = @id.match(numberRegex)
      $(".overlay").show()
      $(".content_#{currentLightbox}").show()

  savePositions = ->
    tiles = getPositions()
    $("#serialized_array").val JSON.stringify(tiles)
    console.log tiles
    $(".edit_grid_position").submit()

  getPositions = ->
    tilePositions = []
    $(".gridster ul li").each (i, element) ->
      unless !element.id.match(/tile_[0-9]/)
        current = 
          row:          $(element).attr('data-row')
          column:       $(element).attr('data-col')
          sizex:        $(element).attr('data-sizex')
          sizey:        $(element).attr('data-sizey')
          databaseID:   element.id.match(/[0-9]/)[0]

        tilePositions.push current

    return tilePositions

