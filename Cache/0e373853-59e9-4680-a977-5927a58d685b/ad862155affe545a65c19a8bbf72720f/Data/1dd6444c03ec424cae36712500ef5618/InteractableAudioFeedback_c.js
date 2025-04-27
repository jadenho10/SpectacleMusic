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
// @input bool _playAudioOnHover = true
checkUndefined("_playAudioOnHover", []);
// @input Asset.AudioTrackAsset _hoverAudioTrack {"hint":"This sound will play when the Interactable is hovered", "showIf":"_playAudioOnHover", "showIfValue":true}
// @input bool _playAudioOnTriggerStart = true
checkUndefined("_playAudioOnTriggerStart", []);
// @input Asset.AudioTrackAsset _triggerStartAudioTrack {"hint":"This sound will play when starting the trigger the Interactable", "showIf":"_playAudioOnTriggerStart", "showIfValue":true}
// @input bool _playAudioOnTriggerEnd = true
checkUndefined("_playAudioOnTriggerEnd", []);
// @input Asset.AudioTrackAsset _triggerEndAudioTrack {"hint":"This sound will play when ending the trigger of the Interactable", "showIf":"_playAudioOnTriggerEnd", "showIfValue":true}
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
var Module = require("../../../../../../Modules/Src/Assets/SpectaclesInteractionKit/Components/Helpers/InteractableAudioFeedback");
Object.setPrototypeOf(script, Module.InteractableAudioFeedback.prototype);
script.__initialize();
if (script.onAwake) {
   script.onAwake();
}
