"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var Gizmo_1;
Object.defineProperty(exports, "__esModule", { value: true });
exports.Gizmo = void 0;
var __selfType = requireType("./Gizmo");
function component(target) { target.getTypeName = function () { return __selfType; }; }
const SidePoint_1 = require("./Points/SidePoint");
const PivotPoint_1 = require("./Points/PivotPoint");
const RotationPoint_1 = require("./Points/RotationPoint");
const GizmoUtils_1 = require("./GizmoUtils");
const AlignmentTypes_1 = require("./AlignmentTypes");
const FrameSide_1 = require("./FrameSide");
const AnchorPoint_1 = require("./Points/AnchorPoint");
const AnchorsFrame_1 = require("./AnchorsFrame");
const LensRegion_1 = require("../../Common/Utilities/LensRegion/LensRegion");
const KeyboardListener_1 = require("../KeyboardListener");
const Utils_1 = require("../Utils");
var GizmoMode;
(function (GizmoMode) {
    GizmoMode[GizmoMode["Basic"] = 0] = "Basic";
    GizmoMode[GizmoMode["Advanced"] = 1] = "Advanced";
    GizmoMode[GizmoMode["ScreenRegion"] = 2] = "ScreenRegion";
})(GizmoMode || (GizmoMode = {}));
let Gizmo = Gizmo_1 = class Gizmo extends BaseScriptComponent {
    init() {
        this.onAwake();
        this.initSidePoints();
        this.initPivotPoint();
        this.initRotationPoints();
        this.initAnchorPoints();
        this.initFrameSides();
        this.initAnchorsFrame();
        this.setupGizmoInteractions();
    }
    resetEditable() {
        var _a;
        this.editable = this.getSceneObject().getParent();
        this.editableScreenTransform = this.editable.getComponent("ScreenTransform");
        const region = this.editable.getComponent("ScreenRegionComponent");
        this.hasScreenRegion = region && region.enabled;
        (_a = this.pivotPoint) === null || _a === void 0 ? void 0 : _a.setPosition(this.editableScreenTransform.pivot);
        this.isEditableDirty = true;
        this.setVisualScale(this.editableScreenTransform.getTransform().getWorldScale());
        this.updateVisualMode();
        this.disableText();
    }
    updatePivot() {
        if (isNull(this.editableScreenTransform)) {
            return;
        }
        this.pivotPoint.setPosition(this.editableScreenTransform.pivot);
    }
    updateAdvancedMode() {
        if (isNull(this.fijiScreenTransform)) {
            return;
        }
        this.setAdvancedMode(this.fijiScreenTransform.advanced);
    }
    updateVisualScale() {
        if (isNull(this.editableScreenTransform)) {
            return;
        }
        this.setVisualScale(this.editableScreenTransform.getTransform().getWorldScale());
    }
    hide() {
        this.isHidden = true;
        this.gizmoScreenTransform.scale = vec3.zero();
    }
    show() {
        this.isHidden = false;
        this.gizmoScreenTransform.scale = vec3.one();
    }
    isVisible() {
        return !this.isHidden;
    }
    setEditable(sceneObject) {
        this.getSceneObject().setParent(sceneObject);
        this.resetEditable();
    }
    //@ts-ignore
    setFijiScreenTransform(screenTransform) {
        this.fijiScreenTransform = screenTransform;
    }
    //@ts-ignore
    getFijiScreenTransform() {
        return this.fijiScreenTransform;
    }
    forceUpdate() {
        this.doCallbacks();
    }
    setInteractionCamera(camera) {
        this.pivotPoint.updateInteractionCamera(camera);
        this.sidePoints.forEach(point => point.updateInteractionCamera(camera));
        this.rotationPoints.forEach(point => point.updateInteractionCamera(camera));
        this.anchorPoints.forEach(point => point.updateInteractionCamera(camera));
        this.gizmoInteractionComponent.setCamera(camera);
        this.interactionCamera = camera;
    }
    setLayer(layer) {
        var _a, _b;
        // if (!this.editable.layer.intersect(layer).isEmpty() || !layer.intersect(this.editable.layer).isEmpty()) {
        //     return;
        // }
        this.editable.layer = layer;
        layer = layer.union(GizmoUtils_1.GizmoUtils.GIZMO_LAYER);
        this.gizmoSceneObject.layer = layer;
        (_a = this.pivotPoint) === null || _a === void 0 ? void 0 : _a.updateLayer(layer);
        this.sidePoints.forEach(point => point.updateLayer(layer));
        this.rotationPoints.forEach(point => point.updateLayer(layer));
        this.anchorPoints.forEach(point => point.updateLayer(layer));
        this.frameSides.forEach(frame => frame.updateLayer(layer));
        (_b = this.anchorsFrame) === null || _b === void 0 ? void 0 : _b.updateLayer(layer);
    }
    addOnUpdateCallback(cb) {
        this.doOnUpdate.push(cb);
    }
    addAlignmentFunction(alignmentFunction) {
        this.alignmentFunctions.push(alignmentFunction);
    }
    getEditableScreenTransform() {
        if (isNull(this.editableScreenTransform) || isNull(this.editableScreenTransform.getSceneObject())) {
            return null;
        }
        return this.editableScreenTransform;
    }
    getEditable() {
        if (isNull(this.editable)) {
            return null;
        }
        return this.editable;
    }
    containsWorldPoint(point) {
        return this.containsScreenPoint(GizmoUtils_1.GizmoUtils.worldPointToScreenPoint(this.gizmoScreenTransform, point));
    }
    containsScreenPoint(point) {
        for (let i = 0; i < this.rotationPoints.length; i++) {
            if (this.rotationPoints[i].containsScreenPoint(point)) {
                return true;
            }
        }
        for (let i = 0; i < this.sidePoints.length; i++) {
            if (this.sidePoints[i].containsScreenPoint(point)) {
                return true;
            }
        }
        for (let i = 0; i < this.anchorPoints.length; i++) {
            if (this.anchorPoints[i].containsScreenPoint(point)) {
                return true;
            }
        }
        if (this.pivotPoint.containsScreenPoint(point)) {
            return true;
        }
        return this.gizmoScreenTransform.containsScreenPoint(point);
    }
    processWorldDelta(worldPoint, touchType) {
        if (touchType === SidePoint_1.TouchEventType.STARTED) {
            this.convertOffsetToAnchors();
            this.multiMoveParentTouchStart = this.editableScreenTransform.worldPointToParentPoint(worldPoint);
            this.multiMoveParentStart = this.editableScreenTransform.anchors.getCenter();
            this.convertAnchorsToOffset();
        }
        else {
            if (this.isEditableDirty) {
                this.convertOffsetToAnchors();
                this.multiMoveParentTouchStart = this.editableScreenTransform.worldPointToParentPoint(worldPoint);
                this.multiMoveParentStart = this.editableScreenTransform.anchors.getCenter();
                this.convertAnchorsToOffset();
                this.isEditableDirty = false;
            }
            this.convertOffsetToAnchors();
            const parentTouchPosition = this.editableScreenTransform.worldPointToParentPoint(worldPoint);
            const delta = parentTouchPosition.sub(this.multiMoveParentTouchStart);
            this.editableScreenTransform.anchors.setCenter(this.multiMoveParentStart.add(delta));
            this.convertAnchorsToOffset();
            // this.doCallbacks();
        }
    }
    setVisualZoom(zoom) {
        var _a;
        this.sidePoints.forEach(point => point.setZoom(zoom));
        this.rotationPoints.forEach(point => point.setZoom(zoom));
        this.anchorPoints.forEach(point => point.setZoom(zoom));
        this.pivotPoint.setZoom(zoom);
        this.frameSides.forEach(frame => frame.setVisualZoom(zoom));
        (_a = this.anchorsFrame) === null || _a === void 0 ? void 0 : _a.setVisualZoom(zoom);
    }
    setVisualScale(scale) {
        var _a, _b;
        scale = this.invertScale(scale);
        this.sidePoints.forEach(point => point.setScale(scale));
        this.rotationPoints.forEach(point => point.setScale(scale));
        // this.anchorPoints.forEach(point => point.setScale(scale));
        (_a = this.pivotPoint) === null || _a === void 0 ? void 0 : _a.setScale(scale);
        this.frameSides.forEach(frame => frame.setVisualScale(scale.x, scale.y));
        (_b = this.anchorsFrame) === null || _b === void 0 ? void 0 : _b.setVisualScale(scale);
    }
    updateAnchorsFrame() {
        this.anchorsFrame.updateTransform(this.editableScreenTransform);
    }
    setAdvancedMode(isAdvanced) {
        this.isAdvancedMode = isAdvanced;
        this.updateVisualMode();
    }
    isValid() {
        return !(isNull(this.editableScreenTransform) || isNull(this.editableScreenTransform.getSceneObject())
            || isNull(this.gizmoScreenTransform) || isNull(this.gizmoScreenTransform.getSceneObject()));
    }
    setTree(tree) {
        this.tree = tree;
    }
    disableText() {
        const text = this.editable.getComponent("Component.Text");
        if (!isNull(text) && text.editable) {
            text.editable = false;
        }
    }
    updateVisualMode() {
        if (this.hasScreenRegion) {
            this.setVisualMode(GizmoMode.ScreenRegion);
        }
        else {
            this.setVisualMode(this.isAdvancedMode ? GizmoMode.Advanced : GizmoMode.Basic);
        }
        // this.setVisualMode(GizmoMode.Advanced);
    }
    setVisualMode(mode) {
        switch (mode) {
            case GizmoMode.Basic:
                this.anchorsRootSceneObject.enabled = false;
                this.anchorPointsSceneObjects.forEach(obj => obj.enabled = false);
                this.sidePointsSceneObjects.forEach(obj => obj.enabled = true);
                this.pivot.enabled = true;
                break;
            case GizmoMode.Advanced:
                this.anchorsRootSceneObject.enabled = true;
                this.anchorPointsSceneObjects.forEach(obj => obj.enabled = true);
                this.sidePointsSceneObjects.forEach(obj => obj.enabled = true);
                this.pivot.enabled = true;
                break;
            case GizmoMode.ScreenRegion:
                this.anchorsRootSceneObject.enabled = true;
                this.anchorPointsSceneObjects.forEach(obj => obj.enabled = true);
                this.sidePointsSceneObjects.forEach(obj => obj.enabled = false);
                this.pivot.enabled = false;
                break;
        }
    }
    initSidePoints() {
        this.sidePointsSceneObjects.forEach((sidePointSO) => {
            const newSidePoint = new SidePoint_1.SidePoint(sidePointSO);
            newSidePoint.setValidator(() => this.isValid());
            newSidePoint.setOnUpdate(this.processSidePointUpdate);
            this.sidePoints.push(newSidePoint);
        });
    }
    initAnchorPoints() {
        this.anchorPointsSceneObjects.forEach((anchorSceneObject) => {
            const newAnchorPoint = new AnchorPoint_1.AnchorPoint(anchorSceneObject);
            newAnchorPoint.setValidator(() => this.isValid());
            newAnchorPoint.setOnUpdate(this.processAnchorPointUpdate);
            this.anchorPoints.push(newAnchorPoint);
        });
    }
    initPivotPoint() {
        this.pivotPoint = new PivotPoint_1.PivotPoint(this.pivot);
        this.pivotPoint.setPosition(this.editableScreenTransform.pivot);
        this.pivotPoint.setValidator(() => this.isValid());
        this.pivotPoint.setOnUpdate(this.processPivotPointUpdate);
    }
    initRotationPoints() {
        this.rotationPointsSceneObjects.forEach((rotationPointSO) => {
            const newRotationPoint = new RotationPoint_1.RotationPoint(rotationPointSO);
            newRotationPoint.setValidator(() => this.isValid());
            newRotationPoint.setOnUpdate(this.processRotationPointUpdate);
            this.rotationPoints.push(newRotationPoint);
        });
    }
    initFrameSides() {
        this.frameSidesSceneObjects.forEach(obj => this.frameSides.push(new FrameSide_1.FrameSide(obj)));
    }
    initAnchorsFrame() {
        const anchorFrameSides = [];
        this.anchorFrameSidesSceneObjects.forEach(obj => anchorFrameSides.push(new FrameSide_1.FrameSide(obj)));
        this.anchorsFrame = new AnchorsFrame_1.AnchorsFrame(this.anchorsRootSceneObject.getComponent("ScreenTransform"), anchorFrameSides, this.anchorPoints);
        this.addOnUpdateCallback(() => {
            this.anchorsFrame.updateTransform(this.editableScreenTransform);
        });
    }
    align(data) {
        this.alignmentFunctions.forEach(func => func && func(data));
    }
    doCallbacks() {
        this.doOnUpdate.forEach((cb) => {
            cb && cb({ screenTransform: this.editableScreenTransform, fijiScreenTransform: this.fijiScreenTransform });
        });
    }
    invertScale(scale) {
        const res = vec3.zero();
        res.x = scale.x ? 1 / scale.x : 0;
        res.y = scale.y ? 1 / scale.y : 0;
        res.z = scale.z ? 1 / scale.z : 0;
        return res;
    }
    setupGizmoInteractions() {
        let touchMoveEventRegister;
        let touchEndEventRegister;
        const translatedTouchPosition = (eventData) => {
            return this.interactionCamera.screenSpaceToWorldSpace(eventData.position, -1);
        };
        const onTouchStart = (eventData) => {
            var _a, _b;
            if (LensRegion_1.LensRegion.isBusy || this.hasScreenRegion || !this.isValid()) {
                return;
            }
            const worldTouchPosition = translatedTouchPosition(eventData);
            let screenPosition = eventData.position;
            const camera = (_b = (_a = this.tree) === null || _a === void 0 ? void 0 : _a.getRoot()) === null || _b === void 0 ? void 0 : _b.getComponent("Camera");
            if (camera) {
                screenPosition = GizmoUtils_1.GizmoUtils.screenPointToScreenPoint(screenPosition, this.interactionCamera, camera);
            }
            Gizmo_1.isBusy = true;
            if (!this.gizmoScreenTransform.containsScreenPoint(screenPosition)) {
                Gizmo_1.isBusy = false;
                return;
            }
            Gizmo_1.ActiveGizmos.forEach((gizmo) => gizmo.processWorldDelta(worldTouchPosition, SidePoint_1.TouchEventType.STARTED));
            touchMoveEventRegister = this.gizmoInteractionComponent.onTouchMove.add(onTouchMove);
            touchEndEventRegister = this.gizmoInteractionComponent.onTouchEnd.add(onTouchEnd);
            // this.isEditableDirty = false;
        };
        const onTouchMove = (eventData) => {
            if (LensRegion_1.LensRegion.isBusy || this.hasScreenRegion || !this.isValid()) {
                this.gizmoInteractionComponent.onTouchMove.remove(touchMoveEventRegister);
                this.gizmoInteractionComponent.onTouchEnd.remove(touchEndEventRegister);
                Gizmo_1.isBusy = false;
                return;
            }
            Gizmo_1.ActiveGizmos.forEach(gizmo => gizmo.processWorldDelta(translatedTouchPosition(eventData), SidePoint_1.TouchEventType.CHANGED));
            Gizmo_1.ActiveGizmos.forEach(gizmo => gizmo.convertOffsetToAnchors());
            this.align({ screenTransform: this.editableScreenTransform, interactionType: AlignmentTypes_1.InteractionType.Move,
                extraScreenTransforms: Gizmo_1.ActiveGizmos.map(gizmo => gizmo.getEditableScreenTransform()) });
            Gizmo_1.ActiveGizmos.forEach(gizmo => gizmo.convertAnchorsToOffset());
            this.doCallbacks();
        };
        const onTouchEnd = (eventData) => {
            Gizmo_1.isBusy = false;
            if (LensRegion_1.LensRegion.isBusy || this.hasScreenRegion) {
                this.gizmoInteractionComponent.onTouchMove.remove(touchMoveEventRegister);
                this.gizmoInteractionComponent.onTouchEnd.remove(touchEndEventRegister);
                return;
            }
            Gizmo_1.ActiveGizmos.forEach(gizmo => gizmo.processWorldDelta(translatedTouchPosition(eventData), SidePoint_1.TouchEventType.ENDED));
            Gizmo_1.ActiveGizmos.forEach(gizmo => gizmo.convertOffsetToAnchors());
            this.align({ screenTransform: this.editableScreenTransform, interactionType: AlignmentTypes_1.InteractionType.Move,
                extraScreenTransforms: Gizmo_1.ActiveGizmos.map(gizmo => gizmo.getEditableScreenTransform()) });
            Gizmo_1.ActiveGizmos.forEach(gizmo => gizmo.convertAnchorsToOffset());
            this.gizmoInteractionComponent.onTouchMove.remove(touchMoveEventRegister);
            this.gizmoInteractionComponent.onTouchEnd.remove(touchEndEventRegister);
        };
        this.gizmoInteractionComponent.onTouchStart.add(onTouchStart);
        this.doCallbacks();
    }
    convertOffsetToAnchors() {
        const parentWidth = GizmoUtils_1.GizmoUtils.getParentWorldWidth(this.editableScreenTransform);
        const parentHeight = GizmoUtils_1.GizmoUtils.getParentWorldHeight(this.editableScreenTransform);
        const offsets = this.editableScreenTransform.offsets;
        const anchors = this.editableScreenTransform.anchors;
        this.saveAnchors.setCenter(anchors.getCenter());
        this.saveAnchors.setSize(anchors.getSize());
        anchors.right = anchors.right + offsets.right * 2 / parentWidth;
        anchors.left = anchors.left + offsets.left * 2 / parentWidth;
        anchors.top = anchors.top + offsets.top * 2 / parentHeight;
        anchors.bottom = anchors.bottom + offsets.bottom * 2 / parentHeight;
        offsets.right = 0;
        offsets.left = 0;
        offsets.top = 0;
        offsets.bottom = 0;
    }
    convertAnchorsToOffset() {
        var _a, _b, _c, _d, _e, _f, _g, _h;
        const parentWidth = GizmoUtils_1.GizmoUtils.getParentWorldWidth(this.editableScreenTransform);
        const parentHeight = GizmoUtils_1.GizmoUtils.getParentWorldHeight(this.editableScreenTransform);
        const offsets = this.editableScreenTransform.offsets;
        const anchors = this.editableScreenTransform.anchors;
        if (this.overrideConversion() || ((_a = this.fijiScreenTransform) === null || _a === void 0 ? void 0 : _a.constraints.pinToRight)
            || ((_b = this.fijiScreenTransform) === null || _b === void 0 ? void 0 : _b.constraints.fixedWidth) || this.isAdvancedMode) {
            offsets.right = parentWidth * (anchors.right - this.saveAnchors.right) / 2;
            anchors.right = this.saveAnchors.right;
        }
        if (this.overrideConversion() || ((_c = this.fijiScreenTransform) === null || _c === void 0 ? void 0 : _c.constraints.pinToLeft)
            || ((_d = this.fijiScreenTransform) === null || _d === void 0 ? void 0 : _d.constraints.fixedWidth) || this.isAdvancedMode) {
            offsets.left = parentWidth * (anchors.left - this.saveAnchors.left) / 2;
            anchors.left = this.saveAnchors.left;
        }
        if (this.overrideConversion() || ((_e = this.fijiScreenTransform) === null || _e === void 0 ? void 0 : _e.constraints.pinToTop)
            || ((_f = this.fijiScreenTransform) === null || _f === void 0 ? void 0 : _f.constraints.fixedHeight) || this.isAdvancedMode) {
            offsets.top = parentHeight * (anchors.top - this.saveAnchors.top) / 2;
            anchors.top = this.saveAnchors.top;
        }
        if (this.overrideConversion() || ((_g = this.fijiScreenTransform) === null || _g === void 0 ? void 0 : _g.constraints.pinToBottom)
            || ((_h = this.fijiScreenTransform) === null || _h === void 0 ? void 0 : _h.constraints.fixedHeight) || this.isAdvancedMode) {
            offsets.bottom = parentHeight * (anchors.bottom - this.saveAnchors.bottom) / 2;
            anchors.bottom = this.saveAnchors.bottom;
        }
        // if (this.overrideConversion() || !this.isAdvancedMode) {
        //     const offsetCenterInParentDistance: vec2 = offsets.getCenter();
        //     offsetCenterInParentDistance.x = offsetCenterInParentDistance.x / parentWidth * 2;
        //     offsetCenterInParentDistance.y = offsetCenterInParentDistance.y / parentHeight * 2;
        //     anchors.setCenter(anchors.getCenter().add(offsetCenterInParentDistance));
        //     offsets.setCenter(vec2.zero());
        // }
    }
    overrideConversion() {
        return !Utils_1.Utils.isEditor();
    }
    __initialize() {
        super.__initialize();
        this.EPS = 1e-3;
        this.isHidden = false;
        this.sidePoints = [];
        this.rotationPoints = [];
        this.anchorPoints = [];
        this.frameSides = [];
        this.doOnUpdate = [];
        this.hasScreenRegion = false;
        this.isAdvancedMode = false;
        this.isEditableDirty = true;
        this.saveAnchors = Rect.create(0, 0, 0, 0);
        this.saveAspect = 1;
        this.multiMoveParentStart = vec2.zero();
        this.multiMoveParentTouchStart = vec2.zero();
        this.alignmentFunctions = [];
        this.onAwake = () => {
            this.resetEditable();
            this.gizmoSceneObject = this.getSceneObject();
            this.gizmoScreenTransform = this.gizmoSceneObject.getComponent("ScreenTransform");
            this.gizmoInteractionComponent = this.gizmoSceneObject.getComponent("InteractionComponent");
            this.gizmoInteractionComponent.isFilteredByDepth = true;
            this.createEvent("OnDestroyEvent").bind(() => {
                this.gizmoSceneObject = null;
                this.editable = null;
                this.editableScreenTransform = null;
                this.mouseHint.hide();
            });
        };
        this.processAnchorPointUpdate = (eventData) => {
            if (LensRegion_1.LensRegion.isBusy || this.hasScreenRegion || !this.isValid()) {
                return;
            }
            const parentWidth = GizmoUtils_1.GizmoUtils.getParentWorldWidth(this.editableScreenTransform);
            const parentHeight = GizmoUtils_1.GizmoUtils.getParentWorldHeight(this.editableScreenTransform);
            const anchors = this.editableScreenTransform.anchors;
            const offsets = this.editableScreenTransform.offsets;
            const parentPoint = this.editableScreenTransform.worldPointToParentPoint(eventData.worldPosition);
            if (eventData.sidePointOffset.x > this.EPS) { // RIGHT
                parentPoint.x = Math.min(Math.max(anchors.left, parentPoint.x), 1);
                const parentDiff = parentPoint.x - anchors.right;
                anchors.right = parentPoint.x;
                offsets.right = offsets.right - parentDiff * parentWidth / 2;
            }
            if (eventData.sidePointOffset.x < -this.EPS) { // LEFT
                parentPoint.x = Math.max(Math.min(anchors.right, parentPoint.x), -1);
                const parentDiff = parentPoint.x - anchors.left;
                anchors.left = parentPoint.x;
                offsets.left = offsets.left - parentDiff * parentWidth / 2;
            }
            if (eventData.sidePointOffset.y > this.EPS) { // TOP
                parentPoint.y = Math.min(Math.max(anchors.bottom, parentPoint.y), 1);
                const parentDiff = parentPoint.y - anchors.top;
                anchors.top = parentPoint.y;
                offsets.top = offsets.top - parentDiff * parentHeight / 2;
            }
            if (eventData.sidePointOffset.y < -this.EPS) { // BOTTOM
                parentPoint.y = Math.max(Math.min(anchors.top, parentPoint.y, 1), -1);
                const parentDiff = parentPoint.y - anchors.bottom;
                anchors.bottom = parentPoint.y;
                offsets.bottom = offsets.bottom - parentDiff * parentHeight / 2;
            }
            this.doCallbacks();
        };
        this.processRotationPointUpdate = (eventData) => {
            if (LensRegion_1.LensRegion.isBusy || this.hasScreenRegion || !this.isValid()) {
                return;
            }
            const pivot = this.editableScreenTransform.localPointToWorldPoint(this.editableScreenTransform.pivot);
            eventData.worldPosition.z = pivot.z;
            const worldTouchPosition = eventData.worldPosition;
            const vecToTouchPosition = worldTouchPosition.sub(pivot);
            const vecToTouchPerpendicular = GizmoUtils_1.GizmoUtils.getPerpendicularVec3(vecToTouchPosition);
            const rotation = this.editableScreenTransform.rotation;
            this.editableScreenTransform.rotation = quat.quatIdentity();
            const corner = this.editableScreenTransform.localPointToWorldPoint(eventData.sidePointOffset);
            const vecToCorner = corner.sub(pivot);
            const editableRotationEuler = rotation.toEulerAngles();
            let angleRad = vecToCorner.angleTo(vecToTouchPosition);
            if (vecToCorner.dot(vecToTouchPerpendicular) > 0) {
                angleRad = 2 * Math.PI - angleRad;
            }
            const roundedAngle = GizmoUtils_1.GizmoUtils.roundAngleToDegrees(angleRad * 180 / Math.PI, 
            //@ts-ignore
            KeyboardListener_1.KeyboardListener.isKeyPressed(Keys.Key_Shift) ? 15 : 1) / 180 * Math.PI;
            editableRotationEuler.z = roundedAngle;
            this.mouseHint.setRoundness(0.25);
            this.mouseHint.enableStroke(false);
            this.mouseHint.setText(("000" + Math.round(roundedAngle * 180 / Math.PI)).slice(-3) + "°");
            this.mouseHint.updateFromMousePosition(eventData.screenPosition);
            if (eventData.touchEventType === SidePoint_1.TouchEventType.CHANGED) {
                this.mouseHint.show();
            }
            else if (eventData.touchEventType === SidePoint_1.TouchEventType.ENDED) {
                this.mouseHint.hide();
            }
            this.editableScreenTransform.rotation = quat.fromEulerVec(editableRotationEuler);
            this.align({ screenTransform: this.editableScreenTransform, interactionType: AlignmentTypes_1.InteractionType.Rotation });
            this.doCallbacks();
        };
        this.processPivotPointUpdate = (eventData) => {
            if (LensRegion_1.LensRegion.isBusy || this.hasScreenRegion || !this.isValid()) {
                return;
            }
            const localTouchPosition = this.editableScreenTransform.worldPointToLocalPoint(eventData.worldPosition);
            this.convertOffsetToAnchors();
            GizmoUtils_1.GizmoUtils.setPivotPreservePosition(this.editableScreenTransform, localTouchPosition);
            this.align({ screenTransform: this.editableScreenTransform, interactionType: AlignmentTypes_1.InteractionType.Pivot });
            this.pivotPoint.setPosition(this.editableScreenTransform.pivot);
            this.convertAnchorsToOffset();
            this.doCallbacks();
        };
        this.processSidePointUpdate = (eventData) => {
            if (LensRegion_1.LensRegion.isBusy || this.hasScreenRegion || !this.isValid()) {
                return;
            }
            const savePivot = this.editableScreenTransform.pivot;
            let worldPivot = this.editableScreenTransform.localPointToWorldPoint(savePivot);
            //Adjust for scale
            let diff = eventData.worldPosition.sub(worldPivot);
            diff = this.editableScreenTransform.rotation.invert().multiplyVec3(diff);
            const scale = this.editableScreenTransform.getTransform().getWorldScale();
            diff.x = diff.x * (Math.abs(scale.x) > this.EPS ? 1 / scale.x : 0);
            diff.y = diff.y * (Math.abs(scale.y) > this.EPS ? 1 / scale.y : 0);
            diff.z = diff.z * (Math.abs(scale.z) > this.EPS ? 1 / scale.z : 0);
            diff = this.editableScreenTransform.rotation.multiplyVec3(diff);
            eventData.worldPosition = worldPivot.add(diff);
            eventData.worldPosition.z = worldPivot.z;
            eventData.worldPosition = GizmoUtils_1.GizmoUtils.rotateVec3z(eventData.worldPosition.sub(worldPivot), -this.editableScreenTransform.rotation.toEulerAngles().z);
            eventData.worldPosition = eventData.worldPosition.add(worldPivot);
            const parentTouchPosition = this.editableScreenTransform.worldPointToParentPoint(eventData.worldPosition);
            this.convertOffsetToAnchors();
            const anchors = this.editableScreenTransform.anchors;
            const topRight = new vec2(this.editableScreenTransform.anchors.top, this.editableScreenTransform.anchors.right);
            const leftBottom = new vec2(this.editableScreenTransform.anchors.left, this.editableScreenTransform.anchors.bottom);
            let delta = vec2.one();
            if (eventData.sidePointOffset.x > this.EPS) {
                topRight.y = parentTouchPosition.x;
                delta.x *= -1;
            }
            else if (eventData.sidePointOffset.x < -this.EPS) {
                leftBottom.x = parentTouchPosition.x;
            }
            if (eventData.sidePointOffset.y > this.EPS) {
                topRight.x = parentTouchPosition.y;
                delta.y *= -1;
            }
            else if (eventData.sidePointOffset.y < -this.EPS) {
                leftBottom.y = parentTouchPosition.y;
            }
            GizmoUtils_1.GizmoUtils.setPivotPreservePosition(this.editableScreenTransform, eventData.sidePointOffset.uniformScale(-1));
            const oldSize = anchors.getSize();
            if (eventData.touchEventType === SidePoint_1.TouchEventType.STARTED) {
                this.saveAspect = oldSize.x / oldSize.y;
            }
            const newSize = new vec2(topRight.y - leftBottom.x, topRight.x - leftBottom.y);
            if (Math.abs(eventData.sidePointOffset.x) > this.EPS
                && Math.abs(eventData.sidePointOffset.y) > this.EPS
                //@ts-ignore
                && KeyboardListener_1.KeyboardListener.isKeyPressed(Keys.Key_Shift)) {
                if (newSize.x / newSize.y > this.saveAspect) {
                    newSize.x = newSize.y * this.saveAspect;
                }
                else {
                    newSize.y = newSize.x / this.saveAspect;
                }
            }
            delta = delta.mult(oldSize.sub(newSize));
            anchors.setSize(newSize);
            anchors.setCenter(anchors.getCenter().add(delta.uniformScale(0.5)));
            GizmoUtils_1.GizmoUtils.setPivotPreservePosition(this.editableScreenTransform, savePivot);
            this.align({ screenTransform: this.editableScreenTransform, interactionType: AlignmentTypes_1.InteractionType.Scale,
                direction: eventData.sidePointOffset });
            this.convertAnchorsToOffset();
            this.doCallbacks();
        };
    }
};
exports.Gizmo = Gizmo;
Gizmo.ActiveGizmos = [];
Gizmo.isBusy = false;
exports.Gizmo = Gizmo = Gizmo_1 = __decorate([
    component
], Gizmo);
//# sourceMappingURL=Gizmo.js.map