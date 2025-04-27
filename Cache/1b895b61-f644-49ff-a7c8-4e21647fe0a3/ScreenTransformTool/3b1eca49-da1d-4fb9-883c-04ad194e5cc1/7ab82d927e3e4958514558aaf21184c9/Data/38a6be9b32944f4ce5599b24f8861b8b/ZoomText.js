"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.ZoomText = void 0;
var __selfType = requireType("./ZoomText");
function component(target) { target.getTypeName = function () { return __selfType; }; }
let ZoomText = class ZoomText extends BaseScriptComponent {
    updateZoomText() {
        this.zoomText.text = "Zoom: " + Math.floor(this.lensRegion.getPinchControl().getScale() * 100) + "%";
    }
    __initialize() {
        super.__initialize();
        this.onAwake = () => {
            this.lensRegion.getPinchControl().addOnUpdateCallback(() => {
                this.updateZoomText();
            });
        };
    }
};
exports.ZoomText = ZoomText;
exports.ZoomText = ZoomText = __decorate([
    component
], ZoomText);
//# sourceMappingURL=ZoomText.js.map