# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#TODO: dry out the keyup methods

$ ->
  originalNavItem1 = $('#nav_item_link_1_name').val()
  originalNavItem2 = $('#nav_item_link_2_name').val()
  originalNavItem3 = $('#nav_item_link_3_name').val()
  originalNavItem4 = $('#nav_item_link_4_name').val()
  originalNavItem5 = $('#nav_item_link_5_name').val()

  $("#nav_item_link_1_name").keyup ->
    $('#nav_item_1 a').html($("#nav_item_link_1_name").val())
    if $("#nav_item_link_1_name").val() != originalNavItem1
      showSaveReminder()
    else
      hideSaveReminder()

  $("#nav_item_link_2_name").keyup ->
    $('#nav_item_2 a').html($("#nav_item_link_2_name").val())
    if $("#nav_item_link_2_name").val() != originalNavItem2
      showSaveReminder()
    else
      hideSaveReminder()

  $("#nav_item_link_3_name").keyup ->
    $('#nav_item_3 a').html($("#nav_item_link_3_name").val())
    if $("#nav_item_link_3_name").val() != originalNavItem3
      showSaveReminder()
    else
      hideSaveReminder()


  $("#nav_item_link_4_name").keyup ->
    $('#nav_item_4 a').html($("#nav_item_link_4_name").val())
    if $("#nav_item_link_4_name").val() != originalNavItem4
      showSaveReminder()
    else
      hideSaveReminder()

  $("#nav_item_link_5_name").keyup ->
    $('#nav_item_5 a').html($("#nav_item_link_5_name").val())
    if $("#nav_item_link_5_name").val() != originalNavItem5
      showSaveReminder()
    else
      hideSaveReminder()


  showSaveReminder = ->
    # TODO: dry this out to use the same method as about_me_content.js
    # TODO: make this just search for #save_reminder and if it returns
    # nil, then add the #save_reminder
    $("#save_reminder").remove()
    $(".edit_navbar").after("<div id=\"save_reminder\">You have changed a value. Please remember to press the save button.</div>");

  hideSaveReminder = ->
    if $("#nav_item_link_1_name").val() == originalNavItem1 && $("#nav_item_link_2_name").val() == originalNavItem2 && $("#nav_item_link_3_name").val() == originalNavItem3 && $("#nav_item_link_4_name").val() == originalNavItem4 && $("#nav_item_link_5_name").val() == originalNavItem5
      $("#save_reminder").remove()
