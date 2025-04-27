import { Interactable } from "./SpectaclesInteractionKit/Components/Interaction/Interactable/Interactable";
import { InteractorEvent } from "./SpectaclesInteractionKit/Core/Interactor/InteractorEvent";
import { SIK } from "./SpectaclesInteractionKit/SIK";
import { mix } from "./SpectaclesInteractionKit/Utils/animate";
import NativeLogger from "./SpectaclesInteractionKit/Utils/NativeLogger";
import { WebView } from "./Web View/WebView";
import { VisionGeminiFlash } from "./VisionGemini";
import { VisionGeminiFlash } from "./VisionGemini";

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
  
  @input
  @allowUndefined
  @hint("Vision Gemini component for image analysis")
  visionGemini: VisionGeminiFlash;

  private VisionGeminiFlash : VisionGeminiFlash;



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
    // Subscribe to the WebView initialized event
    if (this.webViewer) {
      this.webViewer.onWebViewInitialized((webView) => {
        print("WebView is now initialized and ready to use");
      });
    }
    
    // Create an event callback function for the create button
    let onTriggerStartCallback = async (event: InteractorEvent) => {
      log.d("Button pressed. Attempting to process image and navigate.");
      print("Button pressed. Attempting to process image and navigate.");
      
      // First call the Vision Gemini handleTriggerEnd to get song recommendation
      if (this.visionGemini) {
        try {
          // Call handleTriggerEnd and get the song name result
          const songName = await this.visionGemini.handleTriggerEnd(event);
          
          // Check if the WebView is ready before trying to navigate
          if (this.webViewer && this.webViewer.isReady && songName) {
            // Format the song name for the URL query parameter
            print(`Navigating to search for song: ${songName}`);
            this.webViewer.goToUrl(`https://music.youtube.com/search?q=${encodeURIComponent(songName)}`);
            print("Successfully navigated to YouTube Music");
          } else if (!this.webViewer || !this.webViewer.isReady) {
            print("WebView is not ready yet. Please try again in a moment.");
          } else {
            print("No song recommendation was generated. Try capturing a different scene.");
          }
        } catch (error) {
          print("Error processing image or getting song recommendation: " + error);
        }
      } else {
        print("Vision Gemini component is not available.");
        
        // Fallback if Vision Gemini is not available
        if (this.webViewer && this.webViewer.isReady) {
          this.webViewer.goToUrl("https://music.youtube.com");
          print("Navigated to YouTube Music homepage as fallback");
        }
      }
    };
    
    // Add the event listener to the create button onInteractorTriggerStart
    this.createButton.onInteractorTriggerStart(onTriggerStartCallback);

  }

  
  // Update the object movement to the destination
  updateSomething() {
    // DO SOMETHING IN UPDATE
    }
}