/*
	Simple jQuery Theme Script
 */

function init_widgets(json) {
	var layouts_js = eval(json);
	var widgets = [];
	for (i=0; i<layouts_js.length; i++) {
		var layout = layouts_js[i];
		widgets.push(new Layout(layout.id, layout.widget_name, layout.content_id, layout.col_num, null));
	}
	return widgets;
}

/*
 *  Load AJAX widgets from the server.  These widgets appear slightly after
 *  the page has loaded.
 */
function load_widgets() {
	for (i = 0; i < widgets.length; i++) {
		widgets[i].create_widget_node();
		widgets[i].load();
	}
}

function find_layout_by_id(id) {
	for (i = 0; i < widgets.length; i++) {
		if (widgets[i].id == id) {
			return widgets[i];
		}
	}	
	return null;
}

function widget_change_display(layout_id) {
	var layout = find_layout_by_id(layout_id);
	layout.change_display();
}

/*
 * Layout Class
 * This class represents the placement of a specific widget with a specific page location
 * 
 */
Layout = function(id, name, content_id, col_num, properties) {
	this.id = id;	
	this.widget_name = name;
	this.content_id = content_id;
	this.properties = properties;
	this.col_num = col_num;
	this.retry_count = 0;
	
	this.change_display = function() {
		if ($("#" + this.widget_name + '_body').css('display') == 'none') {
			this.expand_widget();
		}
		else {
			this.collapse_widget();
		}
	};
	
	this.collapse_widget = function() {
		$("#" + this.widget_name + '_body').slideUp();
		$("#" + this.widget_name + '_collapse_img').attr({src : "/images/expand.png"});
	}
	
	this.expand_widget = function() {
		$("#" + this.widget_name + '_body').slideDown();
		$("#" + this.widget_name + '_collapse_img').attr({src : "/images/collapse.png"});
	}
	
	this.load = function() {
		/*if (this.retry_count == 0) {
			// create a DOM node to hold the returned content before requesting it
			// this will help hold its place on the page
			this.create_widget_node();
		}*/
		var content = {
			layout_id: this.id,
			name: this.widget_name,
			user_id: user_id,
			authenticity_token: authenticity_token
		};
		for (attr in this.properties) { content[attr] = this.properties[attr]; }
		send_ajax_get('/widget_layouts/load', content, this);
	};
	
	// Create a DOM node to hold a widget that is being loaded
	this.create_widget_node = function() {
		var newdiv = document.createElement('div');
		newdiv.setAttribute('id', 'layout_' + this.id);
		newdiv.className = 'widget_content';
		loadingSpan = document.createElement('span');
		loadingSpan.className = 'loading_span';
		loadingSpan.appendChild(document.createTextNode('Loading...'));
		newdiv.appendChild(loadingSpan);
		if (this.col_num == '1') {
			$("#col_1_widgets").append(newdiv);
		}
		else if (this.col_num == '2') {
			$("#col_2_widgets").append(newdiv);
		}
		else if (this.col_num == '3') {
			$("#col_3_widgets").append(newdiv);
		}
	}
	
	// A widget has been loaded, place its content into the DOM tree
	function widget_loaded(layout_id, data) {
		$("#layout_" + layout_id).html(data);
	}
	
	// Called if an error occurs while loading a widget.  This includes timeouts.
	function widget_load_error(layout_id, data) {
		$("#layout_" + layout_id).innerHTML = '<div class="cant_load">Did not load widget:<br/><i>' + widget_name + '</i><br/>Try refreshing the page</div>';
	}
	
	function send_ajax_get(url, content, obj) {
		$.ajax({
			url: url,
			timeout: 14000, // give up after 14 seconds
			data: content,
			error: (function(widget_obj){
				return function(data){
					widget_obj.retry_count += 1;
					if (widget_obj.retry_count > 2 ) {
						widget_load_error(widget_obj.id, data);
					}
					else {
						// try reloading
						widget_obj.load();
					}
				}
			})(obj),
			success: (function(widget_obj){
				return function(data){
					widget_loaded(widget_obj.id, data);
				}
			})(obj)
		});
	}
	
};

