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
const FileLogger_1 = require("./Utils/FileLogger");
const log = new NativeLogger_1.default("MyNativeLogger");
const fileLogger = FileLogger_1.FileLogger.getInstance();
// Interaction System https://developers.snap.com/spectacles/spectacles-frameworks/spectacles-interaction-kit/features/interactionsystem
// Instantiate https://developers.snap.com/lens-studio/api/lens-scripting/classes/Built-In.ObjectPrefab.html#instantiateasync or https://developers.snap.com/lens-studio/lens-studio-workflow/prefabs
let ExampleLensManager = class ExampleLensManager extends BaseScriptComponent {
    onAwake() {
        fileLogger.log("LensManager.onAwake called", "LensManager");
        this.createEvent("OnStartEvent").bind(() => {
            fileLogger.log("OnStartEvent triggered", "LensManager");
            this.onStart();
            log.d("Onstart event triggered");
            print("Onstart event triggered");
        });
        this.createEvent("UpdateEvent").bind(() => {
            fileLogger.log("UpdateEvent triggered", "LensManager");
            this.updateSomething();
            log.d("Update event triggered");
            print("Update event triggered");
        });
    }
    onStart() {
        fileLogger.log("LensManager.onStart called", "LensManager");
        // Subscribe to the WebView initialized event
        if (this.webViewer) {
            this.webViewer.onWebViewInitialized((webView) => {
                const message = "WebView is now initialized and ready to use";
                fileLogger.log(message, "LensManager");
                print(message);
            });
            fileLogger.log("WebView initialized event handler registered", "LensManager");
        }
        else {
            fileLogger.log("WebView is not available", "LensManager");
        }
        // Create an event callback function for the create button
        let onTriggerStartCallback = async (event) => {
            const startMessage = "Button pressed. Attempting to process image and navigate.";
            fileLogger.log(startMessage, "LensManager");
            log.d(startMessage);
            print(startMessage);
            // First call the Vision Gemini handleTriggerEnd to get song recommendation
            if (this.visionGemini) {
                fileLogger.log("VisionGemini component is available, calling handleTriggerEnd", "LensManager");
                try {
                    // Call handleTriggerEnd and get the song name result
                    fileLogger.log("Calling visionGemini.handleTriggerEnd", "LensManager");
                    const songName = await this.visionGemini.handleTriggerEnd(event);
                    fileLogger.log(`handleTriggerEnd returned: ${songName ? songName : 'null'}`, "LensManager");
                    // Check if the WebView is ready before trying to navigate
                    if (this.webViewer && this.webViewer.isReady && songName) {
                        // Format the song name for the URL query parameter
                        const navigateMessage = `Navigating to search for song: ${songName}`;
                        fileLogger.log(navigateMessage, "LensManager");
                        print(navigateMessage);
                        const url = `https://music.youtube.com/search?q=${encodeURIComponent(songName)}`;
                        fileLogger.log(`Navigation URL: ${url}`, "LensManager");
                        this.webViewer.goToUrl(url);
                        const successMessage = "Successfully navigated to YouTube Music";
                        fileLogger.log(successMessage, "LensManager");
                        print(successMessage);
                    }
                    else if (!this.webViewer || !this.webViewer.isReady) {
                        const notReadyMessage = "WebView is not ready yet. Please try again in a moment.";
                        fileLogger.log(notReadyMessage, "LensManager");
                        print(notReadyMessage);
                    }
                    else {
                        const noSongMessage = "No song recommendation was generated. Try capturing a different scene.";
                        fileLogger.log(noSongMessage, "LensManager");
                        print(noSongMessage);
                    }
                }
                catch (error) {
                    const errorMessage = `Error processing image or getting song recommendation: ${error}`;
                    fileLogger.log(errorMessage, "LensManager");
                    print(errorMessage);
                }
            }
            else {
                const noVisionMessage = "Vision Gemini component is not available.";
                fileLogger.log(noVisionMessage, "LensManager");
                print(noVisionMessage);
                // Fallback if Vision Gemini is not available
                if (this.webViewer && this.webViewer.isReady) {
                    const fallbackUrl = "https://music.youtube.com";
                    fileLogger.log(`Navigating to fallback URL: ${fallbackUrl}`, "LensManager");
                    this.webViewer.goToUrl(fallbackUrl);
                    const fallbackMessage = "Navigated to YouTube Music homepage as fallback";
                    fileLogger.log(fallbackMessage, "LensManager");
                    print(fallbackMessage);
                }
            }
            // No need to explicitly flush logs as they're stored in memory
        };
        // Add the event listener to the create button onInteractorTriggerStart
        if (this.createButton) {
            fileLogger.log("Registering onInteractorTriggerStart handler for create button", "LensManager");
            this.createButton.onInteractorTriggerStart(onTriggerStartCallback);
        }
        else {
            fileLogger.log("Create button is not available", "LensManager");
        }
    }
    // Update the object movement to the destination
    updateSomething() {
        // DO SOMETHING IN UPDATE
        // Log update cycle if needed (uncomment for verbose logging)
        // fileLogger.log("LensManager.updateSomething called", "LensManager");
    }
    /**
     * Display all logs in the console
     * Call this method to view all logged information
     */
    showLogs() {
        fileLogger.dumpLogsToConsole();
    }
    /**
     * Get all logs as a formatted string
     * @returns All logs as a newline-separated string
     */
    getLogsAsText() {
        return fileLogger.getAllLogs();
    }
    /**
     * Get only the most recent logs
     * @param count Number of recent log entries to retrieve
     * @returns Array of recent log entries
     */
    getRecentLogs(count = 20) {
        return fileLogger.getRecentLogs(count);
    }
};
exports.ExampleLensManager = ExampleLensManager;
exports.ExampleLensManager = ExampleLensManager = __decorate([
    component
], ExampleLensManager);
//# sourceMappingURL=LensManager.js.map