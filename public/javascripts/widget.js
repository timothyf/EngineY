
function init_widgets(json, type) {
	var widgets_js = eval(json);
	var widgets = [];
	for (i=0; i<widgets_js.length; i++) {
		var widg = widgets_js[i];
		widgets.push(new Widget(widg.name, widg.content_id, widg.col_num, type));
	}
	return widgets;
}

/*
 *  Load AJAX widgets from the server.  These widgets appear slightly after
 *  the page has loaded.
 */
function load_widgets() {
	for (i = 0; i < widgets.length; i++) {
		widgets[i].load();
	}
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

// A widget has been loaded, place its content into the DOM tree
function widget_loaded(widget_name, data) {
	var newdiv = document.createElement('div');
	newdiv.innerHTML = data;
	dojo.byId(widget_name).innerHTML = '';
	dojo.byId(widget_name).appendChild(newdiv);
}

// Called if an error occurs while loading a widget.  This includes timeouts.
function widget_load_error(widget_name, data) {
	dojo.byId(widget_name).innerHTML = '<div class="cant_load">Did not load widget:<br/><i>' + widget_name + '</i><br/>Try refreshing the page</div>';
	// add code to retry widget load
}


/*
 * Widget Class
 * This class represents a widget that is displayed on a page.
 * 
 */
Widget = function(name, content_id, col_num, type) {	
	this.name = name;
	this.content_id = content_id;
	this.type = type;
	this.col_num = col_num;
	this.retry_count = 0;
	
	this.load = function() {
		if (this.retry_count == 0) {
			if (this.content_id) {
				this.name = this.name + this.content_id;
			}

			// create a DOM node to hold the returned content before requesting it
			// this will help hold its place on the page
			this.create_widget_node();
		}
		var url;
		var content;
		if (this.type == 'home') {
			url = '/widgets/load';
			content = {
				name: this.name,
				content_id: this.content_id,
				authenticity_token: authenticity_token
			};
		}
		else if (this.type == 'profile') {
			url = '/widgets/load_profile_widget';
			content = {
						name: this.name,
						user_id: user_id,
						authenticity_token: authenticity_token
					};
		}
		dojo.xhrGet({
			url: url,
			timeout: 14000, // give up after 14 seconds
			content: content,
			error: (function(widget_obj){
				return function(data){
					widget_obj.retry_count += 1;
					if (widget_obj.retry_count > 1 ) {
						widget_load_error(widget_obj.name, data);
					}
					else {
						// try reloading
						widget_obj.load();
					}
				}
			})(this),
			load: (function(widget_obj){
				return function(data){
					widget_loaded(widget_obj.name, data);
				}
			})(this)
		});
	};
	
	// Create a DOM node to hold a widget that is being loaded
	this.create_widget_node = function() {
		var newdiv = document.createElement('div');
		newdiv.setAttribute('id', this.name);
		newdiv.className = 'widget_content';
		newdiv.appendChild(document.createTextNode('Loading...'));
		if (this.col_num == '1') {
			dojo.byId('left_side_widgets').appendChild(newdiv);
		}
		else if (this.col_num == '2') {
			dojo.byId('widgets').appendChild(newdiv);
		}
		else if (this.col_num == '3') {
			dojo.byId('right_side_widgets').appendChild(newdiv);
		}
	}
	
	// A widget has been loaded, place its content into the DOM tree
	function widget_loaded(widget_name, data) {
		var newdiv = document.createElement('div');
		newdiv.innerHTML = data;
		dojo.byId(widget_name).innerHTML = '';
		dojo.byId(widget_name).appendChild(newdiv);
	}
	
	// Called if an error occurs while loading a widget.  This includes timeouts.
	function widget_load_error(widget_name, data) {
		dojo.byId(widget_name).innerHTML = '<div class="cant_load">Did not load widget:<br/><i>' + widget_name + '</i><br/>Try refreshing the page</div>';
		// add code to retry widget load
	}
	
};

