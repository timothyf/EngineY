dojo.provide("drails.tests.module");

try{
	doh.registerUrl("drails.tests.PeriodicalExecuter", dojo.moduleUrl("drails", "tests/PeriodicalExecuter.html"));
	doh.registerUrl("drails.tests.Updater", dojo.moduleUrl("drails", "tests/Updater.html"));
	doh.registerUrl("drails.tests.Request", dojo.moduleUrl("drails", "tests/Request.html"));
	doh.registerUrl("drails.tests.Effect", dojo.moduleUrl("drails", "tests/Effect.html"));
	doh.registerUrl("drails.tests.dnd.Source", dojo.moduleUrl("drails", "tests/dnd.Source.html"));
	doh.registerUrl("drails.tests.Draggable", dojo.moduleUrl("drails", "tests/Draggable.html"));
	doh.registerUrl("drails.tests.Droppable", dojo.moduleUrl("drails", "tests/Droppable.html"));
	doh.registerUrl("drails.tests.Sortable", dojo.moduleUrl("drails", "tests/Sortable.html"));
	doh.registerUrl("drails.tests.EventObserver", dojo.moduleUrl("drails", "tests/EventObserver.html"));
	doh.registerUrl("drails.tests.Form.Element.EventObserver", dojo.moduleUrl("drails", "tests/Form.Element.EventObserver.html"));
	doh.registerUrl("drails.tests.Form.EventObserver", dojo.moduleUrl("drails", "tests/Form.EventObserver.html"));
	doh.registerUrl("drails.tests.Form.Observer", dojo.moduleUrl("drails", "tests/Form.Observer.html"));
	doh.registerUrl("drails.tests.Form.Element.Observer", dojo.moduleUrl("drails", "tests/Form.Element.Observer.html"));
	doh.registerUrl("drails.tests.TimedObserver", dojo.moduleUrl("drails", "tests/TimedObserver.html"));
}catch(e){
	doh.debug(e);
}
