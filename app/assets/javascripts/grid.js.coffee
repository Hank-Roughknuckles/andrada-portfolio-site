$ -> #DOM Ready

  tileWidth = 138
  tileHeight = 138
  tileMarginX = 5
  tileMarginY = 5
  currentLightbox = -1 #has the ID of the lightbox whose details are
                       #currently being viewed

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
    gridster.disable();


  $(".expand_tile").mouseup ->
    if dragged is true
      setTimeout(savePositions, 200)
    else
      numberRegex = /[0-9]+/
      currentLightbox = @id.match(numberRegex)
      console.log "#{@id} - #{currentLightbox}"
      $(".overlay").show()
      $(".content_#{currentLightbox}").show()


  # Buttons for deleting tiles
  $(".gridster a img.tile_delete").click ->
    lightboxID = @id.match(/tile_delete_([0-9]+)/)[1]

    if confirm("Are you sure you want to delete this? This can't be undone")
      deleteTile lightboxID


  #Toggle edit tools button
  $(".toggle_edit_tools").click ->
    $(".edit_tools").toggle()


  deleteTile = (lightboxNumber) ->
    console.log "Delete the thing here"
    $("input#delete_work_#{lightboxNumber}").trigger("click")


  savePositions = ->
    tiles = getPositions()
    $("#serialized_array").val JSON.stringify(tiles)
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

