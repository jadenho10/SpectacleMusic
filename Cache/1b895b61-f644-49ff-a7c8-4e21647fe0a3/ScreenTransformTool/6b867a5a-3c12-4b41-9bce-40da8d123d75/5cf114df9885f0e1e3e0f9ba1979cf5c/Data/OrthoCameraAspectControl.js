//@input Component.Camera camera
//@input Asset.Texture overlayTarget

script.createEvent("UpdateEvent").bind(function() {
    script.camera.aspect = script.overlayTarget.getWidth() / script.overlayTarget.getHeight();
})