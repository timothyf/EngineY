function submit_wall_post() {
	before_wall_post();
	$.post("/wall_posts/create", 
		   $("#wall_post_entry_form").serialize(),
		   function (data) {wall_post_saved(data);});
}

function delete_wall_post(id) {
	$.post('/wall_posts/delete',
	       { id:id },
		    function (data) {wall_post_deleted(data);});
}

function wall_post_deleted(request) {
	$("#wall_posts_content").html(request);
	// clear wall post message area, need to clear tinymce i think
	//$('wall_post_message').value == '';
}

function before_wall_post() {
	tinyMCE.triggerSave(true,true);
	$("#wall_post_entry").css('display', 'none');
}

// have to call this after the new tinymce editor is loaded upon a save
// tinyMCE.execCommand('mceAddControl', false, id); 

function wall_post_saved(request) {
	$("#wall_posts_content").html(request);
	// clear wall post message area
	//$("#wall_post_message").val('');
	tinyMCE.getInstanceById('wall_post_message').setContent('');
}

function show_wall_post_entry() {
	$("#wall_post_entry").slideDown();
}

function cancel_wall_post() {
	$("#wall_post_entry").slideUp();
	tinyMCE.getInstanceById('wall_post_message').setContent('');
}