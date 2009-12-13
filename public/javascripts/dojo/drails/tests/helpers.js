dojo.provide("drails.tests.helpers");

dojo.global.isEmpty = function(str){
	return str != null && str.length > 0;
}

dojo.global.execOnElementEventConnect = function(ctor, element, evt, callback){
  var h = doh.onConnect(
    dojo.byId(element), evt,
    ctor, "onElementEvent",
    callback
  );
  
  var o = new ctor(element, function(element, value) { });
  return h;
}

dojo.global.assertElementEventConnection = function(t, element, evt){
  var success = false;
  var h = execOnElementEventConnect(drails.Form.Element.EventObserver, element, evt, function() { success = true; });
  dojo.disconnect(h);
  t.t(success);
}

dojo.declare("drails.test.Generator", null, {
  containerNode: null,
  generatorNode: null,
  generatorHTML: null,
  skip: false,
  
  constructor: function(containerNode, generatorNode){    
    this.containerNode = dojo.byId(containerNode);
    this.generatorNode = dojo.byId(generatorNode);
    this.generatorHTML = this.generatorNode.innerHTML;
    this.generatorNode.innerHTML = "";
  },
  
  generate: function(skip, callback){
    if (skip) return;
    this.containerNode.innerHTML = this.generatorHTML;
    if (callback) callback();
  },
  
  reset: function(skip, callback){
    if (skip) return;
    this.containerNode.innerHTML = "";
    if (callback) callback();
  }
  
});
