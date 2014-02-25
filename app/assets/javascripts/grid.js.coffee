$ -> #DOM Ready

  grid_width = $(".gridster ul").width()
  max_columns = 6
  tileMarginX = 5
  tileMarginY = 5
  tileWidth = (grid_width - 2 * tileMarginX * (max_columns - 1) + tileMarginX * 2) / max_columns
  tileHeight = tileWidth
  currentLightbox = null #id of the currently expanded lightbox
  uploadedImage = null
  dragged = false
  gridster = null

#####   Functions   #####
  ##
  # showLightbox
  #
  showLightbox = (lightbox) ->
    $(".overlay").show()
    lightbox.show()

    lightboxNumber = lightbox.attr("class").match(/[0-9]+/)[0]
    if $(".progress_bar_#{lightboxNumber}").length > 0
      showProgressBar $(".progress_bar_#{lightboxNumber}"), {animate: true}


  ##
  # closeLightbox
  #
  closeLightbox = (lightbox) ->
    $(".overlay").hide()

    if lightbox == "crop"
      lightbox = "crop_image_lightbox"
      $(".crop_image_popup").hide()
    else
      $(".content_#{lightbox}").hide()
      $(".content_preview .content_#{lightbox}").show()

      if $(".progress_bar_#{lightbox}").length > 0
        $(".progress_bar_#{lightbox}").css("width", 0 )

    currentLightbox = null;


  ##
  # showSaveReminder
  #
  showSaveReminder = ->
    # console.log "NOTE: make showSaveReminder"
    return


  ##
  # deleteTile
  #
  deleteTile = (lightboxNumber) ->
    $("input#delete_item_#{lightboxNumber}").trigger("click")


  ##
  # updateTileDebugInfo
  #
  updateTileDebugInfo = (tile, info) ->
    console.log "updateTileDebugInfo called!"

  ##
  # getPositions
  #
  getPositions = ->
    tilePositions = []
    # console.log "searching gridster elements..."
    $(".gridster ul li").each (i, element) ->
      # console.log "current element = "
      # console.log element
      if $(element).attr('data-row') && $(element).attr('data-col') && $(element).attr('data-sizex') && $(element).attr('data-sizey')
        # console.log "saving position of #{element.id}: row = #{$(element).attr('data-row')}, col = #{$(element).attr('data-col')}, sizex = #{$(element).attr('data-sizex')}, sizey = #{$(element).attr('data-sizey')}, databaseID = #{$(element).attr('data-databaseID')}"
        current = 
          row:          $(element).attr('data-row')
          column:       $(element).attr('data-col')
          sizex:        $(element).attr('data-sizex')
          sizey:        $(element).attr('data-sizey')
          databaseid:   $(element).attr('data-databaseid')

        tilePositions.push current

        updateTileDebugInfo $(element), current

    return JSON.stringify(tilePositions)


  ##
  # showProgressBar
  #
  showProgressBar = (progressBar, options) ->
    if options['value']
      progress = options['value']
    else
      progressBarNumber = progressBar.attr("class").match(/[0-9]+/)[0]
      progress = $(".content_progress_#{progressBarNumber}").html().match(/[0-9]+/)[0]

    progressBar.css("background-color", getProgressBarColor(progress) )

    if options['animate']
      progressBar.animate {width: getProgressBarSize(progress)}
    else
      progressBar.css("width", getProgressBarSize(progress) )
    return


  ##
  # getProgressBarSize
  #
  getProgressBarSize = (progress) ->
    maxWidth = 205

    if progress > 100
      return "#{maxWidth}px"
    if progress < 0
      return "0"

    # min = 0, max = 205
    width = progress * maxWidth / 100
    return "#{width}px"


  ##
  # getProgressBarColor
  #
  getProgressBarColor = (progress) ->
    # Return red if greater than 100, green if < 0
    if progress > 100
      return "#00FF00"
    if progress < 0
      return "FF0000"

    redHex = Math.round((-2.55 * progress) + 255)
    greenHex = Math.round(2.55 * progress)
    return "rgb(#{redHex}, #{greenHex}, 0)"



