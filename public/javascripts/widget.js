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

/*
 *  Load AJAX widgets from the server.  These widgets appear slightly after
 *  the page has loaded.
 */
function load_widgets() {
	for (i = 0; i < home_widgets.length; i++) {
		load_widget(home_widgets[i]);
	}
	for (i = 0; i < profile_widgets.length; i++) {
		load_profile_widget(profile_widgets[i]);
	}
}

// Request a home page widget with the given name from the server via an AJAX call.
function load_widget(widget) {
	if (widget.content_id) {
		widget.name = widget.name + widget.content_id;
	}
	// create a DOM node to hold the returned content before requesting it
	// this will help hold its place on the page
	create_widget_node(widget.name, widget.col_num);
	dojo.xhrGet({
		url: '/widgets/load',
	    timeout: 14000, // give up after 3 seconds
	    content: { name:widget.name, content_id:widget.content_id, authenticity_token:authenticity_token },
		error: function (data) {widget_load_error(widget.name, data);},
		load: function (data) {widget_loaded(widget.name, data);}
	});	
}

// Request a profile page widget with the given name from the server via an AJAX call.
function load_profile_widget(widget) {
	// create a DOM node to hold the returned content before requesting it
	// this will help hold its place on the page
	create_widget_node(widget.name, widget.col_num);
	dojo.xhrGet({
		url: '/widgets/load_profile_widget',
	    timeout: 10000, // give up after 3 seconds
	    content: { name:widget.name, user_id:user_id, authenticity_token:authenticity_token },
		error: function (data) {widget_load_error(widget.name, data);},
		load: function (data) {widget_loaded(widget.name, data);}
	});		
}

// Called if an error occurs while loading a widget.  This includes timeouts.
function widget_load_error(widget_name, data) {
	dojo.byId(widget_name).innerHTML = '<div class="cant_load">Did not load widget:<br/><i>' + widget_name + '</i><br/>Try refreshing the page</div>';
	// add code to retry widget load
}

// A widget has been loaded, place its content into the DOM tree
function widget_loaded(widget_name, data) {
	var newdiv = document.createElement('div');
	newdiv.innerHTML = data;
	dojo.byId(widget_name).innerHTML = '';
	dojo.byId(widget_name).appendChild(newdiv);
}

// Create a DOM node to hold a widget that is being loaded
function create_widget_node(widget_name, col_num) {
	var newdiv = document.createElement('div');
	newdiv.setAttribute('id', widget_name);
	newdiv.appendChild(document.createTextNode('Loading...'));
	if (col_num == '1') {
		dojo.byId('left_side_widgets').appendChild(newdiv);
	}
	else if (col_num == '2') {
		dojo.byId('widgets').appendChild(newdiv);
	}
	else if (col_num == '3') {
		dojo.byId('right_side_widgets').appendChild(newdiv);
	}
}

function widget_change_display(widget_name) {
	if ($(widget_name + '_body').style.display == 'none') {
		expand_widget(widget_name);
	}
	else {
		collapse_widget(widget_name);
	}
}

/*
 * This function collapses the view of a widget
 */
function collapse_widget(widget_name) {
	var wipeOut = dojo.fx.wipeOut({node: widget_name + '_body',duration: 500});
	wipeOut.play();
	var img = dojo.byId(widget_name + '_collapse_img');
	img.src = "/images/expand.png";
}

function expand_widget(widget_name) {
	var wipeIn = dojo.fx.wipeIn({node: widget_name + '_body',duration: 500});
	wipeIn.play();
	var img = dojo.byId(widget_name + '_collapse_img');
	img.src = "/images/collapse.png";
}


/*
 * Widget Class
 * 
 * This class represents a widget that is displayed on a page.
 * 
 */
/*
Widget = function() {
	
	/*
	 * Attributes to hold
	 * 
	 * position (column number, row order)
	 * 
	 * width/height
	 * 
	 * name
	 * 
	 * url
	 * 
	 * container id (dom node id)
	 */
	
/*}*/
