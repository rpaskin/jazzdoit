# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $(".submit-on-blur").blur (ev) ->
    originalValue = $(this).data("value").toString()
    newValue = $(this).val().toString()
    $(this).closest("form").submit() unless originalValue is newValue
