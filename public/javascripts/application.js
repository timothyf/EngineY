/*
	Simple jQuery Theme Script
 */
if(typeof page_data === "undefined") {
	page_data = {};
}

$(document).ready(function() {
	site_init();
});


/*
 * Perform site-wide initialization
 */
function site_init() {	
	if (page_data.widgets) {
		page_data.widgets.load();
	}
	// if the current page has a page_init function, call that
	if(typeof page_init == 'function') { 
		page_init();
	}
}

function handle_promote_to_admin_btn() {
	var rows = dijit.byId('gridNode').selection.getSelected();
	for (i=0; i<rows.length; i++) {
		// send ajax request to promote user to group admin
		$.post('/memberships/update',
			   { id:rows[i].id, admin:true },
			   function (data) {member_promoted(data);}
			);
	}
}

function member_promoted(data) {
	alert('member promoted = ' + data);
}

function handle_demote_from_admin_btn() {
	var rows = dijit.byId('gridNode').selection.getSelected();
	for (i=0; i<rows.length; i++) {
		// send ajax request to demote user from group admin
		$.post('/memberships/update',
			   { id:rows[i].id, admin:false },
			   function (data) {member_demoted(data);}
			);
	}
}

function member_demoted(data) {
	alert('member demoted = ' + data);
}

function handle_remove_from_group_btn() {
	var rows = dijit.byId('gridNode').selection.getSelected();
	for (i=0; i<rows.length; i++) {
		alert(rows[i].id);
		// send ajax request to remove user from group
		// goes through the membership controller
	}
}

function handle_select_all_members() {
	if ($("manage_group_users_table" + " INPUT[type='checkbox']").attr('checked') == false) {
		$("manage_group_users_table" + " INPUT[type='checkbox']").attr('checked', false);
	}
	else {
		$("manage_group_users_table" + " INPUT[type='checkbox']").attr('checked', true);
	}
    return false;
}

function sort_users() {
	location.href = 'users?sort_field=' + $("sort_users_sel").value;
}

function display_blog_settings() {
	if (document.getElementById('blog_settings').style.display == 'none') {
		// get current settings from server
		
		// display settings
		document.getElementById('blog_settings').style.display="block";
	}
	else {
		// hide settings
		document.getElementById('blog_settings').style.display="none";
		
		// save to server
		//   call RssFeedsController.update method
		// after save, redisplay blog widget
	}
}

function show_blog_drafts() {
	if ($('#show_drafts_btn').html() == 'Show Drafts') {
		$(".blog_post_draft").css("display","block");
		$('#show_drafts_btn').html('Hide Drafts');
	}
	else {
		$(".blog_post_draft").css("display","none");
		$('#show_drafts_btn').html('Show Drafts');	
	}
}

// Called to post a status update
function post_status(event) {
	var activity_widget_id = $("#activity_widget_id").val();
	var status_post_widget_id = $("#widget_id").val();
	$.post('/status_posts/create',
	       $("#status_post_entry_form").serialize(),
		   function (data) {status_post_saved(data, status_post_widget_id, activity_widget_id);});
}

// Called after new status successfully posted to server
// now we want to refresh the activity stream and activity post widgets to reflect new content
function status_post_saved(data, status_post_widget_id, activity_widget_id) {
	page_data.widgets.find_widget_by_id(status_post_widget_id).load();
	page_data.widgets.find_widget_by_id(activity_widget_id).load();
}

/*
 * Called when the Only Statuses checkbox is checked in the activity stream of a users profile page.
 */
function filter_activities(widget_id) {
	var status = $('#status_checkbox').attr('checked');
	var include_friends = $('#friends_checkbox').attr('checked');
	
	var only_statuses = (status == true ? 'true':'false')
	var include_friends = (include_friends == true ? 'true':'false')
	
	var activities_widget = page_data.widgets.find_widget_by_id(widget_id);
	activities_widget.properties = {only_statuses:only_statuses, include_friends:include_friends};
	activities_widget.load();
}

/*
 * Called when the Only Friends checkbox is checked in the activity stream on the home page.
 */
function only_friends_activities(widget_id) {
	var include_friends = $('#friends_checkbox').attr('checked');	
	include_friends = (include_friends == true ? 'true':'false')	
	var activities_widget = page_data.widgets.find_widget_by_id(widget_id);
	activities_widget.properties = {include_friends:include_friends};
	activities_widget.load();
}

function add_new_topic() {
	alert('new topic');
}

function message_delete() {
	alert('delete');
}

function add_blog_post_comment() {
	//tinyMCE.triggerSave(true,true);
	$.post('/blog_posts/add_comment',
		   $("#comment_entry_form").serialize(),
		   function (data) {blog_post_comment_saved(data);});
}

function blog_post_comment_saved(request) {
	$('#blog_post_comments_area').html(request);
}

function add_photo_comment() {
	//tinyMCE.triggerSave(true,true);
	$.post('/photos/add_comment',
		   $("#comment_entry_form").serialize(),
		   function (data) {photo_comment_saved(data);});
}

function photo_comment_saved(request) {
	$('#photo_comments_area').html(request);
}

function submit_forum_post_reply() {
	tinyMCE.triggerSave(true,true);
	$.post($("#forum_post_reply_path").val(),
		   $("#forum_post_reply_form").serialize(),
		   function (data) {forum_post_reply_saved(data);});
}

function forum_post_reply_saved(request) {
	$('#existing_replies').html(request);
	tinyMCE.activeEditor.setContent("");
}

function like_activity_item(activity_id, user_id, like_id) {
	$.post('/likes.json',
		   '&user_id=' + user_id + '&likable_id=' + activity_id +'&likable_type=Activity',
		   function (data) {activity_like_saved(data, activity_id, user_id, like_id);});
}

function unlike_activity_item(activity_id, user_id, like_id) {
	$.ajax({url:'/likes/' + like_id + '.json',
			type: 'POST',
		    data: '_method=delete',
			dataType: 'text',
		    success: function (data) {activity_like_saved(data, activity_id, user_id, like_id);},
		   });
}

function activity_like_saved(data, activity_id, user_id, like_id) {
	if (data.id) {
		like_id = data.id;
	}
	$.get('/likes/like_text',
	      '&activity_id=' + activity_id,
	      function(data) {update_like_text(data, activity_id, user_id, like_id);})
}

function update_like_text(data, activity_id, user_id, like_id) {
	$('#like_users' + activity_id).html(data);	
	// change like/dislike link
	if ($('#like_lnk_' + activity_id).html() == 'Unlike') {
		$('#like_lnk_' + activity_id).html('Like');
		var href = "javascript:like_activity_item(" + activity_id + ", " + user_id + "," + like_id + ")";
		$('#like_lnk_' + activity_id).attr("href", href);
	}
	else {
		$('#like_lnk_' + activity_id).html('Unlike');
		var href = "javascript:unlike_activity_item(" + activity_id + ", " + user_id + "," + like_id + ")";
		$('#like_lnk_' + activity_id).attr("href", href);
	}
}
