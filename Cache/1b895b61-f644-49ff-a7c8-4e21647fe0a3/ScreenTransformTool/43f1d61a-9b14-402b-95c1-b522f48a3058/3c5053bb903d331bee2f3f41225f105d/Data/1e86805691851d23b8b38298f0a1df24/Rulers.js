"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.Rulers = void 0;
var __selfType = requireType("./Rulers");
function component(target) { target.getTypeName = function () { return __selfType; }; }
const Config_1 = require("../Config");
let Rulers = class Rulers extends BaseScriptComponent {
    onAwake() {
        this.createEvent("OnStartEvent").bind(() => {
            this.onStart();
        });
    }
    onStart() {
        this.lensRegion.addOnLensRegionUpdate(() => {
            this.updateRulers();
        });
        Config_1.Config.isRulerEnabled.addCallback((value) => {
            if (value) {
                this.show();
            }
            else {
                this.hide();
            }
        });
    }
    show() {
        this.script.getSceneObject().enabled = true;
    }
    hide() {
        this.script.getSceneObject().enabled = false;
    }
    updateRulers() {
        const topRight = this.frame.localPointToScreenPoint(vec2.one());
        const bottomLeft = this.frame.localPointToScreenPoint(vec2.one().uniformScale(-1));
        this.fixDistortion(topRight, bottomLeft);
        this.updateRuler(this.horizontal, bottomLeft, topRight, true);
        this.updateRuler(this.vertical, bottomLeft, topRight, false);
    }
    updateRuler(screenTransform, bottomLeft, topRight, isHorizontal) {
        const bottomLeftParent = screenTransform.screenPointToParentPoint(bottomLeft);
        const topRightParent = screenTransform.screenPointToParentPoint(topRight);
        if (isHorizontal) {
            screenTransform.anchors.left = bottomLeftParent.x;
            screenTransform.anchors.right = topRightParent.x;
        }
        else {
            screenTransform.anchors.bottom = bottomLeftParent.y;
            screenTransform.anchors.top = topRightParent.y;
        }
    }
    fixDistortion(topRight, bottomLeft) {
        const height = this.lensRegion.getWindowTexture().getHeight() * (bottomLeft.y - topRight.y);
        const width = this.lensRegion.getWindowTexture().getWidth() * (topRight.x - bottomLeft.x);
        this.horizontalMaterial.mainPass.widthScale = 640 / width;
        this.verticalMaterial.mainPass.widthScale = 640 / height;
    }
};
exports.Rulers = Rulers;
exports.Rulers = Rulers = __decorate([
    component
], Rulers);
//# sourceMappingURL=Rulers.js.map