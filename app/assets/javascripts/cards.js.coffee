# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
	$('#tweets').imagesLoaded ->
		$('#tweets').masonry itemSelector: ".box"

	$(document).ready ->
			text_max = 150
		 $('#textarea_feedback').html text_max + ' characters left'
		 $('#textarea').keyup ->
		    text_length = $('#textarea').val().length
		    text_remaining = text_max - text_length
		    $('#textarea_feedback').html text_remaining + ' characters left'
		    return
		  return

		if isadminuser is 'no'
		  if $('.pagination').length
		    $(window).scroll ->
		      url = $('.pagination .next_page').attr('href')
		      $('.vote-up').on('ajax:send', ->
		        $(this).addClass 'loading'
		        return
		      ).on('ajax:complete', ->
		        $(this).removeClass 'loading'
		        return
		      ).on('ajax:error', (e, xhr, status, error) ->
		        console.log status
		        console.log error
		        return
		      ).on 'ajax:success', (e, data, status, xhr) ->
		        $(this).html data.count
		        $(this).removeClass('fa fa-heart-o heart-color').addClass 'fa fa-heart heart-color'
		        return

		      $('.vote-down').on('ajax:send', ->
		        $(this).addClass 'loading'
		        return
		      ).on('ajax:complete', ->
		        $(this).removeClass 'loading'
		        return
		      ).on('ajax:error', (e, xhr, status, error) ->
		        console.log status
		        console.log error
		        return
		      ).on 'ajax:success', (e, data, status, xhr) ->
		        $(this).html data.count
		        $(this).removeClass('fa fa-thumbs-o-down thumb-color').addClass 'fa fa-thumbs-down thumb-color'
		        return
		        
		      if url and $(window).scrollTop() > $(document).height() - $(window).height() - 15
		        $('.pagination').text 'Loading...'
		        return $.getScript(url)
		      return
		    return $(window).scroll()
		  return
		return

		


