$ -> #DOM ready

  miniTileWidth = 50
  miniTileHeight = 50
  miniTileMarginX = 2
  miniTileMarginY = 2

  $(".gridster ul").gridster
    widget_margins: [miniTileMarginX, miniTileMarginY]
    widget_base_dimensions: [miniTileWidth, miniTileHeight]
    draggable: {
      start: (e, ui, $widget) ->
        dragged = true;
    }
  gridster = $(".gridster ul").gridster().data('gridster');
