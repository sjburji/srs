// foreword cms block starts
$(document).ready(function(){
   $.get('/getForeword', function(data){
       $('#foreword_content_div').html(data);
   });
});

// foreword cms block ends

// home_tabs block starts

$('#home_tabs a').live('click', function(){
   var current_id = $(this).attr('tab_id');
   var tab_id = '#tab_id_' + current_id;

   // reset css class for all tab nodes
   $('#home_tabs a').each(function(i){
        var current_child = '#' + $(this).attr('id');
        $(current_child).attr('class', $(tab_id).attr('class'));
   });

   var current = $(tab_id).attr('class').toString() + ' current';   
   $(tab_id).attr('class', current);

   return false;
});
// home_tabs block ends