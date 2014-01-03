# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#TODO: dry out the keyup methods

$ ->
  originalNavItem1 = $('#nav_1_edit').val()
  originalNavItem2 = $('#nav_2_edit').val()
  originalNavItem3 = $('#nav_3_edit').val()
  originalNavItem4 = $('#nav_4_edit').val()
  originalNavItem5 = $('#nav_5_edit').val()

  $("#nav_1_edit").keyup ->
    $('#nav_item_1 a').html($("#nav_1_edit").val())
    if $("#nav_1_edit").val() != originalNavItem1
      showSaveReminder()
    else
      hideSaveReminder()

  $("#nav_2_edit").keyup ->
    $('#nav_item_2 a').html($("#nav_2_edit").val())
    if $("#nav_2_edit").val() != originalNavItem2
      showSaveReminder()
    else
      hideSaveReminder()

  $("#nav_3_edit").keyup ->
    $('#nav_item_3 a').html($("#nav_3_edit").val())
    if $("#nav_3_edit").val() != originalNavItem3
      showSaveReminder()
    else
      hideSaveReminder()


  $("#nav_4_edit").keyup ->
    $('#nav_item_4 a').html($("#nav_4_edit").val())
    if $("#nav_4_edit").val() != originalNavItem4
      showSaveReminder()
    else
      hideSaveReminder()

  $("#nav_5_edit").keyup ->
    $('#nav_item_5 a').html($("#nav_5_edit").val())
    if $("#nav_5_edit").val() != originalNavItem5
      showSaveReminder()
    else
      hideSaveReminder()


  showSaveReminder = ->
    # TODO: dry this out to use the same method as about_me_content.js
    # TODO: make this just search for #save_reminder and if it returns
    # nil, then add the #save_reminder
    if $("#save_reminder").text() == ""
      $("#save_reminder").text("You have changed a value. Please remember
      to press the save button.")
      $(".save").addClass("btn-danger");

  hideSaveReminder = ->
    if $("#nav_1_edit").val() == originalNavItem1 && $("#nav_2_edit").val() == originalNavItem2 && $("#nav_3_edit").val() == originalNavItem3 && $("#nav_4_edit").val() == originalNavItem4 && $("#nav_5_edit").val() == originalNavItem5
      $("#save_reminder").text("")
      $(".save").removeClass("btn-danger");
