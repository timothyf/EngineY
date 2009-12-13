/*
	Copyright (c) 2004-2008, The Dojo Foundation All Rights Reserved.
	Available via Academic Free License >= 2.1 OR the modified BSD license.
	see: http://dojotoolkit.org/license for details
*/


if(!dojo._hasResource["dojox.layout.dnd.Avatar"]){ //_hasResource checks added by build. Do not use _hasResource directly in your code.
dojo._hasResource["dojox.layout.dnd.Avatar"] = true;
dojo.provide("dojox.layout.dnd.Avatar");
dojo.require("dojo.dnd.common");

dojox.layout.dnd.Avatar = function(manager,opacity){
	// summary: 
	// 		An Object, which represents the object being moved in a GridContainer
	this.manager = manager;
	this.construct(opacity);
};

dojo.extend(dojox.layout.dnd.Avatar, {
	construct: function(/*int*/ opacity){
		// summary:
		//		A constructor function. it is separate so it can be (dynamically) 
		//		overwritten in case of need.
		
		var source = this.manager.source;
		var node = (source.creator)?
		// create an avatar representation of the node
		source._normalizedCreator(source.getItem(this.manager.nodes[0].id).data, "avatar").node :
		// or just clone the node and hope it works
		this.manager.nodes[0].cloneNode(true); 
		node.id = dojo.dnd.getUniqueId();
		dojo.addClass(node, "dojoDndAvatar");
		node.style.position = "absolute";
		node.style.zIndex = 1999;
		node.style.margin = "0px";
		node.style.width = dojo.marginBox(source.node).w + "px";
		dojo.style(node,"opacity",opacity);
		this.node = node;
	},
	destroy: function(){
		// summary: Destroy this avatar instance
		dojo._destroyElement(this.node);
		this.node = false;
	},
	/*Function: update
		Updates the avatar to reflect the current DnD state.*/
	update: function(){
		
		dojo[(this.manager.canDropFlag ? "add" : "remove") + "Class"](this.node, "dojoDndAvatarCanDrop");
	},
	/*Function: _generateText*/
	_generateText: function(){
		//Nothing to do
	}
	
});

}
