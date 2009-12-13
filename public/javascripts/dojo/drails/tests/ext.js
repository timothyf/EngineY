dojo.provide("drails.tests.ext");
dojo.require("doh.runner");

doh.specArray = [];
doh.specArray.last = function() {
  return doh.specArray[doh.specArray.length-1];
}

dojo.declare("doh.Spec", null, {
  after: null,
  before: null,
  _specDesc: null,
  _specFunc: null,
  _tests: null,
  
  constructor: function(specDesc, specFunc) {
    this._tests = new Array();
    this._specDesc = specDesc;
    this._specFunc = specFunc;
  },
  
  addTest: function(test) {
    this._tests.push(test);
  },
  
  register: function() {
    var tests = dojo.map(this._tests, function(test, index, array) {
      return test.build(this.before, this.after);
    }, this);
    doh.register(this._specDesc, tests);
  }
});

dojo.declare("doh.SpecTest", null, {
  _testDesc: null,
  _testFunc: null,
  
  constructor: function(testDesc, testFunc){
    this._testDesc = testDesc;
    this._testFunc = testFunc;
  },
  
  build: function(before, after){
    return {
      name: this._testDesc,
      setUp: before,
      tearDown: after,
      runTest: this._testFunc
    };
  }
})

doh.spec = function(description, func){
  doh.specArray.push(new doh.Spec(description, func));
  func();
}

doh.it = function(description, func) {
  var s = doh.specArray.last();
  s.addTest(new doh.SpecTest(description, func));
}

doh.before = function(func) {
  var s = doh.specArray.last();
  s.before = func;
}

doh.after = function(func) {
  var s = doh.specArray.last();
  s.after = func;
}

doh.spec.register = function() {
  dojo.forEach(doh.specArray, function(spec, index, array) {
    spec.register();
  });
}

doh.pollute = function(){
  var makeGlobal = ['spec', 'it', 'before', 'after'];
  dojo.forEach(makeGlobal, function(func, i, array) {
    dojo.global[func] = doh[func];
  });
}

/**********************************************************************
 *                           doh Helpers                              *
 **********************************************************************/

doh.onConnect = function(/*Object*/ source, /*String|Function*/ sourceEvt, /*Function*/ destCtor, /*String|Function*/ destEvt, /*Function*/ cb) {
  // summary
  //    Can be used to test that a particular connection has been made.
  //    Use the callback to set a success variable for an assertion in your test code.
  
  // TODO: Make this work with the same variable arities that dojo.connect uses
  // TODO: Can we do better than just assert on a destination constructor
  // TODO: Should we pass more arguments to the callback
  // TODO: Make this better: instance.constructor == destCtor
  var h = dojo.connect(dojo, "connect", function(element, evt, instance, handler) {
    if (element && evt && instance && handler){
      if (element === source &&
        evt == sourceEvt &&
        instance.constructor == destCtor  &&
        handler == destEvt
      ) {
        cb();
      }
    }
  });
  return h; // Handle
}