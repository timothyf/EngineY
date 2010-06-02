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



/*
 * Called from application.js on a page load
 */
function page_init() {
	alert('page init being called');	
}

/*
 * See http://blog.swivel.com/code/2008/08/scrollable-pagi.html
 * 
 * http://www.jroller.com/prpatel/entry/scaffolding_with_dojo_grid_and
 */


/*
 * Generate user data formatted for Dojo Grid
 */
function generate_user_store_data(item_list) {
	var data = {};
	var items = [];
	for (var i = 0; i < itemList.length; i++) {
		var item = {};
		item["id"]     = itemList[i].id;
		item["first_name"]   = itemList[i].first_name;
		item["last_name"]   = itemList[i].last_name;
		items.push(item);
	}
	data["identifier"] = "id";
	data["label"] = "name";
	data["items"] = items;
	return data;    
}  

function init_user_grid() {
	var layout = [{
	                name: 'ID',
	                field: 'id',
	                width: '10px'
	            }, {
	                name: 'First Name',
	                field: 'first_name',
	                width: '50px'
	            }, {
	                name: 'Last Name',
	                field: 'last_name',
	                width: '50px'
		}];
	
	var grid = new dojox.grid.DataGrid({
	            id: 'grid',
	            store: new dojo.data.ItemFileReadStore({data: generate_user_store_data(itemList)}),
	            structure: layout
	        }, dojo.byId('grid'));  	
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
	 
