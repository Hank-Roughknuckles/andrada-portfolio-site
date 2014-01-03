# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# attachHandlers = -> //uncomment when turbolinks is re-enabled

$ ->
  originalHeader = $('#header_form').val()
  originalDescription = $('#description_form').val()
  originalButtonTitle = $('#button_title_form').val()

  $("#header_form").keyup ->
    $('#header_preview').html($("#header_form").val())
    if $("#header_form").val() != originalHeader
      showSaveReminder()
    else
      hideSaveReminder()


  $("#description_form").keyup ->
    $('#description_preview').html($("#description_form").val())
    if $('#description_form').val() != originalDescription
      showSaveReminder()
    else
      hideSaveReminder()


  $("#button_title_form").keyup ->
    if $('#button_title_form').val() != originalButtonTitle
      showSaveReminder()
    else
      hideSaveReminder()


  # Change background of slide preview when upload a new image
  $("#background_image_upload").change (event) ->
    input = $(event.currentTarget)
    file = input[0].files[0]
    reader = new FileReader()
    reader.onload = (e) ->
      image_base64 = e.target.result
      $(".slide_preview .slide").css({"background": "url(#{image_base64})"})
      showSaveReminder()

    reader.readAsDataURL file


  #Save reminder stuff
  showSaveReminder = ->
    if $(".save_reminder").text() == ""
      $(".save_reminder").text("You have changed a value. Please remember
      to press the save button.")


  hideSaveReminder = ->
    if $("#header_form").val() == originalHeader && $('#description_form').val() == originalDescription && $('#button_title_form').val() == originalButtonTitle
      $(".save_reminder").text("")


  #Button title edit stuff
  $("#button_title_form").focus ->
    if $("#button_title_description_helper").length == 0
      $("#button_title_form").after( "<div
      id=\"button_title_description_helper\">
      Button Title is the name for this slide that appears on the nav
      buttons in other slides
      </div>")
      $("#button_title_description_helper").fadeIn(200)

  $("#button_title_form").blur ->
    $("#button_title_description_helper").fadeOut(200)

# $(document).on "page:load", attachHandlers //uncomment when turbolinks is re-enabled
