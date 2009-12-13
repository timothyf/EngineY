dojo.provide("drails.common");
dojo.require("drails.monkey");
dojo.require("dojo.fx");

drails._insertionMap = {
	"top":		 "first",
	"bottom":	 "last",
	"before":	 "before",
	"after":	 "after"
};

drails._xhrMap = {
	"asynchronous": [ "sync", function(v) { return !v; } ],
	"method":				[ "method", function(v) { return v.toLowerCase(); } ],
	"insertion":		[ "place", function(v) { return drails._insertionMap[v] }],
	"parameters":		[ "content", function(v) { return dojo.isObject(v) ? v : dojo.queryToObject(v); } ],
	//"evalScripts":	[ "handleAs", function(v) { return v == true ? "javascript" : "text"; } ]
	"evalScripts":	"evalScripts"
};

drails._xhrCallbackMap = {
	"onUninitialized":	null,
	"onLoading":				null,
	"onLoaded":					null,
	"onInteractive":		null,
	"onComplete":				null,		// handle ?
	"onFailure":				"error",
	"onSuccess":				"load"
	// TODO 100..599
};

dojo.declare("drails._base", null, {
	transformCallbacks: function(url, xhrArgs) {
		var dojoXhrArgs = { url: url };
		for (var protoCallback in xhrArgs) {
			var dojoCallback = drails._xhrCallbackMap[protoCallback];
			if (dojoCallback) {		// Found callback mapping
				// If a prototype callback handler exists on this object
				if (this[protoCallback]) {
					dojo.connect(dojoXhrArgs, dojoCallback, this, protoCallback);
					if (xhrArgs[protoCallback]){
						dojo.connect(this, protoCallback, xhrArgs[protoCallback]);	// Connect the callback to the currently existing callback
					}
				} else if (xhrArgs[protoCallback]) {
					dojoXhrArgs[dojoCallback] = xhrArgs[protoCallback];
				}
			} else {							// Did not find a callback mapping
				this.unsupportedOperation(protoCallback);
			}
		}
		return dojoXhrArgs;
	},
	
	transformSettings: function(xhrArgs){
		var dojoXhrArgs = {};
		for (var setting in xhrArgs){
			var dojoSetting = drails._xhrMap[setting];
			if (dojoSetting){
				var value = dojoSetting;
				if (dojo.isArray(value)) {
					dojoSetting = value[0];
					value = value[1](xhrArgs[setting]);
				}
				else {
					value = xhrArgs[setting];
				}
				dojoXhrArgs[dojoSetting] = value;
				delete xhrArgs[setting];
			}
		}
		return dojoXhrArgs;
	},
	
	unsupportedOperation: function(callbackName){
		throw(callbackName + " is not a supported drails operation");
	}
});

dojo.declare("drails.Request", [drails._base], {
	_requestOnConstruction: true,
	_transformedArgs: null,
	_transformedMethod: null,
	
	constructor: function(url, xhrArgs){
		if (this._requestOnConstruction){
			this.xhr(url, xhrArgs);
		}
	},
	
	xhr: function(url, xhrArgs) {
		var dojoXhrArgs = {};
		
		if (xhrArgs) {
			dojo.mixin(dojoXhrArgs, this.transformSettings(xhrArgs));
			dojo.mixin(dojoXhrArgs, this.transformCallbacks(url, xhrArgs));
		}
		dojo.mixin(dojoXhrArgs, this._initHandlerAndHeaders());
		this._transformedMethod = dojoXhrArgs['method'] || 'post';
		this._transformedArgs = dojoXhrArgs;
		switch(this._transformedMethod){
			case 'post':
				dojo.xhrPost(this._transformedArgs);
				break;
			case 'get':
				dojo.xhrGet(this._transformedArgs);
				break;
			case 'delete':
				dojo.xhrDelete(this._transformedArgs);
				break;
			case 'put':
				dojo.xhrPut(this._transformedArgs);
				break;
			default:
				dojo.xhr(this._transformedMethod, this._transformedArgs);
		}
	},
	
	_initHandlerAndHeaders: function(){
		var o = {
			'headers': {
				'Accept': 'text/javascript, text/html, application/xml, text/xml, */*'
			}
		};
		return o;
	}
});


