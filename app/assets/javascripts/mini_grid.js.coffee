$ -> #DOM ready

  miniTileWidth = 75
  miniTileHeight = 75
  miniTileMarginX = 2
  miniTileMarginY = 2

  gridster = $(".gridster ul").gridster
    widget_margins: [miniTileMarginX, miniTileMarginY],
    widget_base_dimensions: [miniTileWidth, miniTileHeight],
    draggable: {
      stop: (e, ui, $widget) ->
        setTimeout(savePositions, 200)
    }
  gridster = $(".gridster ul").gridster().data('gridster');


  # Change tile size on changing the form dimensions
  $("form #edit_grid_sizex, form #edit_grid_sizey").change  ->
    currentTile = $(".highlighted");
    original_row = currentTile.attr("data-row")
    original_col = currentTile.attr("data-col")
    gridster.resize_widget(currentTile, $("form #edit_grid_sizex").val(), $("form #edit_grid_sizey").val());
    currentTile.attr("data-row", original_row)
    currentTile.attr("data-col", original_col)
    savePositions()


  ##
  # savePositions
  #
  savePositions = ->
    tiles = getPositions()
    $("#serialized_array").val JSON.stringify(tiles)
    $(".edit_grid_position").submit()


  ##
  # getPositions
  #
  getPositions = ->
    tilePositions = []
    $(".gridster ul li").each (i, element) ->
      if $(element).attr('data-row') && $(element).attr('data-col') && $(element).attr('data-sizex') && $(element).attr('data-sizey')
        current = 
          row:          $(element).attr('data-row')
          column:       $(element).attr('data-col')
          sizex:        $(element).attr('data-sizex')
          sizey:        $(element).attr('data-sizey')
          databaseid:   $(element).attr('data-databaseid')

        tilePositions.push current

    return tilePositions
