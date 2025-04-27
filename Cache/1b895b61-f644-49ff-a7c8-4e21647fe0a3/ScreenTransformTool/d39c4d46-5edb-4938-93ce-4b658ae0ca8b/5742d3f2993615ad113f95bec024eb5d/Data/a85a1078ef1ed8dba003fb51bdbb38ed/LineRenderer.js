"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.LineRenderer = void 0;
var __selfType = requireType("./LineRenderer");
function component(target) { target.getTypeName = function () { return __selfType; }; }
let LineRenderer = class LineRenderer extends BaseScriptComponent {
    addLine(from, to) {
        this.lines.push([from, to]);
        this.skipReset = false;
    }
    reset() {
        if (this.skipReset) {
            return;
        }
        this.skipReset = true;
        for (let i = 0; i < this.lines.length; i++) {
            this.addVectorAt(this.startPointTexData, i, this.zero);
            this.addVectorAt(this.endPointTexData, i, this.zero);
        }
        this.lines = [];
        this.update();
    }
    update() {
        if (this.updateWithCameraSize) {
            this.linesMat.mainPass.cameraSize = this.camera.size;
        }
        this.lines.forEach((line, idx) => {
            this.addVectorAt(this.startPointTexData, idx, line[0]);
            this.addVectorAt(this.endPointTexData, idx, line[1]);
        });
        this.startPointTexProvider.setPixelsFloat32(0, 0, this.DIMENTION, this.DIMENTION, this.startPointTexData);
        this.endPointTexProvider.setPixelsFloat32(0, 0, this.DIMENTION, this.DIMENTION, this.endPointTexData);
    }
    addVectorAt(data, index, position) {
        data[4 * index] = position.x;
        data[4 * index + 1] = position.y;
        data[4 * index + 2] = position.z;
        data[4 * index + 3] = 0;
    }
    __initialize() {
        super.__initialize();
        this.zero = vec3.zero();
        this.skipReset = false;
        this.DIMENTION = 100;
        this.CHANNELS = 4;
        this.lines = [];
        this.onAwake = () => {
            const startTexture = ProceduralTextureProvider.create(this.DIMENTION, this.DIMENTION, Colorspace.RGBAFloat);
            this.startPointTexProvider = startTexture.control;
            this.startPointTexData = new Float32Array(this.DIMENTION * this.DIMENTION * this.CHANNELS);
            this.startPoint.control = this.startPointTexProvider;
            const endTexture = ProceduralTextureProvider.create(this.DIMENTION, this.DIMENTION, Colorspace.RGBAFloat);
            this.endPointTexProvider = endTexture.control;
            this.endPointTexData = new Float32Array(this.DIMENTION * this.DIMENTION * this.CHANNELS);
            this.endPoint.control = this.endPointTexProvider;
            this.linesMat.mainPass.instanceCount = this.DIMENTION * this.DIMENTION;
        };
    }
};
exports.LineRenderer = LineRenderer;
exports.LineRenderer = LineRenderer = __decorate([
    component
], LineRenderer);
//# sourceMappingURL=LineRenderer.js.map