"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.GizmoUtils = void 0;
var GizmoUtils;
(function (GizmoUtils) {
    GizmoUtils.aspectSource = global.scene.liveTarget;
    GizmoUtils.GIZMO_LAYER = LayerSet.makeUnique();
    GizmoUtils.TOP_LEFT = new vec2(-1, 1);
    GizmoUtils.TOP_RIGHT = new vec2(1, 1);
    GizmoUtils.BOTTOM_LEFT = new vec2(-1, -1);
    GizmoUtils.BOTTOM_RIGHT = new vec2(1, -1);
    function getAspect() {
        return GizmoUtils.aspectSource.control.getAspect();
    }
    GizmoUtils.getAspect = getAspect;
    function getPerpendicularVec3(vec) {
        return new vec3(-vec.y, vec.x, 0);
    }
    GizmoUtils.getPerpendicularVec3 = getPerpendicularVec3;
    function localPointToParentPoint(screenTransform, point) {
        return screenTransform.screenPointToParentPoint(screenTransform.localPointToScreenPoint(point));
    }
    GizmoUtils.localPointToParentPoint = localPointToParentPoint;
    function screenPointToWorldPoint(screenTransform, point) {
        let localPoint = screenTransform.screenPointToLocalPoint(point);
        if (!localPoint) {
            return vec3.zero();
        }
        return screenTransform.localPointToWorldPoint(screenTransform.screenPointToLocalPoint(point));
    }
    GizmoUtils.screenPointToWorldPoint = screenPointToWorldPoint;
    function worldPointToScreenPoint(screenTransform, point) {
        let localPoint = screenTransform.worldPointToLocalPoint(point);
        if (!localPoint) {
            return vec2.zero();
        }
        return screenTransform.localPointToScreenPoint(localPoint);
    }
    GizmoUtils.worldPointToScreenPoint = worldPointToScreenPoint;
    function getParentWorldWidth(screenTransform) {
        // try {
        return screenPointToWorldPoint(screenTransform, parentPointToScreenPoint(screenTransform, GizmoUtils.TOP_LEFT))
            .distance(screenPointToWorldPoint(screenTransform, parentPointToScreenPoint(screenTransform, GizmoUtils.TOP_RIGHT)));
        // } catch (e) {
        //     print("CATCH");
        //     return 0;
        // }
    }
    GizmoUtils.getParentWorldWidth = getParentWorldWidth;
    function getParentWorldHeight(screenTransform) {
        // try {
        return screenPointToWorldPoint(screenTransform, parentPointToScreenPoint(screenTransform, GizmoUtils.TOP_LEFT))
            .distance(screenPointToWorldPoint(screenTransform, parentPointToScreenPoint(screenTransform, GizmoUtils.BOTTOM_LEFT)));
        // } catch (e) {
        //     return 0;
        // }
    }
    GizmoUtils.getParentWorldHeight = getParentWorldHeight;
    function screenPointToScreenPoint(point, cameraA, cameraB) {
        return cameraB.worldSpaceToScreenSpace(cameraA.screenSpaceToWorldSpace(point, -1));
    }
    GizmoUtils.screenPointToScreenPoint = screenPointToScreenPoint;
    function parentPointToScreenPoint(screenTransform, point) {
        let topLeft = screenTransform.screenPointToParentPoint(vec2.zero());
        let bottomRight = screenTransform.screenPointToParentPoint(vec2.one());
        if (!topLeft) {
            topLeft = new vec2(-1, 1);
        }
        if (!bottomRight) {
            bottomRight = new vec2(1, -1);
        }
        return new vec2((point.x - topLeft.x) / (bottomRight.x - topLeft.x), 1 - (point.y - bottomRight.y) / (topLeft.y - bottomRight.y));
    }
    GizmoUtils.parentPointToScreenPoint = parentPointToScreenPoint;
    function parentPointToWorldPoint(scr, point) {
        const parent = scr.getSceneObject().getParent();
        if (!parent) {
            return vec3.zero();
        }
        const camera = parent.getComponent("Camera");
        const canvas = parent.getComponent("Canvas");
        const screenTransform = parent.getComponent("ScreenTransform");
        if (camera && camera.type === Camera.Type.Orthographic) {
            point = point.mult(camera.getOrthographicSize().uniformScale(0.5));
            return camera.getTransform().getWorldTransform().multiplyPoint(new vec3(point.x, point.y, 0));
        }
        else if (canvas) {
            point = point.mult(canvas.getSize().uniformScale(0.5));
            return canvas.getTransform().getWorldTransform().multiplyPoint(new vec3(point.x, point.y, 0));
        }
        else if (screenTransform) {
            return screenTransform.localPointToWorldPoint(point);
        }
        return vec3.zero();
    }
    GizmoUtils.parentPointToWorldPoint = parentPointToWorldPoint;
    function execPreservePosition(screenTransform, func) {
        const centerWorldPosition = screenTransform.localPointToWorldPoint(vec2.zero());
        func();
        const newCenterWorldPosition = screenTransform.localPointToWorldPoint(vec2.zero());
        const worldDelta = screenTransform.worldPointToParentPoint(centerWorldPosition)
            .sub(screenTransform.worldPointToParentPoint(newCenterWorldPosition));
        screenTransform.anchors.setCenter(screenTransform.anchors.getCenter().add(worldDelta));
    }
    GizmoUtils.execPreservePosition = execPreservePosition;
    function setPivotPreservePosition(screenTransform, point) {
        execPreservePosition(screenTransform, () => {
            screenTransform.pivot = point;
        });
    }
    GizmoUtils.setPivotPreservePosition = setPivotPreservePosition;
    function rotateVec2(vec, angle) {
        const res = vec2.zero();
        res.x = vec.x * Math.cos(angle) - vec.y * Math.sin(angle);
        res.y = vec.x * Math.sin(angle) + vec.y * Math.cos(angle);
        return res;
    }
    GizmoUtils.rotateVec2 = rotateVec2;
    function rotateVec3z(vec, angle) {
        const res = vec3.zero();
        res.x = vec.x * Math.cos(angle) - vec.y * Math.sin(angle);
        res.y = vec.x * Math.sin(angle) + vec.y * Math.cos(angle);
        return res;
    }
    GizmoUtils.rotateVec3z = rotateVec3z;
    function roundAngleToDegrees(angle, step) {
        return Math.round(angle / step) * step;
    }
    GizmoUtils.roundAngleToDegrees = roundAngleToDegrees;
})(GizmoUtils || (exports.GizmoUtils = GizmoUtils = {}));
//# sourceMappingURL=GizmoUtils.js.map