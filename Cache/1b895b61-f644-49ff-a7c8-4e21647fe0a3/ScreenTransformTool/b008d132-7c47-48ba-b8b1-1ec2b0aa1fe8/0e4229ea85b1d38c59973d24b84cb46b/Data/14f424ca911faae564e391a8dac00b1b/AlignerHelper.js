"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.AlignerHelper = void 0;
const AlignmentTypes_1 = require("./Gizmo/AlignmentTypes");
const Config_1 = require("./Config");
const DrawHelper_1 = require("./DrawHelper");
const GizmoUtils_1 = require("./Gizmo/GizmoUtils");
const KeyboardListener_1 = require("./KeyboardListener");
var CornerType;
(function (CornerType) {
    CornerType[CornerType["TopRight"] = 0] = "TopRight";
    CornerType[CornerType["BottomRight"] = 1] = "BottomRight";
    CornerType[CornerType["BottomLeft"] = 2] = "BottomLeft";
    CornerType[CornerType["TopLeft"] = 3] = "TopLeft";
    CornerType[CornerType["Count"] = 4] = "Count";
})(CornerType || (CornerType = {}));
class AlignerHelper {
    constructor(tree, camera, lineRenderer, guides, lensRegion) {
        this.tree = tree;
        this.camera = camera;
        this.lineRenderer = lineRenderer;
        this.guides = guides;
        this.lensRegion = lensRegion;
        this.EPS = 1e-5;
        this.UNREACHABLE_DISTANCE = 1000;
        this.cornersLocalPoint = [vec2.one(), new vec2(1, -1),
            vec2.one().uniformScale(-1), new vec2(-1, 1)];
        this.objects = [];
        this.screenTransforms = [];
        this.lastCameraSize = 0;
        this.horizontal = [];
        this.vertical = [];
        this.align = (data) => {
            //@ts-ignore
            if (!Config_1.Config.isSnappingEnabled.value || KeyboardListener_1.KeyboardListener.isKeyPressed(Keys.Key_Shift)) {
                return;
            }
            if (this.camera.size !== this.lastCameraSize) {
                this.lastCameraSize = this.camera.size;
                this.reset();
            }
            this.lineRenderer.reset();
            switch (data.interactionType) {
                case AlignmentTypes_1.InteractionType.Move:
                    this.alignMove([data.screenTransform, ...data.extraScreenTransforms]);
                    break;
                case AlignmentTypes_1.InteractionType.Pivot:
                    this.alignPivot(data.screenTransform);
                    break;
                case AlignmentTypes_1.InteractionType.Rotation:
                    this.alignRotation(data.screenTransform);
                    break;
                case AlignmentTypes_1.InteractionType.Scale:
                    this.alignScale(data.screenTransform, data.direction);
                    break;
                default:
                    throw new Error("[AlignerHelper] Unregistered Interaction Type");
            }
            this.lineRenderer.update();
        };
    }
    reset() {
        this.init();
    }
    alignMove(screenTransforms) {
        const savePivots = screenTransforms.map(scr => scr.pivot);
        screenTransforms.forEach(scr => GizmoUtils_1.GizmoUtils.setPivotPreservePosition(scr, vec2.zero()));
        const extraPoints = this.guides.getScreenPoints();
        const screenPoints = [];
        screenTransforms.forEach((screenTransform) => {
            this.cornersLocalPoint.forEach((corner) => {
                screenPoints.push(this.localPointToScreenSpace(screenTransform, corner, this.camera));
            });
            screenPoints.push(this.localPointToScreenSpace(screenTransform, vec2.zero(), this.camera));
        });
        let verticalDelta = this.UNREACHABLE_DISTANCE; //this.getClosestVerticalDelta(screenPoints);
        let horizontalDelta = this.UNREACHABLE_DISTANCE; //this.getClosestHorizontalDelta(screenPoints);
        if (Config_1.Config.isSnappingEnabled.value) {
            verticalDelta = this.getClosestVerticalDelta(screenPoints);
            horizontalDelta = this.getClosestHorizontalDelta(screenPoints);
        }
        screenPoints.forEach((screenPoint) => {
            extraPoints.forEach((line) => {
                const deltaX = line.x - screenPoint.x;
                const deltaY = line.y - screenPoint.y;
                if (Math.abs(deltaX) < Math.abs(verticalDelta)) {
                    verticalDelta = deltaX;
                }
                if (Math.abs(deltaY) < Math.abs(horizontalDelta)) {
                    horizontalDelta = deltaY;
                }
            });
        });
        const screenParentCenters = screenTransforms.map(scr => this.camera.worldSpaceToScreenSpace(scr.localPointToWorldPoint(vec2.zero())));
        if (Math.abs(verticalDelta) < Config_1.Config.MaxAttachScreenDistance) {
            screenParentCenters.forEach(center => center.x += verticalDelta);
            screenPoints.forEach(point => point.x += verticalDelta);
        }
        if (Math.abs(horizontalDelta) < Config_1.Config.MaxAttachScreenDistance) {
            screenParentCenters.forEach(center => center.y += horizontalDelta);
            screenPoints.forEach(point => point.y += horizontalDelta);
        }
        screenTransforms.forEach((screenTransform, idx) => {
            screenTransform.anchors.setCenter(screenTransform.worldPointToParentPoint(this.camera.screenSpaceToWorldSpace(screenParentCenters[idx], 10)));
        });
        screenTransforms.forEach((scr, idx) => GizmoUtils_1.GizmoUtils.setPivotPreservePosition(scr, savePivots[idx]));
        this.drawHelper.drawLines(screenPoints, extraPoints);
    }
    alignPivot(screenTransform) {
        const extraPoints = this.guides.getScreenPoints();
        this.cornersLocalPoint.forEach((point) => {
            extraPoints.push(this.localPointToScreenSpace(screenTransform, point, this.camera));
        });
        extraPoints.push(this.localPointToScreenSpace(screenTransform, vec2.zero(), this.camera));
        const screenPivotPoint = this.localPointToScreenSpace(screenTransform, screenTransform.pivot, this.camera);
        let verticalDelta = this.UNREACHABLE_DISTANCE; //this.getClosestVerticalDelta([screenPivotPoint]);
        let horizontalDelta = this.UNREACHABLE_DISTANCE; //this.getClosestHorizontalDelta([screenPivotPoint]);
        if (Config_1.Config.isSnappingEnabled.value) {
            verticalDelta = this.getClosestVerticalDelta([screenPivotPoint]);
            horizontalDelta = this.getClosestHorizontalDelta([screenPivotPoint]);
        }
        extraPoints.forEach((line) => {
            const deltaX = line.x - screenPivotPoint.x;
            const deltaY = line.y - screenPivotPoint.y;
            if (Math.abs(deltaX) < Math.abs(verticalDelta)) {
                verticalDelta = deltaX;
            }
            if (Math.abs(deltaY) < Math.abs(horizontalDelta)) {
                horizontalDelta = deltaY;
            }
        });
        if (Math.abs(verticalDelta) < Config_1.Config.MaxAttachScreenDistance) {
            screenPivotPoint.x += verticalDelta;
        }
        if (Math.abs(horizontalDelta) < Config_1.Config.MaxAttachScreenDistance) {
            screenPivotPoint.y += horizontalDelta;
        }
        GizmoUtils_1.GizmoUtils.setPivotPreservePosition(screenTransform, screenTransform.worldPointToLocalPoint(this.camera.screenSpaceToWorldSpace(screenPivotPoint, 10)));
        this.drawHelper.drawLines([screenPivotPoint], extraPoints);
    }
    alignRotation(screenTransform) {
        // There's no need for this, it wasn't supported in Studio3D
    }
    alignScale(screenTransform, direction) {
        const savePivot = screenTransform.pivot;
        const cornerScreenPoint = this.localPointToScreenSpace(screenTransform, direction, this.camera);
        const deltas = this.getDeltasForScreenPoint(screenTransform, cornerScreenPoint);
        if (Math.abs(direction.x) > this.EPS && Math.abs(direction.y) > this.EPS) { // CORNER
            if (Math.abs(deltas.y) < Config_1.Config.MaxAttachScreenDistance) {
                cornerScreenPoint.x += deltas.y;
            }
            if (Math.abs(deltas.x) < Config_1.Config.MaxAttachScreenDistance) {
                cornerScreenPoint.y += deltas.x;
            }
        }
        else { // SIDE POINT
            let screenDirection = cornerScreenPoint.sub(this.localPointToScreenSpace(screenTransform, vec2.zero(), this.camera));
            const angledDeltaHorizontal = new vec2(this.UNREACHABLE_DISTANCE, this.UNREACHABLE_DISTANCE);
            const angledDeltaVertical = new vec2(this.UNREACHABLE_DISTANCE, this.UNREACHABLE_DISTANCE);
            if (Math.abs(screenDirection.y) > this.EPS) { // Horizontal y = c
                const angledDeltaX = (deltas.x / screenDirection.y) * screenDirection.x; // X = Xs + T * Vx;
                angledDeltaHorizontal.x = angledDeltaX;
                angledDeltaHorizontal.y = deltas.x;
            }
            if (Math.abs(screenDirection.x) > this.EPS) { // Vertical x = c
                const angledDeltaY = (deltas.y / screenDirection.x) * screenDirection.y; // Y = Ys + T * Vy;
                angledDeltaVertical.x = deltas.y;
                angledDeltaVertical.y = angledDeltaY;
            }
            const res = angledDeltaVertical.lengthSquared < angledDeltaHorizontal.lengthSquared ? angledDeltaVertical : angledDeltaHorizontal;
            if (Math.abs(res.x) < Config_1.Config.MaxAttachScreenDistance && Math.abs(res.y) < Config_1.Config.MaxAttachScreenDistance) {
                cornerScreenPoint.x += res.x;
                cornerScreenPoint.y += res.y;
            }
        }
        let cornerWorldPoint = this.camera.screenSpaceToWorldSpace(cornerScreenPoint, 10);
        const pivotWorldPoint = screenTransform.localPointToWorldPoint(savePivot);
        cornerWorldPoint.z = pivotWorldPoint.z;
        cornerWorldPoint = cornerWorldPoint.sub(pivotWorldPoint);
        cornerWorldPoint = quat.fromEulerAngles(0, 0, -screenTransform.rotation.toEulerAngles().z).multiplyVec3(cornerWorldPoint);
        cornerWorldPoint = cornerWorldPoint.add(pivotWorldPoint);
        // Adjust for scale
        let diff = cornerWorldPoint.sub(pivotWorldPoint);
        const scale = screenTransform.scale;
        diff.x = diff.x * (Math.abs(scale.x) > this.EPS ? 1 / scale.x : 0);
        diff.y = diff.y * (Math.abs(scale.y) > this.EPS ? 1 / scale.y : 0);
        diff.z = diff.z * (Math.abs(scale.z) > this.EPS ? 1 / scale.z : 0);
        cornerWorldPoint = pivotWorldPoint.add(diff);
        const anchors = screenTransform.anchors;
        const cornerParentPoint = screenTransform.worldPointToParentPoint(cornerWorldPoint);
        let topRight = new vec2(screenTransform.anchors.top, screenTransform.anchors.right);
        const leftBottom = new vec2(screenTransform.anchors.left, screenTransform.anchors.bottom);
        let localDirection = vec2.one();
        if (direction.x > this.EPS) {
            topRight.y = cornerParentPoint.x;
            localDirection.x *= -1;
        }
        else if (direction.x < -this.EPS) {
            leftBottom.x = cornerParentPoint.x;
        }
        if (direction.y > this.EPS) {
            topRight.x = cornerParentPoint.y;
            localDirection.y *= -1;
        }
        else if (direction.y < -this.EPS) {
            leftBottom.y = cornerParentPoint.y;
        }
        GizmoUtils_1.GizmoUtils.setPivotPreservePosition(screenTransform, direction.uniformScale(-1));
        const oldSize = anchors.getSize();
        const newSize = new vec2(topRight.y - leftBottom.x, topRight.x - leftBottom.y);
        localDirection = localDirection.mult(oldSize.sub(newSize));
        anchors.setSize(newSize);
        anchors.setCenter(anchors.getCenter().add(localDirection.uniformScale(0.5)));
        GizmoUtils_1.GizmoUtils.setPivotPreservePosition(screenTransform, savePivot);
        this.drawHelper.drawLines([cornerScreenPoint], this.guides.getScreenPoints());
    }
    init() {
        this.objects = this.tree.collectObjectsForAlignment();
        this.screenTransforms = [];
        this.objects.forEach(obj => this.screenTransforms.push(obj.getComponent("ScreenTransform")));
        this.collectAlignPoints();
        this.drawHelper = new DrawHelper_1.DrawHelper(this.horizontal, this.vertical, this.lineRenderer, this.camera, this.lensRegion);
    }
    getClosestVerticalDelta(points, extraLines = []) {
        return this.findClosestDelta(this.vertical, points, (a, b) => {
            return a.x - b.x;
        });
    }
    getClosestHorizontalDelta(points) {
        return this.findClosestDelta(this.horizontal, points, (a, b) => {
            return a.y - b.y;
        });
    }
    getDeltasForScreenPoint(screenTransform, point) {
        const extraPoints = this.guides.getScreenPoints();
        // let horizontalDelta = this.UNREACHABLE_DISTANCE; //this.getClosestHorizontalDelta([cornerScreenPoint]);
        // let verticalDelta = this.UNREACHABLE_DISTANCE; //this.getClosestVerticalDelta([cornerScreenPoint]);
        const deltas = new vec2(this.UNREACHABLE_DISTANCE, this.UNREACHABLE_DISTANCE);
        if (Config_1.Config.isSnappingEnabled.value) {
            deltas.x = this.getClosestHorizontalDelta([point]);
            deltas.y = this.getClosestVerticalDelta([point]);
        }
        extraPoints.forEach((line) => {
            const deltaX = line.x - point.x;
            const deltaY = line.y - point.y;
            if (Math.abs(deltaX) < Math.abs(deltas.x)) {
                deltas.x = deltaX;
            }
            if (Math.abs(deltaY) < Math.abs(deltas.y)) {
                deltas.y = deltaY;
            }
        });
        return deltas;
    }
    findClosestDelta(lines, points, compareFunc) {
        let delta = Config_1.Config.MaxAttachScreenDistance + 10;
        let absDelta = -1;
        let line = vec2.zero();
        let corner = vec2.zero();
        points.forEach((point) => {
            const closestLine = this.findClosestInSortedArray(lines, point, compareFunc);
            if (!closestLine) {
                return;
            }
            const currentDelta = compareFunc(closestLine, point); //closestLine.y - point.y;
            const currentAbsDelta = Math.abs(currentDelta);
            if (absDelta < 0 || currentAbsDelta < absDelta) {
                absDelta = currentAbsDelta;
                delta = currentDelta;
                line = closestLine;
                corner = point;
            }
        });
        return delta;
    }
    findClosestInSortedArray(arr, point, fun) {
        if (!arr.length) {
            return null;
        }
        let l = 0;
        let r = arr.length - 1;
        while (r - l > 2) {
            const mid = Math.floor((r + l) / 2);
            const midValue = fun(arr[mid], point);
            if (midValue < 0) {
                l = mid;
            }
            else {
                r = mid;
            }
        }
        let res = Math.abs(fun(arr[l], point));
        let idx = l;
        for (let i = l + 1; i <= r; i++) {
            const currentDelta = Math.abs(fun(arr[i], point));
            if (res >= currentDelta) {
                res = currentDelta;
                idx = i;
            }
        }
        return arr[idx];
    }
    localPointToScreenSpace(screenTransform, point, camera) {
        return camera.worldSpaceToScreenSpace(screenTransform.localPointToWorldPoint(point));
    }
    collectAlignPoints() {
        this.horizontal = [];
        this.vertical = [];
        const addPoint = (point) => {
            this.horizontal.push(point);
            this.vertical.push(point);
        };
        let rootIsAdded = false;
        this.screenTransforms.forEach((screenTransform) => {
            if (!rootIsAdded && !isNull(screenTransform.getSceneObject().hasParent())
                && screenTransform.getSceneObject().getParent().uniqueIdentifier === this.tree.getRoot().uniqueIdentifier) {
                this.cornersLocalPoint.forEach((corner) => {
                    addPoint(GizmoUtils_1.GizmoUtils.parentPointToScreenPoint(screenTransform, corner));
                });
                rootIsAdded = true;
            }
            this.cornersLocalPoint.forEach((corner) => {
                addPoint(this.localPointToScreenSpace(screenTransform, corner, this.camera));
            });
            addPoint(this.localPointToScreenSpace(screenTransform, screenTransform.pivot, this.camera));
        });
        this.tree.getSelectedObjects().forEach((obj) => {
            if (rootIsAdded || isNull(obj) || isNull(obj.hasParent())
                || obj.getParent().uniqueIdentifier !== this.tree.getRoot().uniqueIdentifier) {
                return;
            }
            const screenTransform = obj.getComponent("ScreenTransform");
            this.cornersLocalPoint.forEach((corner) => {
                addPoint(GizmoUtils_1.GizmoUtils.parentPointToScreenPoint(screenTransform, corner));
            });
            rootIsAdded = true;
        });
        this.vertical = this.vertical.sort((a, b) => {
            if (a.x !== b.x) {
                return a.x - b.x;
            }
            return b.y - a.y;
        });
        this.horizontal = this.horizontal.sort((a, b) => {
            if (a.y !== b.y) {
                return a.y - b.y;
            }
            return b.x - a.x;
        });
    }
}
exports.AlignerHelper = AlignerHelper;
//# sourceMappingURL=AlignerHelper.js.map