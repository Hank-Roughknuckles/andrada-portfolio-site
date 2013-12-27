# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


# attachHandlers = -> //uncomment when turbolinks is re-enabled

$ ->
  $("#header-form").keyup ->
    $('#header-preview').html($("#header-form").val())


  $("#description-form").keyup ->
    $('#description-preview').html($("#description-form").val())


  preview = $(".upload-preview img")

  # Change background of slide preview when upload a new image
  $("#background-image-upload").change (event) ->
    input = $(event.currentTarget)
    file = input[0].files[0]
    reader = new FileReader()
    reader.onload = (e) ->
      image_base64 = e.target.result
      $(".slide-preview .slide").css({"background": "url(#{image_base64})"})

    reader.readAsDataURL file

# $(document).on "page:load", attachHandlers //uncomment when turbolinks is re-enabled

