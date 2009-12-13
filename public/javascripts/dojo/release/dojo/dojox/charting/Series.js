/*
	Copyright (c) 2004-2008, The Dojo Foundation All Rights Reserved.
	Available via Academic Free License >= 2.1 OR the modified BSD license.
	see: http://dojotoolkit.org/license for details
*/


if(!dojo._hasResource["dojox.charting.Series"]){ //_hasResource checks added by build. Do not use _hasResource directly in your code.
dojo._hasResource["dojox.charting.Series"] = true;
dojo.provide("dojox.charting.Series");

dojo.require("dojox.charting.Element");

dojo.declare("dojox.charting.Series", dojox.charting.Element, {
	constructor: function(chart, data, kwArgs){
		dojo.mixin(this, kwArgs);
		if(typeof this.plot != "string"){ this.plot = "default"; }
		this.data = data;
		this.dirty = true;
		this.clear();
	},
	clear: function(){
		this.dyn = {};
	}
});

}
