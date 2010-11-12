
PageWidgets = function() {	
	this.widgets = [];
	
	// register a widget with the page
	this.register = function(widget) {
		this.widgets.push(widget);
	};
	
	// Registers all of the page's widgets given a JSON string containing the widget data
	// which has been set on the server side
	this.init_widgets = function(json) {
		var widgets_js = eval(json);
		for (i=0; i<widgets_js.length; i++) {
			var widget = widgets_js[i];
			this.register(new EyWidget(widget.id, widget.widget_name, widget.content_id, widget.col_num, null, true));
		}
	};
	
	/*
	 *  Load AJAX widgets from the server.  These widgets appear slightly after
	 *  the page has loaded.
	 */
	this.load = function() {
		for (i = 0; i < this.widgets.length; i++) {
			if (this.widgets[i].loadable) {
				this.widgets[i].create_widget_node();
				this.widgets[i].load();
			}
		}	
	};
	
	this.find_widget_by_id = function(id) {
		for (i = 0; i < this.widgets.length; i++) {
			if (this.widgets[i].id == id) {
				return this.widgets[i];
			}
		}	
		return null;
	};
};


function widget_change_display(widget_id) {
	page_data.widgets.find_widget_by_id(widget_id).change_display();
}

/*
 * EyWidget Class
 * This class represents the placement of a specific widget with a specific page location
 * 
 */
EyWidget = function(id, name, content_id, col_num, properties, loadable) {
	this.id = id;	
	this.widget_name = name;
	this.content_id = content_id;
	this.properties = properties;
	this.col_num = col_num;
	this.retry_count = 0;
	this.loadable = loadable;
	
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
		var content = {
			widget_id: this.id,
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
		newdiv.setAttribute('id', 'widget_' + this.id);
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
	function widget_loaded(widget_id, data) {
		$("#widget_" + widget_id).html(data);
	}
	
	// Called if an error occurs while loading a widget.  This includes timeouts.
	function widget_load_error(widget_id, data) {
		$("#widget_" + widget_id).innerHTML = '<div class="cant_load">Did not load widget:<br/><i>' + widget_name + '</i><br/>Try refreshing the page</div>';
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

