# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $('.set-student').click ->
    $.ajax
      url: 'users/set_student'
      type: 'GET'
      dataType: 'html'
      success: (data) ->
        $('.set-student').hide()
        $('.choose-student').show()
        $('.choose-student').append(data)
