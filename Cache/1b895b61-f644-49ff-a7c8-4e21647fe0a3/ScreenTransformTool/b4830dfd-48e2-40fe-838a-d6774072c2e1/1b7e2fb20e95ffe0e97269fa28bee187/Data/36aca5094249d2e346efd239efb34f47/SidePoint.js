"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.SidePoint = exports.TouchEventType = void 0;
const Point_1 = require("./Point");
const LensRegion_1 = require("../../../Common/Utilities/LensRegion/LensRegion");
const Gizmo_1 = require("../Gizmo");
var TouchEventType;
(function (TouchEventType) {
    TouchEventType[TouchEventType["STARTED"] = 0] = "STARTED";
    TouchEventType[TouchEventType["CHANGED"] = 1] = "CHANGED";
    TouchEventType[TouchEventType["ENDED"] = 2] = "ENDED";
})(TouchEventType || (exports.TouchEventType = TouchEventType = {}));
class SidePoint extends Point_1.Point {
    constructor(sceneObject) {
        super(sceneObject);
    }
    setupInteractions() {
        let worldOffset = vec3.zero();
        let interactionStarted = false;
        let touchMoveRegistry = null;
        const processTouch = (eventData, touchEventType) => {
            this.callback && this.callback({
                screenPosition: eventData.position,
                sidePointOffset: this.offset,
                worldPosition: translatedTouchPosition(eventData).sub(worldOffset),
                touchEventType: touchEventType
            });
        };
        const translatedTouchPosition = (eventData) => {
            return this.interactionCamera.screenSpaceToWorldSpace(eventData.position, -1);
        };
        const onTouchStart = (eventData) => {
            if (LensRegion_1.LensRegion.isBusy) {
                return;
            }
            interactionStarted = true;
            if (this.validator && this.validator()) {
                const sidePointWorldPosition = this.screenTransform.localPointToWorldPoint(vec2.zero());
                worldOffset = translatedTouchPosition(eventData).sub(sidePointWorldPosition);
            }
            Gizmo_1.Gizmo.isBusy = true;
            processTouch(eventData, TouchEventType.STARTED);
            // Because touchMove is triggered at the same time as touchStart, and it is wrong even when there's no movement.
            touchMoveRegistry = this.interactionComponent.onTouchMove.add(onTouchMove);
        };
        const onTouchMove = (eventData) => {
            if (!interactionStarted) {
                return;
            }
            processTouch(eventData, TouchEventType.CHANGED);
        };
        const onTouchEnd = (eventData) => {
            if (!interactionStarted) {
                return;
            }
            interactionStarted = false;
            processTouch(eventData, TouchEventType.ENDED);
            this.interactionComponent.onTouchMove.remove(touchMoveRegistry);
            Gizmo_1.Gizmo.isBusy = false;
        };
        this.interactionComponent.onTouchStart.add(onTouchStart);
        // this.interactionComponent.onTouchMove.add(onTouchMove);
        this.interactionComponent.onTouchEnd.add(onTouchEnd);
    }
}
exports.SidePoint = SidePoint;
//# sourceMappingURL=SidePoint.js.map