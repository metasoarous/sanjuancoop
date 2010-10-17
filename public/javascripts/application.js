//Aplication specific Javascript 

//This class takes care of ajaxifying tab functionality, but lets the 
//inks do their thing naturally when javascript is turned off.
//Mobbed this from somewhere online
var Tabs = Class.create({ 
	initialize: function() {
  	$$('ul#tabs').first().observe('click', (
    	function(event) { 
				if (event.element().tagName == 'A') {
					//stop the event from taking place naturally so that we 
					//can use ajax - then grab element
					event.stop(); 
					var element = event.element();
					//switch whcih tab has the active status
					this.makeLinkActive(element);
					//update the content div
					this.fetchContent(element.readAttribute('href'));
				}
			}).bind(this) );	
	},
	makeLinkActive: function(link) {
		$$('ul#tabs a.active').first().removeClassName('active');
		link.addClassName('active');
	},
	fetchContent: function(url) {
		new Ajax.Updater('content', url, {
			method: 'get',
			onLoading: function() {$('spinner').show();},
			onComplete: function() {$('spinner').hide();}
		});
	}
});

//Add some useful methods for find a form elements form
Element.form = function(element) {
	return element.ancestors().find( function(item) {
		return item.tagName == "FORM";
	});
}

//This class provides the base functionality for creating dynamic controls
var DynamicControl = Class.create({
	initialize: function(control) {
		this.control = control;
		if (this.control.tagName == "INPUT") {
			var event = "click"
		}
		else if (this.control.tagName == "SELECT") {
			var event = "change"
		}
		else {
			var event = ""
		}
		this.control.observe(event, this.itemSelected);
	},
	itemSelected: function() {
			Element.form(this).request({
			onSuccess: function() {
			},
			onFailure: function() {
				alert("That change didn't go through - try again or contact the website administrator.")
			}
		});
	}
});

//Get everything up and running once the dom is loaded
document.observe('dom:loaded', function () { 
	//tabs = new Tabs(); 
	dynamicControls = [];
	$$(".dynamic_control").each( function(control) {
		dynamicControls.push(new DynamicControl(control));
	});
});

