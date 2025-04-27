"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const SIK_1 = require("../../../SpectaclesInteractionKit/SIK");
const FunctionTimingUtils_1 = require("../../../SpectaclesInteractionKit/Utils/FunctionTimingUtils");
const NativeLogger_1 = require("../../../SpectaclesInteractionKit/Utils/NativeLogger");
const SceneObjectUtils_1 = require("../../../SpectaclesInteractionKit/Utils/SceneObjectUtils");
const PokeVisualHandler_1 = require("./PokeVisualHandler");
const TAG = "TouchHandler";
const log = new NativeLogger_1.default(TAG);
/*
 * a time buffer in ms to detect if a touch is a tap or a drag
 * if less than buffer, we call it a tap
 */
const MAX_TOUCH_BUFFER = 200;
/**
 * poke boundary
 */
const POKE_BOUNDARY_FRONT = 15;
const POKE_BOUNDARY_BACK = -5;
/**
 * number of seconds for finger fade
 */
const FINGER_FADE_DURATION = 0.2;
const msToNs = function (ms) {
    return ms * 1000 * 1000;
};
// getTime return seconds, convert to milliseconds
const getTimeMs = () => {
    return getTime() * 1000;
};
/**
 *
 * TouchHandler is class that handles input positions from an interactable
 * and formats them and sends them to webview
 *
 */
