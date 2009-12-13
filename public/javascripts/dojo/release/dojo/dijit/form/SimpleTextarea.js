/*
	Copyright (c) 2004-2008, The Dojo Foundation All Rights Reserved.
	Available via Academic Free License >= 2.1 OR the modified BSD license.
	see: http://dojotoolkit.org/license for details
*/


if(!dojo._hasResource["dijit.form.SimpleTextarea"]){ //_hasResource checks added by build. Do not use _hasResource directly in your code.
dojo._hasResource["dijit.form.SimpleTextarea"] = true;
dojo.provide("dijit.form.SimpleTextarea");

dojo.require("dijit.form.TextBox");

dojo.declare("dijit.form.SimpleTextarea",
	dijit.form.TextBox,
{
	// summary:
	//		A simple textarea that degrades, and responds to
	// 		minimal LayoutContainer usage, and works with dijit.form.Form.
	//		Doesn't automatically size according to input, like Textarea.
	//
	// example:
	//	|	<textarea dojoType="dijit.form.SimpleTextarea" name="foo" value="bar" rows=30 cols=40/>
	//

	baseClass: "dijitTextArea",

	attributeMap: dojo.mixin(dojo.clone(dijit.form._FormValueWidget.prototype.attributeMap),
		{rows:"textbox", cols: "textbox"}),

	// rows: Number
	//		The number of rows of text.
	rows: "",

	// rows: Number
	//		The number of characters per line.
	cols: "",

	templatePath: null,
	templateString: "<textarea name='${name}' dojoAttachPoint='focusNode,containerNode,textbox' autocomplete='off'></textarea>",

	postMixInProperties: function(){
		if(this.srcNodeRef){
			this.value = this.srcNodeRef.value;
		}
	},

	filter: function(/*String*/ value){
		if(value){
			value = value.replace(/\r/g,"");
		}
		return this.inherited(arguments);
	}
});

}
