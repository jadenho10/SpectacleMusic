"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.Main = void 0;
var __selfType = requireType("./Main");
function component(target) { target.getTypeName = function () { return __selfType; }; }
const RenderLayerUtils_1 = require("./Common/Utilities/RenderLayerUtils");
const GizmoUtils_1 = require("./Editor/Gizmo/GizmoUtils");
let Main = class Main extends BaseScriptComponent {
    onAwake() {
        RenderLayerUtils_1.RenderLayerUtils.setUniqueLayersForHierarchy(this.getSceneObject().getParent());
        this.panControl = this.lensRegion.getPanControl();
        GizmoUtils_1.GizmoUtils.aspectSource = this.lensRegion.getWindowTexture();
    }
    getLensRegion() {
        return this.lensRegion;
    }
};
exports.Main = Main;
exports.Main = Main = __decorate([
    component
], Main);
//# sourceMappingURL=Main.js.map