// foreword cms block starts
$(document).ready(function(){
   $.get('/getForeword', function(data){
       $('#foreword_content_div').html(data);
   });

   $.get('/getFooter', function(data){
       $('#footer_content_div').html(data);
   });
});

// foreword cms block ends

// home_tabs block starts

$('#home_tabs a').live('click', function(){
   var current_id = $(this).attr('tab_id');
   var tab_id = '#tab_id_' + current_id;

   // reset css class for all tab nodes
   $('#home_tabs a').each(function(){
        var current_child = '#' + $(this).attr('id');
        $(current_child).attr('class', $(tab_id).attr('class'));
   });

   var current = $(tab_id).attr('class').toString() + ' current';   
   $(tab_id).attr('class', current);

   $.get('/getHomePagePosts?' + 'tab_id=' + current_id, function(data){
        $('#home_page_posts_div').html(data);
   });

   return false;
});
// home_tabs block ends

// generic form POST-handler starts

$('#comments_div form').live('submit', function(){
    var post_id = $('#comment_post_id').val();
    var comments_div = '#comments_div_' + post_id;
    var comments_content_div = '#comments_content_div_' + post_id;
    var loading_msg = '<img src="/images/ajax-loading.gif" alt="loading ... "/>';
    $(comments_div).html(loading_msg);

    //post an ajaxian call
    $.post(this.action, $(this).serialize(), function(data){
        if(data.toString().indexOf("error_explanation") != -1){
            $(comments_div).html(data);
        }else{            
            $(comments_div).hide(400);

            $.get('/getCommentsContent' + '?post_id=' + post_id, function(data){
                $(comments_content_div).html(data).show(400);
            });

            $.get('/getCommentsCount' + '?post_id=' + post_id, function(data){
                $('#comments_count_link').html(data);
            });
        }
    });

    return false;
 });

// generic form POST-handler ends

// form for comments starts
$('#comments_link_div a').live('click', function(){
    var post_id = $(this).attr('post_id');
    var comments_div = '#comments_div_' + post_id;
   $.get('/getCommentsForm' + '?post_id=' + post_id, function(data){
      $(comments_div).html(data).show(400);
   });

   return false;
});

$('#reply_comments_link_div a').live('click', function(){
    var post_id = $(this).attr('post_id');
    var parent_id = $(this).attr('parent_id');
    var comments_div = '#reply_comments_div_' + parent_id;
   $.get('/getCommentsForm' + '?post_id=' + post_id +
       '&parent_id=' + parent_id , function(data){
      $(comments_div).html(data).show(400);
   });

   return false;
});

// form for comments ends

// comments display toggle starts

$('#comments_count_link a').live('click', function(){
    var post_id = $(this).attr('post_id');
    var comments_div = '#comments_content_div_' + post_id;
    $(comments_div).toggle();

    return false;
});

// comments display toggle ends