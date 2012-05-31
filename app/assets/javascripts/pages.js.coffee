# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery -> 
  $("#pages, ul[id^='child_']").sortable
    connectWith:'.ul-connectedSortable'
    handle: '.handle'
    placeholder: 'ui-state-highlight'
    opacity: 0.8
    update: (event, ui) ->
      $.post($("#pages").data('update-url'), $(this).sortable('serialize'))
      if ui.item.parent().attr('id') == 'pages' then $.post($("#pages").data('update-level-url'), {id: ui.item.attr('id').split('_')[1], parent_id: -1})
      else $.post($("#pages").data('update-level-url'), {id: ui.item.attr('id').split('_')[1], parent_id: ui.item.parent().attr('id').split('_')[1]}) 
      
    
  $("li[class~='li-page']").droppable
    greedy: true
    tolerance: 'pointer'

    
  $("#pages, ul[id^='child_']").disableSelection(); 
  