dojo.declare("drails.Updater", [drails.Request], {
	
	stripRegExp: new RegExp('<script[^>]*>([\\S\\s]*?)<\/script>', "img"),
	_requestOnConstruction: false,
	_successNode: null,
	_failureNode: null,
	_strippedContent: null,
	
	constructor: function(target, url, xhrArgs) {
		xhrArgs = xhrArgs || {};
		xhrArgs['onSuccess'] = xhrArgs['onSuccess'] || function() {};
		xhrArgs['onFailure'] = xhrArgs['onFailure'] || function() {};

		if (target) this.interpolateTargets(target);
		this.xhr(url, xhrArgs);
	},
	
	onSuccess: function(response, ioArgs) {
		this._handle(response.toString(), ioArgs, this._successNode);
	},
	
	onFailure: function(response, ioArgs) {
		this._handle(response.responseText, ioArgs, this._failureNode);
	},
	
	interpolateTargets: function(target){
		if (typeof target == "string") {
			this._successNode = this._failureNode = target;
		} else if (typeof target == "object") {
			this._successNode = target["success"];
			this._failureNode = target["failure"];
		}
		else {
			throw new Error("Invalid target type");
		}
	},
	
	strippedContent: function(responseText){
		return responseText.replace(this.stripRegExp, "");
	},
	
	_evalScripts: function(scripts){
		if (!scripts) return;
		
		dojo.forEach(scripts, function(script){
			if (script) eval(script);
		});
	},
	
	_handle: function(responseText, ioArgs, node){
		var scripts = null;
		var doEval = ioArgs.args['evalScripts'];
		
		if (doEval) scripts = this._grepScripts(responseText);
		responseText = this.strippedContent(responseText);
		this._placeHTML(responseText, ioArgs, node);
		if (doEval) this._evalScripts(scripts);
	},
	
	_grepScripts: function(responseText){
		var regexp = this.scriptRegExp;
		var scripts = [];
		dojo.forEach(this.stripRegExp.exec(responseText), function(script, i){
			if (i > 0) scripts.push(script);
		});
		return scripts;
	},
	
	_placeHTML: function(response, ioArgs, target) {
		if (target){
			var node = dojo.byId(target);
			if (ioArgs.args['place']) {
				var nodeHTML = dojo.doc.createElement("span");
				nodeHTML.innerHTML = response.toString();
				dojo.place(dojo.clone(nodeHTML.firstChild), node, ioArgs.args['place']);
			} else {
				node.innerHTML = response.toString();
			}
		}
	}
	
});


dojo.declare("drails.PeriodicalExecuter", null, {
	constructor: function(callback, frequency) {
		this.callback = callback;
		this.frequency = frequency;
		this.currentlyExecuting = false;

		this.registerCallback();
	},

	registerCallback: function() {
		var self = this;
		dojo.connect(self, "onTimerEvent", function() {
				if (!self.currentlyExecuting) {
					try {
						self.currentlyExecuting = true;
						self.execute();
					} finally {
						self.currentlyExecuting = false;
					}
				}
			});
		self.timer = setInterval(self.onTimerEvent, self.frequency * 1000);
	},
	
	execute: function() {
		// Weird, why pass "self" as an argument if callback is called in "self"'s context?
		// (Prototype apparently does this).	Am I missing something?
		this.callback(this);
	},

	stop: function() {
		if (!this.timer) return;
		clearInterval(this.timer);
		this.timer = null;
	},
	
	// Event hook... connect away :)
	onTimerEvent: function() {
	}
});

// Due to API inconsistency in the constructor, we can't subclass PeriodicalExecuter like Prototype does
// TODO: Reimplement as a mixin
dojo.declare("drails.TimedObserver", null, {
	element: null,
	executer: null,
	callback: null,
	lastValue: null,
	
	constructor: function(element, frequency, callback) {
		this.callback = callback;
		this.element = dojo.byId(element);
		this.executer = new drails.PeriodicalExecuter(dojo.hitch(this, "execute"), frequency);
		dojo.connect(this, "stop", this.executer, "stop");
		dojo.connect(this.executer, "onTimerEvent", this, "onTimerEvent");
	},
	
	execute: function(executer) {
		var value = this.getValue();
		if (dojo.isString(this.lastValue) && dojo.isString(value) ?
				this.lastValue != value : String(this.lastValue) != String(value)) {
			this.callback(this.element, value);
			this.lastValue = value;
		}
	},
	
	stop: function(){
	},
	
	onTimerEvent: function(){
	},
	
	getValue: function() {
		throw new Error("[" + this.declaredClass + "] getValue is an abstract method");
	}
});

dojo.declare("drails.Form.Element.Observer", [drails.TimedObserver], {
	getValue: function(){
		return this.element.name + "=" + (dojo.fieldToObject(this.element) || "");
	}
});

