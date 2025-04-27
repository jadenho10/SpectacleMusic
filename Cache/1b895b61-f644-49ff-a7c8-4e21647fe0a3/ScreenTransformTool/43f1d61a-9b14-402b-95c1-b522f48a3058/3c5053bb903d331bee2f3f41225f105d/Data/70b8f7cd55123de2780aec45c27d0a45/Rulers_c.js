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
// @input Component.ScriptComponent lensRegion
checkUndefined("lensRegion", []);
// @input Component.ScreenTransform frame
checkUndefined("frame", []);
// @input Component.ScreenTransform horizontal
checkUndefined("horizontal", []);
// @input Component.ScreenTransform vertical
checkUndefined("vertical", []);
// @input Asset.Material horizontalMaterial
checkUndefined("horizontalMaterial", []);
// @input Asset.Material verticalMaterial
checkUndefined("verticalMaterial", []);
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
var Module = require("../../../../../Modules/Src/Src/Scripts/Editor/RulersAndGuides/Rulers");
Object.setPrototypeOf(script, Module.Rulers.prototype);
script.__initialize();
if (script.onAwake) {
   script.onAwake();
}
