"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.VisionGeminiFlash = void 0;
var __selfType = requireType("./VisionGemini");
function component(target) { target.getTypeName = function () { return __selfType; }; }
const SIK_1 = require("./SpectaclesInteractionKit/SIK");
require('LensStudio:RawLocationModule');
let VisionGeminiFlash = class VisionGeminiFlash extends BaseScriptComponent {
    onAwake() {
        this.createEvent("OnStartEvent").bind(() => {
            this.onStart();
        });
    }
    onStart() {
        let interactionManager = SIK_1.SIK.InteractionManager;
        // Define the desired callback logic for the relevant Interactable event.
        let onTriggerEndCallback = (event) => {
            this.handleTriggerEnd(event);
        };
        this.interactable.onInteractorTriggerEnd(onTriggerEndCallback);
    }
    //   async getLocation() {
    //     this.locationService.getCurrentPosition(
    //         function (geoPosition) {
    //           //Check if location coordinates have been updated based on timestamp
    //           if (
    //             this.timestamp === undefined ||
    //             this.timestamp.getTime() != geoPosition.timestamp.getTime()
    //           ) {
    //             this.latitude = geoPosition.latitude;
    //             this.longitude = geoPosition.longitude;
    //             this.horizontalAccuracy = geoPosition.horizontalAccuracy;
    //             this.verticalAccuracy = geoPosition.verticalAccuracy;
    //             print('long: ' + this.longitude);
    //             print('lat: ' + this.latitude);
    //             if (geoPosition.altitude != 0) {
    //               this.altitude = geoPosition.altitude;
    //               print('altitude: ' + this.altitude);
    //             }
    //             this.timestamp = geoPosition.timestamp;
    //           }
    //         },
    //         function (error) {
    //           print(error);
    //         }
    //       );
    //   }
    async handleTriggerEnd(eventData) {
        if (this.isProcessing) {
            print("A request is already in progress. Please wait.");
            return;
        }
        if (!this.image || !this.apiKey) {
            print("Image or API key input is missing");
            return;
        }
        //this.getLocation(); 
        try {
            this.isProcessing = true;
            // Access the texture from the image component
            const texture = this.image.mainPass.baseTex;
            if (!texture) {
                print("Texture not found in the image component.");
                return;
            }
            const base64Image = await this.encodeTextureToBase64(texture);
            const requestPayload = {
                model: "models/gemini-2.0-flash-lite",
                contents: [
                    {
                        role: "user",
                        parts: [
                            {
                                text: "You are a helpful AI assistant that works for Snapchat that has access to the view that the user is looking at using Augmented Reality Glasses." +
                                    "Give me 3 most relevant songs that describe the environment as a JSON object. In the list containing the songs, add '-' between each word.",
                            },
                            {
                                inline_data: {
                                    mime_type: "image/jpeg",
                                    data: base64Image,
                                },
                            },
                        ],
                    },
                ],
            };
            const request = new Request(`https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash-lite:generateContent?key=${this.apiKey}`, {
                method: "POST",
                headers: {
                    "Content-Type": "application/json",
                },
                body: JSON.stringify(requestPayload),
            });
            // More about the fetch API: https://developers.snap.com/spectacles/about-spectacles-features/apis/fetch
            let response = await this.remoteServiceModule.fetch(request);
            if (response.status === 200) {
                let responseData = await response.json();
                if (responseData.candidates &&
                    responseData.candidates.length > 0 &&
                    responseData.candidates[0].content &&
                    responseData.candidates[0].content.parts &&
                    responseData.candidates[0].content.parts.length > 0 &&
                    responseData.candidates[0].content.parts[0].text) {
                    print(responseData.candidates[0].content.parts[0].text);
                }
                else {
                    print("Failure: No text response from Gemini Flash.");
                }
            }
            else {
                print(`Failure: response not successful. Status code: ${response.status}`);
                let errorBody = await response.text();
                print(`Error body: ${errorBody}`);
            }
        }
        catch (error) {
            print("Error: " + error);
        }
        finally {
            this.isProcessing = false;
        }
    }
    // More about encodeTextureToBase64: https://platform.openai.com/docs/guides/vision or https://developers.snap.com/api/lens-studio/Classes/OtherClasses#Base64
    encodeTextureToBase64(texture) {
        return new Promise((resolve, reject) => {
            Base64.encodeTextureAsync(texture, resolve, reject, CompressionQuality.LowQuality, EncodingType.Jpg);
        });
    }
    __initialize() {
        super.__initialize();
        this.apiKey = "AIzaSyDwczme1kr3zDwJ7NLyyfLPY4ZdiVgRWmY";
        this.remoteServiceModule = require("LensStudio:RemoteServiceModule");
        this.isProcessing = false;
    }
};
exports.VisionGeminiFlash = VisionGeminiFlash;
exports.VisionGeminiFlash = VisionGeminiFlash = __decorate([
    component
], VisionGeminiFlash);
//# sourceMappingURL=VisionGemini.js.map