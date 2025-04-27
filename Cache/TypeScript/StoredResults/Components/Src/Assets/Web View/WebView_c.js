if (script.onAwake) {
	script.onAwake();
	return;
};
function checkUndefined(property, showIfData){
   for (var i = 0; i < showIfData.length; i++){
       if (showIfData[i][0] && script[showIfData[i][0]] != showIfData[i][1]){
           return;
       }
   }
   if (script[property] == undefined){
      throw new Error('Input ' + property + ' was not provided for the object ' + script.getSceneObject().name);
   }
}
// @ui {"widget":"group_start", "label":"WebView"}
// @input string url = "https://snapchat.com"
checkUndefined("url", []);
// @input vec2 resolution = "{1280, 720}" {"label":"Resolution"}
checkUndefined("resolution", []);
// @input string userAgent
checkUndefined("userAgent", []);
// @input bool poke = true {"label":"Enable additional direct touch interactions on WebView (like a touchscreen)"}
checkUndefined("poke", []);
// @ui {"widget":"group_end"}
var scriptPrototype = Object.getPrototypeOf(script);
if (!global.BaseScriptComponent){
   function BaseScriptComponent(){}
   global.BaseScriptComponent = BaseScriptComponent;
   global.BaseScriptComponent.prototype = scriptPrototype;
   global.BaseScriptComponent.prototype.__initialize = function(){};
   global.BaseScriptComponent.getTypeName = function(){
       throw new Error("Cannot get type name from the class, not decorated with @component");
   }
}
var Module = require("../../../../Modules/Src/Assets/Web View/WebView");
Object.setPrototypeOf(script, Module.WebView.prototype);
script.__initialize();
if (script.onAwake) {
   script.onAwake();
}
