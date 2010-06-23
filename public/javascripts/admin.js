/*
 * Called from application.js on a page load
 */
function page_init() {
	alert('page init being called');	
}

function add_user() {
	var id = jQuery("#gbox_users").jqGrid('getGridParam','selrow');
	alert('add');
}

function edit_user() {
	alert('edit');
}

function delete_user() {
	alert('delete');
}

function show_blog_topic_field() {
	$('#blog_post_topic_field').show('slow');
}

function save_blog_topic() {
	topic = $('#blog_post_topic_entry').val();
	
	$.ajax({
	  url: '/blog_post_topics/ajax_save',
	  data: 'blog_post_topic=' + topic,
	  success: blog_topic_saved
	});
}

// Handle the async response from blog topic save
function blog_topic_saved(response) {
	$.ajax({
	  url: '/blog_post_topics/fetch_topic_list',
	  data: 'blog_post_id=' + blog_post_id,
	  success: function(data) {
		$('#blog_post_topic_list').replaceWith(data);
		}
	});
}
	 
