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
  # changes the debug information (shown in the span in each tile) for the
  # inputted tile.  The new value of the debugging info is dependent on
  # the info object in the argument.  Note: This function will only change
  # the debugging info if debugging is enabled (i.e. - there is already
  # a span child element in the tile argument)
  #
  # @param JqueryObject tile - the jquery object for a <li> element inside
  #   the gridster ul
  # @param Object info - an object with of the following form
  #   info = {  row,
  #             column,
  #             sizex,
  #             sizey  }
  updateTileDebugInfo = (tile, info) ->
    if tile.find("span").length > 0
      tile.find("span").html("row: #{info.row} <br>col: #{info.column} <br>sizex: #{info.sizex} <br>sizey: #{info.sizey}")


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


  ##
  # checkMediaLinkSyntax
  #
  # Checks whether the value of #media_link_input matches a vimeo or
  # youtube link and calls showlinkerror or showlinksuccess depending
  #
  checkMediaLinkSyntax = () ->
    link = $("#media_link_input").val()
    if (link.match(/youtube\.com\/.+/) || link.match(/vimeo\.com/))
      showLinkSuccess()
    else
      showLinkError()


  ##
  # showLinkError
  # 
  # Adds .has-error to .link_input_group to make the inputs red. Also
  # displays an error message in the .preview_errors span
  showLinkError = () ->
    linkGroup = $(".link_input_group")
    linkGroup.removeClass("has-success");
    linkGroup.addClass("has-error");
    $("span.preview_errors").html("Please use a youtube or vimeo link");


  ##
  # showLinkSuccess
  #
  # Adds .has-success to .link_input_group to make the inputs green. Also
  # removes any error messages in the .preview_errors span
  showLinkSuccess = () ->
    linkGroup = $(".link_input_group")
    linkGroup.addClass("has-success");
    linkGroup.removeClass("has-error");
    $("span.preview_errors").html("");



#####   The main functions   #####

  #Turn on gridster
  $(".gridster ul").gridster
    widget_margins: [tileMarginX, tileMarginY],
    widget_base_dimensions: [tileWidth, tileHeight],
    max_cols: 6,
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


  #Form stuff
  #Forms will update displays as they are altered

  #Update header
  updateHeader = ->
    $('.content_preview .content_header')
      .html($("form .header_input")
      .val())

  $("form .header_input")
    .keyup -> updateHeader()
    .change -> updateHeader()


  #Update description
  updateDescription = ->
    $('.content_preview .content_description')
      .html($("form .description_input")
      .val())

  $("form .description_input")
    .keyup -> updateDescription()
    .change -> updateDescription()


  #Update Progress
  updateProgress = ->
    $('.content_preview .progress_amount')
      .html("#{$("form .progress_input")
      .val()}% Completed")

  $("form .progress_input")
    .keyup -> updateProgress()
    .change -> updateProgress()




  #Video link preview stuff
  #========================

  #Show preview of linked video when click .preview_video_link
  $(".preview_video_link").click ->
    link = $("#media_link_input").val()

    if link.match /youtube\.com\/.+/
      youtubeID = link.match(/v=([^&]*)/)[1]
      $(".content_preview .media_viewer")
        .replaceWith("<iframe class=\"media_viewer\" width=\"633\" 
          height=\"475\" src=\"//www.youtube.com/embed/#{youtubeID}\" 
          frameborder=\"0\" allowfullscreen></iframe>")
      showLinkSuccess()

    else if link.match /vimeo\.com/
      #handle vimeo link
      vimeoID = link.match(/^((http[s]?|ftp):\/)?\/?([^:\/\s]+)((\/\w+)*\/)([\w\-\.]+[^#?\s]+)(.*)?(#[\w\-]+)?$/)[6]
      $(".content_preview .media_viewer")
        .replaceWith("<iframe class=\"media_viewer\" 
          width=\"633\" height=\"475\"
          src=\"//player.vimeo.com/video/#{vimeoID}\"
          frameborder=\"0\" webkitallowfullscreen mozallowfullscreen
          allowfullscreen></iframe>")
      showLinkSuccess()

    else
      showLinkError();


  #Show error or success message for media link on focus and on keyup
  $("#media_link_input")
    .focus -> checkMediaLinkSyntax()
    .keyup -> checkMediaLinkSyntax()
    .change -> checkMediaLinkSyntax()
    .click -> checkMediaLinkSyntax()


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
  
 
