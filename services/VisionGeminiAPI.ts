import { InteractorEvent } from "./SpectaclesInteractionKit/Core/Interactor/InteractorEvent";
import { Interactable } from "./SpectaclesInteractionKit/Components/Interaction/Interactable/Interactable";
import { SIK } from "./SpectaclesInteractionKit/SIK";

@component
export class GeminiPro15Text extends BaseScriptComponent {
  @input promptText: string = "Ask me something insightful!";
  @input interactable: Interactable;

  apiKey: string = "AIzaSyDwczme1kr3zDwJ7NLyyfLPY4ZdiVgRWmY";

  // Remote service module for fetching data
  private remoteServiceModule: RemoteServiceModule = require("LensStudio:RemoteServiceModule");
  private isProcessing: boolean = false;

  onAwake() {
    this.createEvent("OnStartEvent").bind(() => {
      this.onStart();
    });
  }

  onStart() {
    let interactionManager = SIK.InteractionManager;

    // Define the desired callback logic for the relevant Interactable event.
    let onTriggerEndCallback = (event: InteractorEvent) => {
      this.handleTriggerEnd(event);
    };

    this.interactable.onInteractorTriggerEnd(onTriggerEndCallback);
  }

  async handleTriggerEnd(eventData: any) {
    if (this.isProcessing) {
      print("A request is already in progress. Please wait.");
      return;
    }

    if (!this.promptText || !this.apiKey) {
      print("Prompt text or API key is missing");
      return;
    }
    
    // First let's try to get the list of available models
    print("Checking available models...");
    await this.listAvailableModels();

    try {
      this.isProcessing = true;

      const requestPayload = {
        model: "models/gemini-pro",
        contents: [
          {
            role: "user",
            parts: [
              {
                text:
                  "You are a helpful AI assistant that works for Snapchat. Please respond to the following prompt from the user in under 30 words. Be a little funny and keep it positive.\n\n" +
                  this.promptText,
              },
            ],
          },
        ],
      };

      const request = new Request(
        `https://generativelanguage.googleapis.com/v1/models/gemini-pro:generateContent?key=${this.apiKey}`,
        {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
          },
          body: JSON.stringify(requestPayload),
        }
      );
      // More about the fetch API: https://developers.snap.com/spectacles/about-spectacles-features/apis/fetch
      let response = await this.remoteServiceModule.fetch(request);
      if (response.status === 200) {
        let responseData = await response.json();
        if (
          responseData.candidates &&
          responseData.candidates.length > 0 &&
          responseData.candidates[0].content &&
          responseData.candidates[0].content.parts &&
          responseData.candidates[0].content.parts.length > 0 &&
          responseData.candidates[0].content.parts[0].text
        ) {
          print(responseData.candidates[0].content.parts[0].text);
        } else {
          print("Failure: No text response from Gemini Pro.");
        }
      } else {
        print(`Failure: response not successful. Status code: ${response.status}`);
        let errorBody = await response.text();
        print(`Error body: ${errorBody}`);
      }
    } catch (error) {
      print("Error: " + error);
    } finally {
      this.isProcessing = false;
    }
  }

  async listAvailableModels() {
    try {
      const listModelsRequest = new Request(
        `https://generativelanguage.googleapis.com/v1/models?key=${this.apiKey}`,
        {
          method: "GET",
          headers: {
            "Content-Type": "application/json",
          },
        }
      );
      
      print("Fetching available Gemini models...");
      
      let response = await this.remoteServiceModule.fetch(listModelsRequest);
      if (response.status === 200) {
        let modelsData = await response.json();
        print("Available models: Found " + (modelsData.models ? modelsData.models.length : 0) + " models");
        
        // Print models that support generateContent
        if (modelsData.models && Array.isArray(modelsData.models)) {
          print("Models that support generateContent:");
          
          // We'll keep track of supported models in a string
          let modelsOutput = "";
          
          for (let i = 0; i < modelsData.models.length; i++) {
            const model = modelsData.models[i];
            const name = model.name || "";
            const displayName = model.displayName || "";
            
            if (model.supportedGenerationMethods && 
                Array.isArray(model.supportedGenerationMethods) &&
                model.supportedGenerationMethods.includes("generateContent")) {
              modelsOutput += "- " + name + " (" + displayName + ")\n";
            }
          }
          
          print(modelsOutput);
        }
      } else {
        print("ListModels failed with status code: " + response.status);
        let errorBody = await response.text();
        print("ListModels error: " + errorBody);
      }
    } catch (error) {
      print("Error listing models: " + error);
    }
  }
}
