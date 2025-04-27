//@input Asset.Texture deviceCameraTexture
//@input Component.ScreenTransform toolbarScreenT
//@input Component.ScreenTransform toolarLeftSection
//@input Component.ScreenTransform toolarRightSection
//@input Component.ScreenTransform toolarTopSection
//@input Component.ScreenTransform bottomMidSection

var provider = script.deviceCameraTexture.control;
var toolbarAnchors = script.toolbarScreenT.anchors;
var pixelSize = 45;
var screenWidth = 800;

var toolbarLeftSectionRight;
var toolbarRightSectionLeft;
var toolbarTopSectionRight;
var bottomMidSectionRight;


var updateEvent = script.createEvent("UpdateEvent");
updateEvent.bind(update);

init();

function init(){
    if (script.toolarLeftSection){
        toolbarLeftSectionRight = script.toolarLeftSection.anchors.right + 1;
    }
    
    if (script.toolarRightSection){
        toolbarRightSectionLeft = 1 - script.toolarRightSection.anchors.left;
    }
    
    if (script.toolarTopSection){
        toolbarTopSectionRight = script.toolarTopSection.anchors.right;
    }
    
    if (script.bottomMidSection){
        bottomMidSectionRight = script.bottomMidSection.anchors.right;
    }
}

function update() {

    toolbarAnchors.bottom = 1 - pixelSize * 2 / provider.getHeight();

    if (script.toolarLeftSection){
        script.toolarLeftSection.anchors.left = -1;
        script.toolarLeftSection.anchors.right = -1 + toolbarLeftSectionRight * screenWidth / provider.getWidth();   
    }
        
    if (script.toolarRightSection){
        script.toolarRightSection.anchors.right = 1;
        script.toolarRightSection.anchors.left = 1 - toolbarRightSectionLeft * screenWidth / provider.getWidth();
    }
    
    if (script.toolarTopSection){
        script.toolarTopSection.anchors.left = 0 - toolbarTopSectionRight * screenWidth / provider.getWidth();
        script.toolarTopSection.anchors.right = 0 + toolbarTopSectionRight * screenWidth / provider.getWidth();
    }
    
    if (script.bottomMidSection){
        script.bottomMidSection.anchors.bottom = -1;
        script.bottomMidSection.anchors.top = -1 + pixelSize * 2 / provider.getHeight();
        script.bottomMidSection.anchors.left = 0 - bottomMidSectionRight * screenWidth / provider.getWidth();
        script.bottomMidSection.anchors.right = 0 + bottomMidSectionRight * screenWidth / provider.getWidth();
    }
}