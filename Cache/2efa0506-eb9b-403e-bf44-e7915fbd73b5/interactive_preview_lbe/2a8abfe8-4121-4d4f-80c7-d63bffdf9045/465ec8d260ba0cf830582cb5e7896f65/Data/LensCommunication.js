// @input Component.ScriptComponent loader
// @input Component.ScriptComponent rotator
// @input Component.ScriptComponent orbitController

// @input SceneObject loadingSpinner

try {
    script.createEvent("MessageEvent").bind((event) => {
        if (event && event.data) {
            const type = event.data.event_type;
            
            if (type == "updateMesh") {
                const url = event.data.url;
                if (url) {
                    script.reset();
                    script.loader.downloadMesh(url);
                }
            } else if (type == "reset") {
                script.reset();
            }
        }
    });
} catch(error) {
    
}

script.init = function() {
    script.loadingSpinner.enabled = false;
    script.rotator.init();
    script.orbitController.init();
}

script.reset = function() {
    script.loadingSpinner.enabled = true;
    script.loader.clearMesh();
    script.rotator.reset();
    script.orbitController.reset();
}

let startDelayedEvent = script.createEvent("DelayedCallbackEvent");
startDelayedEvent.bind(() => {
   try {
    Editor.context.postMessage({
        "event_type": "start"
    });
   } catch (error) {
        startDelayedEvent.reset(0);
   } 
});

script.createEvent("OnStartEvent").bind(() => {
    startDelayedEvent.reset(0);
});