// This file contains monkey patches to the dojo source code
// Everything in this file has been submitted to the Dojo trac project
// and is pending approval by the Dojo Foundation for incoporation into
// the Dojo source.  All monkey patches have been tested in the Dojo
// tests and their tests are included in the patch.

dojo.provide("drails.monkey");

(function(){
  var _d = dojo;
  
  if (!_d.fieldToObject){
    // http://bugs.dojotoolkit.org/ticket/8649
    _d.fieldToObject = function(/*DOMNode||String*/ inputNode){
      // summary:
      //    dojo.fieldToObject returns the value encoded in an HTML form as
      //    as a string or an array of strings. Disabled form elements
      //    and unchecked radio and checkboxes are skipped. Multi-select
      //    elements are returned as an array of string values.
      var ret = null;
      var item = _d.byId(inputNode);
      if (item) {
        var type = (item.type||"").toLowerCase();
        var _in = item.value;
        if (_in && type && !item.disabled){
          if(type == "radio" || type == "checkbox"){
            if(item.checked){ ret = item.value }
          }else if(item.multiple){
            ret = [];
            _d.query("option", item).forEach(function(opt){
              if(opt.selected){
                ret.push(opt.value);
              }
            });
          }else{ 
            ret = item.value;
          }
        }
      }
      return ret; // Object
    }
  }
})();