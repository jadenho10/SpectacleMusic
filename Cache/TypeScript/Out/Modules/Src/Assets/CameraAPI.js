"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.ContinuousCameraFrameExample = void 0;
var __selfType = requireType("./CameraAPI");
function component(target) { target.getTypeName = function () { return __selfType; }; }
let ContinuousCameraFrameExample = class ContinuousCameraFrameExample extends BaseScriptComponent {
    onAwake() {
        this.createEvent("OnStartEvent").bind(() => {
            this.cameraRequest = CameraModule.createCameraRequest();
            this.cameraRequest.cameraId = CameraModule.CameraId.Default_Color;
            this.cameraTexture = this.cameraModule.requestCamera(this.cameraRequest);
            this.cameraTextureProvider = this.cameraTexture.control;
            this.cameraTextureProvider.onNewFrame.add((cameraFrame) => {
                if (this.uiImage) {
                    this.uiImage.mainPass.baseTex = this.cameraTexture;
                }
            });
        });
    }
    __initialize() {
        super.__initialize();
        this.cameraModule = require("LensStudio:CameraModule");
    }
};
exports.ContinuousCameraFrameExample = ContinuousCameraFrameExample;
exports.ContinuousCameraFrameExample = ContinuousCameraFrameExample = __decorate([
    component
], ContinuousCameraFrameExample);
//# sourceMappingURL=CameraAPI.js.map