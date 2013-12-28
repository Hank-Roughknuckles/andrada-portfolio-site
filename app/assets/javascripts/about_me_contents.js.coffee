# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# attachHandlers = -> //uncomment when turbolinks is re-enabled

$ ->
  originalHeader = $('#header-form').val()
  originalDescription = $('#description-form').val()
  originalButtonTitle = $('#button-title-form').val()

  $("#header-form").keyup ->
    $('#header-preview').html($("#header-form").val())
    if $("#header-form").val() != originalHeader
      showSaveReminder()
    else
      hideSaveReminder()


  $("#description-form").keyup ->
    $('#description-preview').html($("#description-form").val())
    if $('#description-form').val() != originalDescription
      showSaveReminder()
    else
      hideSaveReminder()


  $("#button-title-form").keyup ->
    if $('#button-title-form').val() != originalButtonTitle
      showSaveReminder()
    else
      hideSaveReminder()


  # Change background of slide preview when upload a new image
  $("#background-image-upload").change (event) ->
    input = $(event.currentTarget)
    file = input[0].files[0]
    reader = new FileReader()
    reader.onload = (e) ->
      image_base64 = e.target.result
      $(".slide-preview .slide").css({"background": "url(#{image_base64})"})
      showSaveReminder()

    reader.readAsDataURL file

  showSaveReminder = ->
    # TODO: make this just search for #save-reminder and if it returns
    # nil, then add the #save-reminder
    $("#save-reminder").remove()
    $(".edit-navbar").after("<div id=\"save-reminder\">You have changed a value. Please remember to press the save button.</div>");

  hideSaveReminder = ->
    if $("#header-form").val() == originalHeader && $('#description-form').val() == originalDescription && $('#button-title-form').val() == originalButtonTitle
      $("#save-reminder").remove()


# $(document).on "page:load", attachHandlers //uncomment when turbolinks is re-enabled
