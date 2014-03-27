# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  ##
  # Show the conact form when the .form_show button is clicked
  ##
  $(".form_show").click ->
    $(".contact_form").fadeIn(250)
    $(".sender_email").focus()


  ##
  # Validate form information
  ##
  $(".contact_form_submit").click ->
    if $(".sender_email").val() is "" || $(".body_form").val() is ""
      $(".alert").text("Please enter both your email address and
      a message.")
    else
      $(".actual_submit_button").trigger("click")