#####   The main functions   #####

  #Turn on gridster
  $(".gridster ul").gridster
    widget_margins: [tileMarginX, tileMarginY],
    widget_base_dimensions: [tileWidth, tileHeight],
    max_rows: 6,
    draggable: {
      start: (e, ui, $widget) ->
        # console.log "dragging!"
        dragged = true

      stop: (e, ui, $widget) ->
        # console.log "drag stopped. saving positions..."
        setTimeout(getPositions, 200)
        dragged = false
    }
  gridster = $(".gridster ul").gridster().data('gridster');


  #if page is an edit page, make the progress bar at start
  if document.URL.match(/current_project.+edit/)
    mainContentNumber = $(".content_preview .content_detail").attr("class").match(/[0-9]+/)[0]
    showProgressBar $(".progress_bar_#{mainContentNumber}"), { value: $("#current_project_progress").val(), animate: true }

    #set progress bar to amount in form field when the field changes
    $("#current_project_progress").change ->
      showProgressBar $(".progress_bar_#{mainContentNumber}"), { value: $("#current_project_progress").val() }
    return


  #if #drag_disabled exists, then don't let the user drag tiles
  if $("#drag_disabled").length > 0
    gridster.disable();


  #Add a "new" tile if the user in in the new view
  if document.URL.match(/new/)
    gridster.add_widget '<li class="new highlighted" data-databaseid="new">New item</li>', 1, 1


  $(".close, .overlay").click ->
    closeLightbox(currentLightbox)


  #Show lightbox when a tile is clicked
  $(".expand_tile").mouseup ->
    # console.log "finished clicking on a tile! dragged = #{dragged}"
    if !dragged
      numberRegex = /[0-9]+/
      currentLightbox = @id.match(numberRegex)
      showLightbox $(".content_#{currentLightbox}")


  # Buttons for deleting tiles
  $(".gridster li .tile_delete").click ->
    lightboxID = @id.match(/tile_delete_([0-9]+)/)[1]

    if confirm("Are you sure you want to delete this? This can't be undone")
      deleteTile lightboxID


  # Buttons on each tile for editing
  $(".gridster li .tile_edit").click ->
    lightboxID = @id.match(/tile_edit_([0-9]+)/)[1]
    address = $("#edit_item_#{lightboxID}").attr("href")
    window.location.replace(address)


  #Toggle edit tools button
  $(".toggle_edit_tools").click ->
    $(".edit_tools").toggle()


  # Open image edit lightbox when upload a new image
  $(".grid_tile_image_upload").change (event) ->
    currentElement = $.trim($(".current_element_id").text())
    input = $(event.currentTarget)
    file = input[0].files[0]
    reader = new FileReader()
    reader.onload = (e) ->
      uploadedImage = e.target.result
      showSaveReminder()
    reader.readAsDataURL file


  #Upload different image when "Change image" is clicked in the crop image
  #popup
  $(".crop_image_popup .crop_change_image").click ->
    $("#grid_tile_image").trigger('click');


  $("#save_position_and_content_forms").click ->
    # console.log "submitting grid_position_form"
    $("input#serialized_array").val(getPositions())
    # console.log $("input#serialized_array").val()
    $(".edit_grid_position").submit()

    $("#content_form").submit()


  # ##
  # # showCropPopup
  # #
  # showCropPopup = (image) ->
  #   buildCropPopup()
  #   $(".crop_image_popup").show()
  #   currentLightbox = "crop"
  #
  #
  # ##
  # # buildCropPopup
  # #
  # buildCropPopup = ->
  #   imageDimensions = getImageDimensions(uploadedImage)
  #   imageDimensions = scaleDownImage(imageDimensions, {width: 225, height: 190})
  #   $(".image_preview").attr
  #     src: uploadedImage,
  #     width: imageDimensions.width,
  #     height: imageDimensions.height


  # ##
  # # getImageDimensions
  # #
  # getImageDimensions = (passed_image) ->
  #   i = new Image()
  #   i.src = passed_image
  #   return { width: i.width, height: i.height }


  # ##
  # # scaleDownImage
  # #
  # scaleDownImage = ( original, maxDimensions ) ->
  #   #if original is smaller than max size
  #   if original.width <= maxDimensions.width && original.height <= maxDimensions.height
  #     return original
  #
  #
  #   if original.width <= original.height
  #     factor = original.height / maxDimensions.height
  #   else
  #     factor = original.width / maxDimensions.width
  #
  #   if factor >= 1
  #     original.width = original.width / factor
  #     original.height = original.height / factor
  #   else
  #     original.width = original.width * factor
  #     original.height = original.height * factor
  #
  #   return original
  
 
