$ -> #DOM ready

  miniTileWidth = 75
  miniTileHeight = 75
  miniTileMarginX = 2
  miniTileMarginY = 2

  $(".gridster ul").gridster
    widget_margins: [miniTileMarginX, miniTileMarginY]
    widget_base_dimensions: [miniTileWidth, miniTileHeight]
    helper: 'clone',
    resize: { enabled: true },

  gridster = $(".gridster ul").gridster().data('gridster');
