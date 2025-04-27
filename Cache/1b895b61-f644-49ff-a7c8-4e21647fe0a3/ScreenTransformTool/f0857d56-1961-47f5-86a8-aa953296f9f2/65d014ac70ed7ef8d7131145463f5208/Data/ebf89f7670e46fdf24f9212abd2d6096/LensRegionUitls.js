"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.LensRegionUtils = void 0;
var LensRegionUtils;
(function (LensRegionUtils) {
    function execPreservePosition(screenTransform, func) {
        const centerWorldPosition = screenTransform.localPointToWorldPoint(vec2.zero());
        func();
        const newCenterWorldPosition = screenTransform.localPointToWorldPoint(vec2.zero());
        const worldDelta = screenTransform.worldPointToParentPoint(centerWorldPosition)
            .sub(screenTransform.worldPointToParentPoint(newCenterWorldPosition));
        screenTransform.anchors.setCenter(screenTransform.anchors.getCenter().add(worldDelta));
    }
    LensRegionUtils.execPreservePosition = execPreservePosition;
    function setPivotPreservePosition(screenTransform, point) {
        execPreservePosition(screenTransform, () => {
            screenTransform.pivot = point;
        });
    }
    LensRegionUtils.setPivotPreservePosition = setPivotPreservePosition;
})(LensRegionUtils || (exports.LensRegionUtils = LensRegionUtils = {}));
//# sourceMappingURL=LensRegionUitls.js.map