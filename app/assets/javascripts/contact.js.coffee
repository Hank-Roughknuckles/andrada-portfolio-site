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
  #
  # show message in .alert box if body is blank or email address isn't
  # valid
  ##
  $(".contact_form :submit").click (event) ->
    emailRegex = /[-0-9a-zA-Z.+_]+@[-0-9a-zA-Z.+_]+\.[a-zA-Z]{2,4}/
    $email = $(".sender_email")
    $message = $(".body_form")

    if $message.val() is "" || !$email.val().match(emailRegex)

      $(".alert").text("Please enter both your email address and
      a message.")
      return false;
    else
      $(".actual_submit_button").trigger("click")
