$ -> #DOM Ready

  currentLightbox = -1 #has the ID of the lightbox whose details are
                       #currently being viewed
  tileWidth = 138
  tileHeight = 138
  tileMarginX = 5
  tileMarginY = 5

  $(".close, .overlay").click ->
    $(".overlay").hide()
    $(".content_#{currentLightbox}").hide()
    $(".content_preview .content_#{currentLightbox}").show()

    currentLightbox = -1;


  #Gridster stuff
  dragged = false

  #Turn on gridster
  $(".gridster ul").gridster
    widget_margins: [tileMarginX, tileMarginY]
    widget_base_dimensions: [tileWidth, tileHeight]
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