class TouchHandler {
    constructor(options) {
        this.options = options;
        this.currentTouchPoint = vec3.zero();
        this.startTouchPoint = vec3.zero();
        this.currentDrag = vec3.zero();
        this.dragSum = vec3.zero();
        this.touchStartTime = 0;
        this.touchIndex = 0;
        this.usePoke = this.options.usePoke;
        this.isPinching = false;
        this.startingPinch = false;
        this.lastPinch = false;
        this.isHover = false;
        this.isPoke = false;
        this.webViewPlaneCollider = this.options.planeCollider;
        this.planeTransform = this.webViewPlaneCollider.getSceneObject().getTransform();
        this.screenSize = this.options.screenSize;
        this.interactable = this.options.interactable;
        this.interactor = null;
        this.lastInteractor = null;
        this.fingerVisualPrefab = requireAsset("../../Prefabs/FingerVisual.prefab");
        this.rightHandInRange = false;
        this.rightHandInRangeLastFrame = false;
        this.leftHandInRange = false;
        this.leftHandInRangeLastFrame = false;
        // used to record replay data
        this.logTouchData = false;
        this.setupPokeVisual = () => {
            const rightFingerInScene = (0, SceneObjectUtils_1.findSceneObjectByName)(null, "RightHandWebViewPokeVisual");
            const leftFingerInScene = (0, SceneObjectUtils_1.findSceneObjectByName)(null, "LeftHandWebViewPokeVisual");
            if (rightFingerInScene !== null) {
                this.rightFingerVisual = rightFingerInScene;
                this.leftFingerVisual = leftFingerInScene;
                this.rightFingerVisualHandler = this.rightFingerVisual.getComponent(PokeVisualHandler_1.PokeVisualHandler.getTypeName());
                this.leftFingerVisualHandler = this.leftFingerVisual.getComponent(PokeVisualHandler_1.PokeVisualHandler.getTypeName());
            }
            else {
                this.rightFingerVisual = this.fingerVisualPrefab.instantiate(null);
                this.rightFingerVisual.name = "RightHandWebViewPokeVisual";
                this.rightFingerVisualHandler = this.rightFingerVisual.getComponent(PokeVisualHandler_1.PokeVisualHandler.getTypeName());
                this.rightFingerVisualHandler.handName = "right";
                this.rightFingerVisualHandler.initialize();
                this.leftFingerVisual = this.fingerVisualPrefab.instantiate(null);
                this.leftFingerVisual.name = "LeftHandWebViewPokeVisual";
                this.leftFingerVisualHandler = this.leftFingerVisual.getComponent(PokeVisualHandler_1.PokeVisualHandler.getTypeName());
                this.leftFingerVisualHandler.handName = "left";
                this.leftFingerVisualHandler.initialize();
            }
        };
        this.checkPokeState = () => {
            const rightHandPlanePosition = this.planeTransform
                .getInvertedWorldTransform()
                .multiplyPoint(this.rightHand.indexTip.position);
            if (rightHandPlanePosition.z < POKE_BOUNDARY_FRONT &&
                rightHandPlanePosition.z > POKE_BOUNDARY_BACK &&
                rightHandPlanePosition.x < 0.5 &&
                rightHandPlanePosition.x > -0.5 &&
                rightHandPlanePosition.y < 0.5 &&
                rightHandPlanePosition.y > -0.5) {
                this.rightHandInRange = true;
            }
            else {
                this.rightHandInRange = false;
            }
            if (this.rightHandInRange && !this.rightHandInRangeLastFrame) {
                this.rightFingerVisualHandler.addRequest();
                this.rightHandInRangeLastFrame = true;
            }
            if (!this.rightHandInRange && this.rightHandInRangeLastFrame) {
                this.rightFingerVisualHandler.removeRequest();
                this.rightHandInRangeLastFrame = false;
            }
            const leftHandPlanePosition = this.planeTransform
                .getInvertedWorldTransform()
                .multiplyPoint(this.leftHand.indexTip.position);
            if (leftHandPlanePosition.z < POKE_BOUNDARY_FRONT &&
                leftHandPlanePosition.z > POKE_BOUNDARY_BACK &&
                leftHandPlanePosition.x < 0.5 &&
                leftHandPlanePosition.x > -0.5 &&
                leftHandPlanePosition.y < 0.5 &&
                leftHandPlanePosition.y > -0.5) {
                this.leftHandInRange = true;
            }
            else {
                this.leftHandInRange = false;
            }
            if (this.leftHandInRange && !this.leftHandInRangeLastFrame) {
                this.leftFingerVisualHandler.addRequest();
                this.leftHandInRangeLastFrame = true;
            }
            if (!this.leftHandInRange && this.leftHandInRangeLastFrame) {
                this.leftFingerVisualHandler.removeRequest();
                this.leftHandInRangeLastFrame = false;
            }
            if (this.leftHandInRange || this.rightHandInRange) {
                if (!this.isPoke) {
                    this.isPoke = true;
                    this.interactable.targetingMode = 4;
                }
            }
            else {
                if (this.isPoke) {
                    this.isPoke = false;
                    this.interactable.targetingMode = 3;
                }
            }
        };
        this.handlePoke = () => {
            var _a, _b, _c, _d, _e;
            if ((_a = this.interactor) === null || _a === void 0 ? void 0 : _a.currentDragVector) {
                // drag multiplier, raw drag values feel to extreme, so dampened by a factor
                const dragMult = 1;
                this.currentDrag = this.interactor.currentDragVector;
                this.currentDrag = this.planeTransform.getInvertedWorldTransform().multiplyDirection(this.currentDrag);
                this.currentDrag = this.currentDrag.uniformScale(dragMult);
                this.dragSum.x += this.currentDrag.x;
                this.dragSum.y += this.currentDrag.y;
            }
            if (this.startingPinch && !this.isPinching) {
                // start pinch on web plane
                this.isPinching = true;
                if (((_b = this.interactor) === null || _b === void 0 ? void 0 : _b.inputType) === 1) {
                    this.leftFingerVisualHandler.material.mainPass.trigger = 1;
                }
                else if (((_c = this.interactor) === null || _c === void 0 ? void 0 : _c.inputType) === 2) {
                    this.rightFingerVisualHandler.material.mainPass.trigger = 1;
                }
                this.lastPinch = true;
                this.startingPinch = false;
                this.touchStartTime = msToNs(Date.now());
                this.startTouchPoint = this.currentTouchPoint;
                this.touchHandler(TouchState.Began, this.currentTouchPoint.x, this.currentTouchPoint.y);
            }
            else if (this.isPinching && this.lastPinch) {
                // continue pinch on webplane
                this.touchHandler(TouchState.Moved, this.startTouchPoint.x + this.dragSum.x, this.startTouchPoint.y + this.dragSum.y);
                this.currentTouchPoint = this.startTouchPoint.add(this.dragSum);
            }
            else if (!this.isPinching && !this.lastPinch) {
                this.dragSum.x = 0;
                this.dragSum.y = 0;
            }
            else if (!this.isPinching && this.lastPinch) {
                // if was pinching and no longer, release pinch and send end touch just in case
                this.lastPinch = false;
                if (((_d = this.lastInteractor) === null || _d === void 0 ? void 0 : _d.inputType) === 1) {
                    this.leftFingerVisualHandler.material.mainPass.trigger = 0;
                }
                else if (((_e = this.lastInteractor) === null || _e === void 0 ? void 0 : _e.inputType) === 2) {
                    this.rightFingerVisualHandler.material.mainPass.trigger = 0;
                }
                const wasSmallMovement = this.startTouchPoint.distance(this.currentTouchPoint) < 0.15;
                if (wasSmallMovement) {
                    const nowInNano = msToNs(Date.now());
                    this.touchHandler(TouchState.Cancelled, this.currentTouchPoint.x, this.currentTouchPoint.y);
                    this.touchHandler(TouchState.Began, this.startTouchPoint.x, this.startTouchPoint.y, nowInNano);
                    (0, FunctionTimingUtils_1.setTimeout)(() => {
                        this.touchHandler(TouchState.Ended, this.startTouchPoint.x, this.startTouchPoint.y, nowInNano + 300000);
                    }, 33);
                }
                else {
                    this.touchHandler(TouchState.Ended, this.currentTouchPoint.x, this.currentTouchPoint.y);
                }
            }
        };
        this.handlePinch = () => {
            var _a;
            if (((_a = this.interactor) === null || _a === void 0 ? void 0 : _a.currentDragVector) && this.isPinching) {
                // drag multiplier, raw drag values feel to extreme, so dampened by a factor
                const dragMult = 1;
                this.currentDrag = this.interactor.currentDragVector;
                if (this.currentDrag.lengthSquared > 0.01) {
                    this.currentDrag = this.planeTransform.getInvertedWorldTransform().multiplyDirection(this.currentDrag);
                    this.currentDrag = this.currentDrag.uniformScale(dragMult);
                    this.dragSum.x += this.currentDrag.x;
                    this.dragSum.y += this.currentDrag.y;
                }
            }
            if (this.startingPinch && !this.isPinching) {
                // start pinch on web plane
                this.isPinching = true;
                this.lastPinch = true;
                this.startingPinch = false;
                this.touchStartTime = getTimeMs();
                this.startTouchPoint = this.currentTouchPoint;
                this.touchHandler(TouchState.Began, this.currentTouchPoint.x, this.currentTouchPoint.y);
            }
            else if (this.isPinching && this.lastPinch) {
                // continue pinch on webplane
                const nowInMs = getTimeMs();
                if (nowInMs - this.touchStartTime > MAX_TOUCH_BUFFER || Math.abs(this.dragSum.y) > 0.003) {
                    this.touchHandler(TouchState.Moved, this.startTouchPoint.x + this.dragSum.x, this.startTouchPoint.y + this.dragSum.y);
                }
                else {
                    this.touchHandler(TouchState.Moved, this.startTouchPoint.x, this.startTouchPoint.y);
                }
            }
            else if (!this.isPinching && !this.lastPinch) {
                // not pinching and wasn't pinching, just hovering (also check if hovering on webview)
                if (this.isHover) {
                    this.touchHandler(TouchState.Moved, this.currentTouchPoint.x, this.currentTouchPoint.y);
                }
            }
            else if (!this.isPinching && this.lastPinch) {
                // if was pinching and no longer, release pinch and send end touch just in case
                this.dragSum.x = 0;
                this.dragSum.y = 0;
                this.lastPinch = false;
                const nowInMs = getTimeMs();
                let thisPoint = nowInMs - this.touchStartTime < MAX_TOUCH_BUFFER ? this.startTouchPoint : this.currentTouchPoint;
                this.touchHandler(TouchState.Ended, thisPoint.x, thisPoint.y);
                this.touchIndex++;
            }
        };
        this.update = () => {
            if (this.usePoke) {
                this.checkPokeState();
            }
            if (this.isPoke) {
                this.handlePoke();
            }
            else {
                this.handlePinch();
            }
        };
        /*
         *
         * This function creates touch events to send to the WebView
         * state is the TouchState of the action (start, stop, etc)
         * x is x position on plane
         * y is y position on plane
         */
        this.touchHandler = (state, x, y, time) => {
            x += 0.5;
            y -= 0.5;
            y *= -1;
            x *= this.screenSize.x;
            y *= this.screenSize.y;
            this.options.webView.touch(x, y, state);
        };
        if (this.usePoke) {
            this.setupPokeVisual();
        }
        this.interactable.onHoverEnter(() => {
            this.isHover = true;
        });
        this.interactable.onHoverExit(() => {
            this.isHover = false;
        });
        this.interactable.onTriggerStart((event) => {
            event.stopPropagation();
            this.startingPinch = true;
            this.interactor = event.interactor;
            if (this.interactor.targetHitInfo) {
                this.currentTouchPoint = this.planeTransform
                    .getInvertedWorldTransform()
                    .multiplyPoint(this.interactor.targetHitInfo.hit.position);
            }
        });
        this.interactable.onTriggerEnd(() => {
            this.isPinching = false;
            if (this.interactor)
                this.lastInteractor = this.interactor;
            this.interactor = null;
        });
        this.interactable.onTriggerCanceled(() => {
            this.isPinching = false;
            if (this.interactor)
                this.lastInteractor = this.interactor;
            this.interactor = null;
        });
        this.interactable.onHoverUpdate((event) => {
            if (event.interactor.targetHitInfo) {
                this.currentTouchPoint = this.planeTransform
                    .getInvertedWorldTransform()
                    .multiplyPoint(event.interactor.targetHitInfo.hit.position);
            }
        });
        this.rightHand = SIK_1.SIK.HandInputData.getHand("right");
        this.leftHand = SIK_1.SIK.HandInputData.getHand("left");
        const updateEvent = options.webView.createEvent("UpdateEvent");
        updateEvent.bind(this.update);
    }
}
exports.default = TouchHandler;
//# sourceMappingURL=TouchHandler.js.map