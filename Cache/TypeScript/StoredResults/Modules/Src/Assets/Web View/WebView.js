"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.WebView = void 0;
var __selfType = requireType("./WebView");
function component(target) { target.getTypeName = function () { return __selfType; }; }
require("LensStudio:TextInputModule");
const Event_1 = require("SpectaclesInteractionKit/Utils/Event");
const Interactable_1 = require("../SpectaclesInteractionKit/Components/Interaction/Interactable/Interactable");
const NativeLogger_1 = require("../SpectaclesInteractionKit/Utils/NativeLogger");
const TouchHandler_1 = require("./modules/behavior/TouchHandler");
const tag = "WebView";
const log = new NativeLogger_1.default(tag);
let WebView = class WebView extends BaseScriptComponent {
    get isReady() {
        return this._isReady;
    }
    onAwake() {
        // instantiate webplane prefab
        this.webViewPlaneObject = this.webViewPlanePrefab.instantiate(this.sceneObject);
        this.webViewPlaneTransform = this.webViewPlaneObject.getTransform();
        this.webviewImageComponent = this.webViewPlaneObject.getComponent("Image");
        this.setRenderOrder(0);
        const transformCache = this.transform.getLocalScale();
        this.transform.setLocalScale(vec3.one());
        this.webViewPlaneTransform.setLocalScale(transformCache);
        this.webViewPlaneCollider = this.webViewPlaneObject.getComponent("Physics.ColliderComponent");
        // Initialize WebView
        if (global.deviceInfoSystem.isSpectacles() &&
            !global.deviceInfoSystem.isEditor()) {
            const options = RemoteServiceModule.createWebViewOptions(this.resolution);
            try {
                this.remoteServiceModule.createWebView(options, this.onWebViewCreated.bind(this), this.onWebViewCreationError.bind(this));
            }
            catch (e) {
                print(`createWebView Exception: ${e.toString()}`);
            }
        }
        else {
            log.d(`WebView requires launching on Spectacles.`);
        }
    }
    onWebViewCreated(texture) {
        this.webviewControl = texture.control;
        this.webviewTexture = texture;
        // Clone material and set web page texture
        const imgComponent = this.webViewPlaneObject.getComponent("Component.Image");
        imgComponent.mainMaterial = imgComponent.mainMaterial.clone();
        imgComponent.mainPass.baseTex = texture;
        // The underlying component is not ready immediately. Wait for the onReady callback
        this.webviewControl.onReady.add(() => {
            this._isReady = true;
            print("WebView is ready");
            const interactable = this.webViewPlaneObject.createComponent(Interactable_1.Interactable.getTypeName());
            interactable.isScrollable = true;
            this.touchHandler = new TouchHandler_1.default({
                planeCollider: this.webViewPlaneCollider,
                screenSize: this.resolution,
                interactable: interactable,
                usePoke: this.poke,
                webView: this,
            });
            if (this.userAgent !== undefined) {
                this.setUserAgent(this.userAgent);
            }
            if (this.url !== undefined && this.url !== "") {
                this.loadURL(this.url);
            }
            this.webViewInitializedEvent.invoke(this);
        });
    }
    onWebViewCreationError(msg) {
        print(`Error creating webview: ${msg}`);
    }
    goToUrl(url) {
        this.url = url;
        this.loadURL(this.url);
    }
    isValidUrl(url) {
        return url !== null && url !== "" && url !== "about:blank";
    }
    checkWebViewReady() {
        if (!this.webviewControl || !this.isReady) {
            throw new Error("WebView is not ready");
        }
    }
    // load URL
    loadURL(url) {
        this.checkWebViewReady();
        if (this.isValidUrl(url)) {
            this.webviewControl.loadUrl(url);
        }
        else {
            throw new Error("Unsupported URL");
        }
    }
    // send touch interactions
    touch(x, y, state) {
        this.checkWebViewReady();
        this.webviewControl.touch(0, state, x, y);
    }
    // navigate forward in web history
    forward() {
        this.checkWebViewReady();
        this.webviewControl.goForward();
    }
    // navigate back in web history
    back() {
        this.checkWebViewReady();
        this.webviewControl.goBack();
    }
    // refresh current page
    reload() {
        this.checkWebViewReady();
        this.webviewControl.reload();
    }
    // stop all the downloading
    stop() {
        this.checkWebViewReady();
        this.webviewControl.stop();
    }
    // set a custom user agent
    // used to indicate current device to web server
    setUserAgent(userAgent) {
        this.checkWebViewReady();
        this.webviewControl.setUserAgent(userAgent);
    }
    getUserAgent() {
        this.checkWebViewReady();
        return this.webviewControl.getUserAgent();
    }
    setRenderOrder(newRenderOrder) {
        this.webviewImageComponent.setRenderOrder(newRenderOrder);
    }
    __initialize() {
        super.__initialize();
        this.remoteServiceModule = requireAsset("Web.remoteServiceModule");
        this.webViewPlanePrefab = requireAsset("./Prefabs/WebPlane.prefab");
        this.transform = this.sceneObject.getTransform();
        this.webViewInitializedEvent = new Event_1.default();
        this.onWebViewInitialized = this.webViewInitializedEvent.publicApi();
    }
};
exports.WebView = WebView;
exports.WebView = WebView = __decorate([
    component
], WebView);
//# sourceMappingURL=WebView.js.map