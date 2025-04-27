// @input Component.Camera camera
// @input Asset.Texture texture
//@input Component.Text textComponent
// @input Asset.Texture toolbarTarget

var camera = script.camera;
var skip = 2;
var lastSize = camera.size;
var screenScale = 2;
if (typeof Editor !== 'undefined') {
    var viewportUpdateEvent = script.createEvent("ViewportUpdateEvent");
    viewportUpdateEvent.bind(function(eventData){
        screenScale = eventData.viewportData.screenScale;
    })
}

script.createEvent("UpdateEvent").bind(function() {
    if (skip <= 0 && script.texture.getHeight() > 0) {
        // It's 2 / screenScale because initially everything was set up for mac and on mac screenScale = 2
        camera.size = script.texture.getHeight() * (2 / screenScale);   
        camera.aspect = script.texture.getWidth() / script.texture.getHeight();
        lastSize = camera.size;
        script.textComponent.enabled = true;
        skip = 0; 
    }
    skip -=1;
})