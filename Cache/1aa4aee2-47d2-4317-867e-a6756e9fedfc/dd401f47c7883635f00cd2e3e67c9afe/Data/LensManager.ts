import { Interactable } from "./SpectaclesInteractionKit/Components/Interaction/Interactable/Interactable";
import { InteractorEvent } from "./SpectaclesInteractionKit/Core/Interactor/InteractorEvent";
import { SIK } from "./SpectaclesInteractionKit/SIK";
import { mix } from "./SpectaclesInteractionKit/Utils/animate";
import NativeLogger from "./SpectaclesInteractionKit/Utils/NativeLogger";
import { WebView } from "./Web View/WebView";

const log = new NativeLogger("MyNativeLogger");
// Interaction System https://developers.snap.com/spectacles/spectacles-frameworks/spectacles-interaction-kit/features/interactionsystem
// Instantiate https://developers.snap.com/lens-studio/api/lens-scripting/classes/Built-In.ObjectPrefab.html#instantiateasync or https://developers.snap.com/lens-studio/lens-studio-workflow/prefabs

@component
export class ExampleLensManager extends BaseScriptComponent {




  @input
  @allowUndefined
  @hint("The button that will create the prefab object")
  createButton: Interactable;

  @input
  @allowUndefined
  @hint("The web viewer")
  webViewer: WebView;



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
    let onTriggerStartCallback = (event: InteractorEvent) => {
      // NOW CHANGE THE LINK HERE <-----
      this.webViewer.goToUrl("");
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
}