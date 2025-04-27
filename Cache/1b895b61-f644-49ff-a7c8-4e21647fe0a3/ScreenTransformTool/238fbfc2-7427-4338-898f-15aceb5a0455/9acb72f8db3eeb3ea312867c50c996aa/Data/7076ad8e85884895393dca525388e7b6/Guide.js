"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.Guide = exports.GuideType = void 0;
var __selfType = requireType("./Guide");
function component(target) { target.getTypeName = function () { return __selfType; }; }
var GuideType;
(function (GuideType) {
    GuideType[GuideType["Horizontal"] = 0] = "Horizontal";
    GuideType[GuideType["Vertical"] = 1] = "Vertical";
})(GuideType || (exports.GuideType = GuideType = {}));
let Guide = class Guide extends BaseScriptComponent {
    onAwake() {
        this.screenTransform = this.sceneObject.getComponent("ScreenTransform");
        this.position = this.screenTransform.anchors.getCenter();
        this.image = this.sceneObject.getComponent("Image");
        this.interaction = this.sceneObject.getComponent("InteractionComponent");
        const position = this.screenTransform.position;
        position.z = 15;
        this.screenTransform.position = position;
        this.setupInteractions();
    }
    addOnUpdate(cb) {
        this.callbacks.push(cb);
    }
    set visualEnabled(value) {
        this.image.enabled = value;
    }
    setType(type) {
        this.type = type;
    }
    getSingleAxisPosition() {
        if (this.getType() === GuideType.Vertical) {
            return this.position.x;
        }
        else {
            return this.position.y;
        }
    }
    getPosition() {
        return this.position;
    }
    getScreenPosition() {
        return this.screenTransform.localPointToScreenPoint(vec2.zero());
    }
    setScreenPosition(position) {
        this.setPosition(this.screenTransform.screenPointToParentPoint(position));
    }
    setPosition(position) {
        if (this.type === GuideType.Vertical) {
            this.position.x = position.x;
        }
        else {
            this.position.y = position.y;
        }
        this.screenTransform.anchors.setCenter(this.position);
        this.doCallbacks();
    }
    getWorldCenter() {
        return this.screenTransform.localPointToWorldPoint(vec2.zero());
    }
    getType() {
        return this.type;
    }
    getHint() {
        if (this.getType() === GuideType.Vertical) {
            return "X: " + this.getSingleAxisPosition().toFixed(4);
        }
        else {
            return "Y: " + this.getSingleAxisPosition().toFixed(4);
        }
    }
    doCallbacks() {
        this.callbacks.forEach((cb) => {
            cb && cb();
        });
    }
    setupInteractions() {
        this.interaction.onTouchStart.add((eventData) => {
            this.mouseHint.show();
            this.setScreenPosition(eventData.position);
            this.mouseHint.updateFromMousePosition(eventData.position);
            this.mouseHint.setText(this.getHint());
        });
        this.interaction.onTouchMove.add((eventData) => {
            this.setScreenPosition(eventData.position);
            this.mouseHint.updateFromMousePosition(eventData.position);
            this.mouseHint.setText(this.getHint());
        });
        this.interaction.onTouchEnd.add((eventData) => {
            this.setScreenPosition(eventData.position);
            this.mouseHint.updateFromMousePosition(eventData.position);
            this.mouseHint.setText(this.getHint());
            this.mouseHint.hide();
        });
    }
    __initialize() {
        super.__initialize();
        this.type = GuideType.Horizontal;
        this.position = vec2.zero();
        this.callbacks = [];
    }
};
exports.Guide = Guide;
exports.Guide = Guide = __decorate([
    component
], Guide);
//# sourceMappingURL=Guide.js.map