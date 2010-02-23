/*
Copyright 2009 Timothy Fisher

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
 */

dojo.addOnLoad(site_init);

/*
 * Perform site-wide initialization
 */
function site_init() {	
	load_widgets();
	// if the current page has a page_init function, call that
	if(typeof page_init == 'function') { 
		page_init();
	}
}



function $(id) {
	return document.getElementById(id);	
}

function submit_wall_post() {
	before_wall_post();
	dojo.xhrPost({
	    form: "wall_post_entry_form",
	    timeout: 3000, // give up after 3 seconds
	    content: { authenticity_token:authenticity_token },
		load: function (data) {wall_post_saved(data);}
	});
	//return false;
}

function delete_wall_post(id) {
	dojo.xhrPost({
		url: '/wall_posts/delete',
	    timeout: 3000, // give up after 3 seconds
	    content: { id:id, authenticity_token:authenticity_token },
		load: function (data) {wall_post_deleted(data);}
	});	
}

function wall_post_deleted(request) {
	$('wall_posts_content').innerHTML = request;
	// clear wall post message area, need to clear tinymce i think
	$('wall_post_message').value == '';
}

function before_wall_post() {
	tinyMCE.triggerSave(true,true);
	$('wall_post_entry').style.display = 'none';
}

// have to call this after the new tinymce editor is loaded upon a save
// tinyMCE.execCommand('mceAddControl', false, id); 


function wall_post_saved(request) {
	$('wall_posts_content').innerHTML = request;
	// clear wall post message area, need to clear tinymce i think
	$('wall_post_message').value == '';
}

function show_wall_post_entry() {
	var wipeIn = dojo.fx.wipeIn({node: "wall_post_entry",duration: 200});
	wipeIn.play();
}

function cancel_wall_post() {
	var wipeOut = dojo.fx.wipeOut({node: "wall_post_entry",duration: 200});
	wipeOut.play();
}

/*
$(document).ajaxSend(function(event, request, settings) {
  if (typeof(AUTH_TOKEN) == "undefined") return;
  // settings.data is a serialized string like "foo=bar&baz=boink" (or null)
  settings.data = settings.data || "";
  settings.data += (settings.data ? "&" : "") + "authenticity_token=" + encodeURIComponent(AUTH_TOKEN);
}); */

function handle_promote_to_admin_btn() {
	var rows = dijit.byId('gridNode').selection.getSelected();
	for (i=0; i<rows.length; i++) {
		// send ajax request to promote user to group admin
		dojo.xhrPost({
			url: '/memberships/update',
		    timeout: 3000, // give up after 3 seconds
		    content: { id:rows[i].id, admin:true, authenticity_token:authenticity_token },
			load: function (data) {member_promoted(data);}
		});	
	}
}

function member_promoted(data) {
	alert('member promoted = ' + data);
}

function handle_demote_from_admin_btn() {
	var rows = dijit.byId('gridNode').selection.getSelected();
	for (i=0; i<rows.length; i++) {
		// send ajax request to demote user from group admin
		dojo.xhrPost({
			url: '/memberships/update',
		    timeout: 3000, // give up after 3 seconds
		    content: { id:rows[i].id, admin:false, authenticity_token:authenticity_token },
			load: function (data) {member_demoted(data);}
		});	
	}
}

function member_promoted(data) {
	alert('member promoted = ' + data);
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
	var drafts = dojo.query(".blog_post_draft");
	if (drafts.length > 0 && (drafts[0].style.display == 'none' || drafts[0].style.display == '')) {
		// select all elements with class 'blog_post_draft' and change display
		// property to 'block'
		for (i=0; i<drafts.length; i++) {
			drafts[i].style.display = 'block';
		}
		$('show_drafts_btn').innerHTML = 'Hide Drafts';
	}
	else if (drafts.length > 0) {
		// select all elements with class 'blog_post_draft' and change display
		// property to 'hide'
		for (i=0; i<drafts.length; i++) {
			drafts[i].style.display = 'none';
		}
		$('show_drafts_btn').innerHTML = 'Show Drafts';
	}
}

function post_status(event) {
    //event.preventDefault();
    //event.stopPropagation();
	dojo.xhrPost({
	    form: "status_post_entry_form",
	    timeout: 3000, // give up after 3 seconds
	    content: { authenticity_token:authenticity_token },
		load: function (data) {status_post_saved(data);}
	});
}

// Called after new status successfully posted to server
// now we want to refresh the activity stream and activity post widgets to reflect new content
function status_post_saved(data) {
	refresh_profile_widget('activity_feed_profile');
	refresh_profile_widget('status_posts_profile');
}

function refresh_profile_widget(widget_name) {
	dojo.xhrGet({
		url: '/widgets/load_profile_widget',
	    timeout: 10000, // give up after 3 seconds
	    content: { name:widget_name, user_id:user_id, authenticity_token:authenticity_token },
		error: function (data) {widget_load_error(widget_name, data);},
		load: function (data) {widget_loaded(widget_name, data);}
	});		
}

function refresh_home_widget(widget_name) {
	dojo.xhrGet({
		url: '/widgets/load',
	    timeout: 10000, // give up after 3 seconds
	    content: { name:widget_name, user_id:user_id, authenticity_token:authenticity_token },
		error: function (data) {widget_load_error(widget_name, data);},
		load: function (data) {widget_loaded(widget_name, data);}
	});		
}