dojo.declare("drails.Form.Observer", [drails.TimedObserver], {
	getValue: function(){
		// TODO: does this returns a query string in prototype?		 
		return dojo.objectToQuery(dojo.formToObject(this.element));
	}
});


dojo.declare("drails.EventObserver", null, {
	
	element: null,
	lastValue: null,
	
	constructor: function(element, callback){
		this.element = dojo.byId(element);
		this.callback = callback;
		this.lastValue = this.getValue();
		this.registerCallbacks(this.element);
	},
	
	onElementEvent: function(){
		var value = this.getValue();
		// FIXME: In the prototype impl, this does not appear to work for radio and checkboxes since
		// their values rarely change.	We should consider checking on the element type and firing
		// the event even if the lastValue hasn't changed for the radio button or checkbox.
		// TODO: Verify that declaring an EventObserver on a radio button does not work.	Also,
		// we should check to see if Rails does some munging to when rendering radio button so that
		// the EventObserver is checking the value based on a radio button name vs. and ID.	 If this
		// munging does occur, then this functionality appears to work as advertised.
		
		// Until we have done out TODO task, we will keep this check in to stay consistent with
		// the client-side APIs.
		if (this.lastValue != value) {
			this.callback(this.element, value);
			this.lastValue = value;
		}
	},
	
	registerListenerForField: function(element){
		var type = (element.type||"").toLowerCase();
		if (type == "") throw new Error("Invalid type for element: " + element.constructor.toString() + ".	Did you forget to specify an input type in your markup?");
	 
		var evtType;
		switch(element.type){
			case 'checkbox': // fall through
			case 'radio':
				evtType = 'onclick';
				break;
			default:
				evtType = 'onchange';
		}
		dojo.connect(element, evtType, this, "onElementEvent");
	},
	
	registerCallbacks: function(element) {
		throw new Error("[" + this.declaredClass + "] getValue is an abstract method");
	},
	
	getValue: function() {
		throw new Error("[" + this.declaredClass + "] getValue is an abstract method");
	}
});


dojo.declare("drails.Form.Element.EventObserver", [drails.EventObserver], {
	registerCallbacks: function(element){
		this.registerListenerForField(element);
	},
	
	getValue: function() {
		return this.element.name + "=" + (dojo.fieldToObject(this.element) || "");
	}
});


dojo.declare("drails.Form.EventObserver", [drails.EventObserver], {
	registerCallbacks: function(element){
		dojo.forEach(element.elements, function(node){
			this.registerListenerForField(node);
		}, this);
	},
	
	getValue: function() {
		return dojo.formToObject(this.element);
	}
});


dojo.declare("drails.Sortable", null, {
	options: null,
	source: null,
	sourceNode: null,
	connects: null,
	
	constructor: function(element, options){
		this.connects = [];
		this.options = options || {};
		this.sourceNode = dojo.byId(element);
		this._applyAttributes();
		this._initDnd();
	},
	
	destroy: function(){
		if (this.source){
			this.source.destroy();
			this.source = null;
		}
		if (this.connects){
			dojo.forEach(this.connects, function(connection){
				dojo.disconnect(connection);
			});
			this.connects = null;
		}
		this.options = null;
		this.sourceNode = null;
	},
	
	onUpdate: function(source, nodes, copy, target){
	},
	
	_applyAttributes: function(){
		dojo.attr(this.sourceNode, "dojoType", "dojo.dnd.Source");
		dojo.query("> *", this.sourceNode).forEach(function(node){
			dojo.addClass(node, "dojoDndItem");
		});
	},
	
	_initDnd: function(){
		this.source = new dojo.dnd.Source(this.sourceNode);
		this.connects.push(dojo.connect(this.source, "onDndDrop", this, "onUpdate"));
		if (dojo.isFunction(this.options.onUpdate)){
			this.connects.push(dojo.connect(this, "onUpdate", this.options.onUpdate));
		}
	}
});

drails.Sortable.create = function(element, options){
	dojo.require("dojo.dnd.Source");
	return new drails.Sortable(element, options);
}

//TODO: Test with date fields
drails.Sortable.serialize = function(element){
	var ret = [];
	var node = dojo.byId(element);
	dojo.query("> *", node).forEach(function(child){
		ret.push(node.id + "[]=" + child.id.split("_")[1]);
	});
	return ret.join("&");
}

