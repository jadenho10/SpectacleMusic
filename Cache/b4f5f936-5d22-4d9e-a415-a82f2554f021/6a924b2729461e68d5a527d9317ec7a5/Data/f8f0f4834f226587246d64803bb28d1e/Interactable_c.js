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
// @input float targetingMode = 3 {"widget":"combobox", "values":[{"label":"Direct", "value":1}, {"label":"Indirect", "value":2}, {"label":"Direct/Indirect", "value":3}, {"label":"Poke", "value":4}, {"label":"All", "value":7}]}
checkUndefined("targetingMode", []);
// @input bool enableInstantDrag {"hint":"Enable this to allow the Interactable to instantly be dragged on trigger rather than obeying the Interactor's drag threshold."}
checkUndefined("enableInstantDrag", []);
// @input bool isScrollable
checkUndefined("isScrollable", []);
// @input bool allowMultipleInteractors = true
checkUndefined("allowMultipleInteractors", []);
// @ui {"widget":"separator"}
// @input bool enablePokeDirectionality
checkUndefined("enablePokeDirectionality", []);
// @input float acceptableXDirections = 3 {"label":"X", "widget":"combobox", "values":[{"label":"None", "value":0}, {"label":"Right", "value":1}, {"label":"Left", "value":2}, {"label":"All", "value":3}], "showIf":"enablePokeDirectionality"}
checkUndefined("acceptableXDirections", [["enablePokeDirectionality",true]]);
// @input float acceptableYDirections = 3 {"label":"Y", "widget":"combobox", "values":[{"label":"None", "value":0}, {"label":"Up", "value":1}, {"label":"Down", "value":2}, {"label":"All", "value":3}], "showIf":"enablePokeDirectionality"}
checkUndefined("acceptableYDirections", [["enablePokeDirectionality",true]]);
// @input float acceptableZDirections = 3 {"label":"Z", "widget":"combobox", "values":[{"label":"None", "value":0}, {"label":"Forward", "value":1}, {"label":"Back", "value":2}, {"label":"All", "value":3}], "showIf":"enablePokeDirectionality"}
checkUndefined("acceptableZDirections", [["enablePokeDirectionality",true]]);
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
var Module = require("../../../../../../../Modules/Src/Assets/SpectaclesInteractionKit/Components/Interaction/Interactable/Interactable");
Object.setPrototypeOf(script, Module.Interactable.prototype);
script.__initialize();
if (script.onAwake) {
   script.onAwake();
}