/*
 * Called when the Only Statuses checkbox is checked in the activity stream of a users profile page.
 */
function filter_activities() {
	var status = dojo.byId('status_checkbox').checked;
	var include_friends = dojo.byId('friends_checkbox').checked;
	if (status == true && include_friends == true) {
		dojo.xhrGet({
			url: '/widgets/load_profile_widget',
		    timeout: 10000, // give up after 10 seconds
		    content: { name:'activity_feed_profile', only_statuses:'true', include_friends:'true', user_id:user_id, authenticity_token:authenticity_token },
			error: function (data) {widget_load_error('activity_feed_profile', data);},
			load: function (data) {widget_loaded('activity_feed_profile', data);}
		});	
	}
	else if (status == true) {
		dojo.xhrGet({
			url: '/widgets/load_profile_widget',
		    timeout: 10000, // give up after 10 seconds
		    content: { name:'activity_feed_profile', only_statuses:'true', user_id:user_id, authenticity_token:authenticity_token },
			error: function (data) {widget_load_error('activity_feed_profile', data);},
			load: function (data) {widget_loaded('activity_feed_profile', data);}
		});	
	}
	else if (include_friends == true) {
		dojo.xhrGet({
			url: '/widgets/load_profile_widget',
		    timeout: 10000, // give up after 10 seconds
		    content: { name:'activity_feed_profile', include_friends:'true', user_id:user_id, authenticity_token:authenticity_token },
			error: function (data) {widget_load_error('activity_feed_profile', data);},
			load: function (data) {widget_loaded('activity_feed_profile', data);}
		});	
	}
	else {
		refresh_profile_widget('activity_feed_profile')
	}
}

/*
 * Called when the Only Friends checkbox is checked in the activity stream on the home page.
 */
function only_friends_activities() {
	var include_friends = dojo.byId('friends_checkbox').checked;
	if (include_friends == true) {
		dojo.xhrGet({
			url: '/widgets/load',
		    timeout: 10000, // give up after 10 seconds
		    content: { name:'activity_feed_home', include_friends:'true', authenticity_token:authenticity_token },
			error: function (data) {widget_load_error('activity_feed_home', data);},
			load: function (data) {widget_loaded('activity_feed_home', data);}
		});	
	}
	else {
		refresh_home_widget('activity_feed_home')
	}
}

/*
 * Called when the Include Friends checkbox is checked in the activity stream of a user's profile page.
 */
function friends_activities() {
	var status = dojo.byId('status_checkbox').checked;
	var include_friends = dojo.byId('friends_checkbox').checked;
	if (status == true && include_friends == true) {
		dojo.xhrGet({
			url: '/widgets/load_profile_widget',
		    timeout: 10000, // give up after 10 seconds
		    content: { name:'activity_feed_profile', only_statuses:'true', include_friends:'true', user_id:user_id, authenticity_token:authenticity_token },
			error: function (data) {widget_load_error('activity_feed_profile', data);},
			load: function (data) {widget_loaded('activity_feed_profile', data);}
		});	
	}
	else if (include_friends == true) {
		dojo.xhrGet({
			url: '/widgets/load_profile_widget',
		    timeout: 10000, // give up after 10 seconds
		    content: { name:'activity_feed_profile', include_friends:'true', user_id:user_id, authenticity_token:authenticity_token },
			error: function (data) {widget_load_error('activity_feed_profile', data);},
			load: function (data) {widget_loaded('activity_feed_profile', data);}
		});	
	}
	else if (status == true) {
		dojo.xhrGet({
			url: '/widgets/load_profile_widget',
		    timeout: 10000, // give up after 10 seconds
		    content: { name:'activity_feed_profile', only_statuses:'true', user_id:user_id, authenticity_token:authenticity_token },
			error: function (data) {widget_load_error('activity_feed_profile', data);},
			load: function (data) {widget_loaded('activity_feed_profile', data);}
		});	
	}
	else {
		refresh_profile_widget('activity_feed_profile')
	}
}

function add_new_topic() {
	alert('new topic');
}

function message_delete() {
	alert('delete');
}

function add_blog_post_comment() {
	//tinyMCE.triggerSave(true,true);
	dojo.xhrPost({
	    form: "comment_entry_form",
	    timeout: 3000, // give up after 3 seconds
	    content: { authenticity_token:authenticity_token },
		load: function (data) {blog_post_comment_saved(data);}
	});
}

function blog_post_comment_saved(request) {
	$('blog_post_comments_area').innerHTML = request;
}

function add_photo_comment() {
	//tinyMCE.triggerSave(true,true);
	dojo.xhrPost({
	    form: "comment_entry_form",
	    timeout: 3000, // give up after 3 seconds
	    content: { authenticity_token:authenticity_token },
		load: function (data) {photo_comment_saved(data);}
	});
}

function photo_comment_saved(request) {
	$('photo_comments_area').innerHTML = request;
}

function submit_forum_post_reply() {
	tinyMCE.triggerSave(true,true);
	dojo.xhrPost({
	    form: "forum_post_reply_form",
	    timeout: 3000, // give up after 3 seconds
	    content: { authenticity_token:authenticity_token },
		load: function (data) {forum_post_reply_saved(data);}
	});	
}

function forum_post_reply_saved(request) {
	$('existing_replies').innerHTML = request;
	tinyMCE.activeEditor.setContent("");
}

