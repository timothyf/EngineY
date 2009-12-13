/*
 * Implements a slideshow of rotating images
 */
function SlideShow( elem_id, hold_time ) {  
	this.elem = document.getElementById( elem_id );  
	this.slides = [];  
	this.num_slides = 0;  
	this.cur_slide = 1;  
	this.add_slide = function( image )  {  
		this.slides[ this.num_slides++ ] = image;}  
	var self = this;  
	this.next_slide = function()  {   
		if ( self.num_slides > 1 ) {   
			self.elem.src = self.slides[ self.cur_slide++ ].src; 
			 
			// also need to update the surrounding link
			// $('id of photo link').href="http://www.google.com";
			
			if ( self.cur_slide == self.num_slides )        
				self.cur_slide = 0;    
		}  
	}  
	setInterval(self.next_slide, hold_time)
}