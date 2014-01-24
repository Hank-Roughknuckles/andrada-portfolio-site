# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ -> #DOM Ready

  $(".gridster ul").gridster
    widget_margins: [10, 10]
    widget_base_dimensions: [200, 200]

  $(".gridster ul li").click ->
    numberRegex = /[0-9]/
    number = this.id.match(numberRegex)
    $(".overlay_#{number}").show()
