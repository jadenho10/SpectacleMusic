"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.PokeVisualHandler = void 0;
var __selfType = requireType("./PokeVisualHandler");
function component(target) { target.getTypeName = function () { return __selfType; }; }
const Interactor_1 = require("../../../SpectaclesInteractionKit/Core/Interactor/Interactor");
const SIK_1 = require("../../../SpectaclesInteractionKit/SIK");
const animate_1 = require("../../../SpectaclesInteractionKit/Utils/animate");
const NativeLogger_1 = require("../../../SpectaclesInteractionKit/Utils/NativeLogger");
const log = new NativeLogger_1.default("PokeVisualHandler");
/**
 * number of seconds for finger fade
 */
const FINGER_FADE_DURATION = 0.2;
const MAX_ALPHA = 0.8;
/**
 * A component for handling poke visuals for webviews
 * Handles a total count for request to show visuals
 * So if multiple webviews are in the scene they can vote for whether or not the webview poke visual should be shown
 * if 0 votes: hide
 * if more than 0: show
 */
let PokeVisualHandler = class PokeVisualHandler extends BaseScriptComponent {
    onAwake() {
        this.rmv = this.sceneObject.getChild(0).getComponent("RenderMeshVisual");
        this.material = this.rmv.mainMaterial.clone();
        this.rmv.mainMaterial = this.material;
        this.transform = this.getTransform();
        this.initialize();
    }
    set handName(hand) {
        this._handName = hand;
    }
    get handName() {
        return this._handName;
    }
    __initialize() {
        super.__initialize();
        this._handName = "right";
        this.requests = 0;
        this.visible = false;
        this.cancelSet = new animate_1.CancelSet();
        this.animationManager = animate_1.AnimationManager.getInstance();
        this.initialize = () => {
            this.hand = SIK_1.SIK.HandInputData.getHand(this.handName);
            this.cursor =
                this.handName === "right"
                    ? SIK_1.SIK.CursorController.getCursorByInputType(Interactor_1.InteractorInputType.RightHand)
                    : SIK_1.SIK.CursorController.getCursorByInputType(Interactor_1.InteractorInputType.LeftHand);
            this.animationManager.requestAnimationFrame(() => {
                this.update();
            });
            this.hideVisual();
        };
        this.addRequest = () => {
            this.requests += 1;
        };
        this.removeRequest = () => {
            this.requests -= 1;
            if (this.requests < 0)
                this.requests = 0;
        };
        this.update = () => {
            if (this.visible) {
                this.transform.setWorldPosition(this.hand.indexUpperJoint.position);
                this.transform.setWorldRotation(this.hand.indexUpperJoint.rotation);
            }
            if (!this.visible && this.requests > 0) {
                this.showVisual();
            }
            if (this.visible && this.requests === 0) {
                this.hideVisual();
            }
            this.animationManager.requestAnimationFrame(() => {
                this.update();
            });
        };
        this.showVisual = () => {
            this.sceneObject.enabled = true;
            if (this.cancelSet)
                this.cancelSet.cancel();
            this.visible = true;
            this.cursor.enabled = false;
            (0, animate_1.default)({
                cancelSet: this.cancelSet,
                duration: (FINGER_FADE_DURATION * (MAX_ALPHA - this.material.mainPass.alpha)) /
                    MAX_ALPHA,
                update: (t) => {
                    this.material.mainPass.alpha = t * MAX_ALPHA;
                },
            });
        };
        this.hideVisual = () => {
            if (this.cancelSet)
                this.cancelSet.cancel();
            this.visible = false;
            this.cursor.enabled = true;
            (0, animate_1.default)({
                cancelSet: this.cancelSet,
                duration: (FINGER_FADE_DURATION * this.material.mainPass.alpha) / MAX_ALPHA,
                update: (t) => {
                    this.material.mainPass.alpha = 0;
                },
                ended: () => {
                    this.sceneObject.enabled = false;
                },
            });
        };
    }
};
exports.PokeVisualHandler = PokeVisualHandler;
exports.PokeVisualHandler = PokeVisualHandler = __decorate([
    component
], PokeVisualHandler);
//# sourceMappingURL=PokeVisualHandler.js.map