dojo.declare("drails.dnd.Source", null, {	
	connects: null,
	source: null,
	options: null,
	
	initSource: function(node){
		dojo.require("dojo.dnd.Source");
		this.source = new dojo.dnd.Source(node);
	},
	
	destroy: function(){
		dojo.forEach(this.connects, function(c){
			dojo.disconnect(c);
		});
		this.connects = null;
		this.source.destroy();
		this.source = null;
		this.options = null;
	},
	
	applyOptions: function(options){
		this.options = options || {};
		this.applyCallbacks();
	},
	
	applyCallbacks: function(){
		this.connects = [];
		dojo.forEach(drails.dnd.Source._supportedCallbacks, function(cb){
			this.connects.push(dojo.connect(this.source, drails.dnd.Source._supportedCallbackMap[cb], this, cb));
			if (dojo.isFunction(this.options[cb])) {
				this.connects.push(dojo.connect(this, cb, this.options[cb]));
			}
		}, this);
	},
	
	// Callback hooks
	onSourceOver: function(){},
	onStart: function(){},
	onDrop: function(){},
	onCancel: function(){}
});

(function(){
	var m = {
		'onSourceOver': 'onDndSourceOver',
		'onStart': 'onDndStart',
		'onDrop': 'onDndDrop',
		'onCancel': 'onDndCancel'
	};
	var a = [];
	for (var p in m){
		a.push(p);
	}
	drails.dnd.Source._supportedCallbackMap = m;
	drails.dnd.Source._supportedCallbacks = a;
})();


dojo.declare("drails.Draggable", [drails.dnd.Source], {	 
	element: null,
	sourceNode: null,
	
	constructor: function(element, options){
		this.element = dojo.byId(element);
		this.connects = [];

		this.sourceNode = dojo.doc.createElement("div");
		dojo.place(this.sourceNode, this.element, "before");
		this.sourceNode.appendChild(this.element);
		dojo.addClass(this.element, "dojoDndItem");

		this.initSource(this.sourceNode);
		this.applyOptions(options);
	}
});


dojo.declare("drails.Droppable", [drails.dnd.Source], {
	constructor: function(element, options){
		this.initSource(dojo.byId(element));
		this.applyOptions(options);
	}
});

dojo.declare("drails.Toggler", [dojo.fx.Toggler], {
	_lastState: null,
	
	getNextState: function(){
		return (!this._lastState || this._lastState == "hide") ? "show" : "hide";
	},
	
	show: function(delay){
		this._lastState = "show";
		this.inherited(arguments);
	},
	
	hide: function(delay){
		this._lastState = "hide";
		this.inherited(arguments);
	},
	
	toggle: function(delay){
		this[this.getNextState()](delay);
	}
});

(function(){
	var _f;
	
	dojo.declare("drails.Effect", null, {
		fx: null,
		fxOptions: null,
		
		constructor: function(element, effect, options){
			var ctor = _f._fxCtorMap[effect];
			if (!ctor) throw new Error("'" + effect + "' is not a valid drails effect");
			var o = { node: element, duration: 200 };
			this.fxOptions = dojo.mixin(o, options || {});
			this.fx = ctor(this.fxOptions)
			this.fx.play();
		}
	});
	_f = drails.Effect;
	
	dojo.mixin(_f, {
		togglers: {},
		_lastTogglerId: 1,
		
		_fxCtorMap: {
			'fade_in':  dojo.fadeIn,
			'fade_out': dojo.fadeOut,
			'wipe_in':  dojo.fx.wipeIn,
			'wipe_out': dojo.fx.wipeOut,
			'slide_to': dojo.fx.slideTo
		},
	
		_toggleFxOptionMap: {
			'appear': 'fade_in',
			'slide':  'slide_to',
			'blind':  'wipe_in'
		},
		
		findToggleFxCtor: function(effect){
			var ctor = _f._fxCtorMap[_f._toggleFxOptionMap[effect]];
			if (!ctor) throw new Error("'" + effect + "' is not a valid drails toggle effect");
			return ctor;
		},
		
		toggle: function(element, effect, options){
			var ctor = _f.findToggleFxCtor(effect);
			var node = dojo.byId(element);
			var id = dojo.attr(node, "drailsTogglerId");
			var t = null;
			
			if (!id){
				id = _f.getUniqueTogglerId();
				dojo.attr(node, "drailsTogglerId", id);
				var o = { node: element, showFunc: ctor };
				t = new drails.Toggler(dojo.mixin(o, options));
				_f.togglers[id] = t;
			}else{
				t = _f.togglers[id];
			}
			t.toggle(options ? options.delay : null);
			
			return t;
		},
		
		getUniqueTogglerId: function(){
			return _f._lastTogglerId++;
		}
	});
})();














