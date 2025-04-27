"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.ExampleLensManager = void 0;
var __selfType = requireType("./LensManager");
function component(target) { target.getTypeName = function () { return __selfType; }; }
const NativeLogger_1 = require("./SpectaclesInteractionKit/Utils/NativeLogger");
const log = new NativeLogger_1.default("MyNativeLogger");
// Interaction System https://developers.snap.com/spectacles/spectacles-frameworks/spectacles-interaction-kit/features/interactionsystem
// Instantiate https://developers.snap.com/lens-studio/api/lens-scripting/classes/Built-In.ObjectPrefab.html#instantiateasync or https://developers.snap.com/lens-studio/lens-studio-workflow/prefabs
let ExampleLensManager = class ExampleLensManager extends BaseScriptComponent {
    onAwake() {
        this.createEvent("OnStartEvent").bind(() => {
            this.onStart();
            log.d("Onstart event triggered");
            print("Onstart event triggered");
        });
        this.createEvent("UpdateEvent").bind(() => {
            this.updateSomething();
            log.d("Update event triggered");
            print("Update event triggered");
        });
    }
    onStart() {
        // Create an event callback function for the create button
        let onTriggerStartCallback = (event) => {
            // NOW CHANGE THE LINK HERE <-----
            this.webViewer.goToUrl("your URL");
            log.d("Button pressed. Instantiating the prefab object.");
            print("Button pressed. Instantiating the prefab object.");
        };
        // Add the event listener to the create button onInteractorTriggerStart
        this.createButton.onInteractorTriggerStart(onTriggerStartCallback);
    }
    // Update the object movement to the destination
    updateSomething() {
        // DO SOMETHING IN UPDATE
    }
};
exports.ExampleLensManager = ExampleLensManager;
exports.ExampleLensManager = ExampleLensManager = __decorate([
    component
], ExampleLensManager);
//# sourceMappingURL=LensManager.js.map