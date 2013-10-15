# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $(".submit-on-blur").blur (ev) ->
    originalValue = parseInt($(this).data("value"))
    newValue = parseInt($(this).val())
    $(this).parent("form").submit() unless originalValue is newValue

  # Override confirmation
	$.rails.allowAction = (link) ->
    return true unless link.attr('data-confirm')
    $.rails.showConfirmDialog(link)
    false

  $.rails.confirmed = (link) ->
	  link.removeAttr('data-confirm')
	  link.trigger('click.rails')

  $.rails.showConfirmDialog = (link) ->
    $(".confirm_message").html(link.attr('data-confirm'))
    html = $("#modal_confirm").html()
    console.log 22, link, $("#modal_confirm"), $(".confirm_message"), html
    $(html).modal()
    false
    # $('#confirmationDialog .confirm').on 'click', -> $.rails.confirmed(link)