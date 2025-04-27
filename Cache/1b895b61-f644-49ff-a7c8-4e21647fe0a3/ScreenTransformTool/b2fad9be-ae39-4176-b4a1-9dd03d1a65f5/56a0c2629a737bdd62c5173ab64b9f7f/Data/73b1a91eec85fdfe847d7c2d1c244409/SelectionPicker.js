"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.SelectionPicker = void 0;
const Utils_1 = require("./Utils");
const GizmoUtils_1 = require("./Gizmo/GizmoUtils");
const LensRegion_1 = require("../Common/Utilities/LensRegion/LensRegion");
const Gizmo_1 = require("./Gizmo/Gizmo");
const KeyboardListener_1 = require("./KeyboardListener");
class SelectionPicker {
    constructor(script, tree, camera, selectionListener, excludeObjects, gizmoPool) {
        this.script = script;
        this.tree = tree;
        this.camera = camera;
        this.selectionListener = selectionListener;
        this.excludeObjects = excludeObjects;
        this.gizmoPool = gizmoPool;
        this.objects = [];
        this.screenTransforms = [];
        this.reset();
        this.setupInteractions();
    }
    reset() {
        this.objects = this.tree.collectObjects();
        this.screenTransforms = [];
        this.objects.forEach(obj => {
            const component = obj.getComponent("ScreenTransform");
            const region = obj.getComponent("ScreenRegionComponent");
            if (component && !region) {
                this.screenTransforms.push(component);
            }
        });
    }
    setCamera(camera) {
        this.camera = camera;
    }
    updateSelection(sceneObject) {
        if (!Utils_1.Utils.isEditor()) {
            this.tree.selectObjects([sceneObject]);
            return;
        }
        if (!sceneObject) {
            //@ts-ignore
            Editor.context.selection.clear();
            return;
        }
        //@ts-ignore
        const fijiSceneObject = this.tree.convertSceneObject(sceneObject);
        if (!fijiSceneObject) {
            //SceneUtils.printHierarchyFromRoot(sceneObject);
        }
        //@ts-ignore
        Editor.context.selection.set([fijiSceneObject]);
    }
    addOrRemoveSelectedObject(sceneObject) {
        if (!sceneObject) {
            return;
        }
        //@ts-ignore
        const fijiSceneObject = this.tree.convertSceneObject(sceneObject);
        if (!fijiSceneObject) {
            return;
        }
        //@ts-ignore
        const selection = Editor.context.selection.sceneObjects;
        let findIndex = -1;
        selection.forEach((obj, idx) => {
            if (obj.id.toString() === fijiSceneObject.id.toString()) {
                findIndex = idx;
            }
        });
        if (findIndex !== -1) {
            selection.splice(findIndex, 1);
        }
        else {
            selection.push(fijiSceneObject);
        }
        //@ts-ignore
        Editor.context.selection.set(selection);
    }
    getTouchedScreenTransform(screenPosition, ignoreGizmo = false) {
        // if (isNull(this.gizmo) || isNull(this.gizmo.getEditableScreenTransform())) {
        //     this.gizmo = null;
        // }
        const refCamera = isNull(this.tree.getRoot()) ? null : this.tree.getRoot().getComponent("Camera");
        if (refCamera) {
            screenPosition = GizmoUtils_1.GizmoUtils.screenPointToScreenPoint(screenPosition, this.camera, refCamera);
        }
        if (!ignoreGizmo) {
            const screenTransform = this.gizmoPool.getScreenTransformByScreenPoint(screenPosition);
            if (screenTransform) {
                return screenTransform;
            }
        }
        const gizmo = this.gizmoPool.size() ? this.gizmoPool.getActiveGizmos()[0] : null;
        let closestPosition = 0;
        let closesScreenTransform = null;
        let isChild = false;
        this.screenTransforms.forEach((screenTransform, idx) => {
            if (isNull(screenTransform) || isNull(screenTransform.getSceneObject()) || !screenTransform.containsScreenPoint(screenPosition) ||
                ((gizmo === null || gizmo === void 0 ? void 0 : gizmo.isVisible()) &&
                    screenTransform.uniqueIdentifier === (gizmo === null || gizmo === void 0 ? void 0 : gizmo.getEditableScreenTransform().uniqueIdentifier))) {
                return;
            }
            const pos = screenTransform.getTransform().getWorldPosition().z;
            if (!closesScreenTransform || closestPosition > pos || (closestPosition === pos && !isChild)) {
                closestPosition = pos;
                closesScreenTransform = screenTransform;
                if (gizmo && !isNull(gizmo.getEditableScreenTransform())) {
                    isChild = this.tree.isInHierarchy(gizmo.getEditableScreenTransform().getSceneObject(), screenTransform.getSceneObject());
                }
            }
        });
        return closesScreenTransform;
    }
    valid() {
        try {
            for (let i = 0; i < this.screenTransforms.length; i++) {
                if (isNull(this.screenTransforms[i]) || isNull(this.screenTransforms[i].getSceneObject())) {
                    return false;
                }
            }
        }
        catch (e) {
            return false;
        }
        return true;
    }
    setupInteractions() {
        this.script.updatePriority = this.script.updatePriority - 1;
        const touchStartEvent = this.script.createEvent("TouchStartEvent");
        const touchMoveEvent = this.script.createEvent("TouchMoveEvent");
        const touchEndEvent = this.script.createEvent("TouchEndEvent");
        const onTouchStart = (eventData) => {
            if (LensRegion_1.LensRegion.isBusy || Gizmo_1.Gizmo.isBusy
                || this.excludeObjects.some(obj => obj.containsScreenPoint(eventData.getTouchPosition()))) {
                return;
            }
            if (!this.valid()) {
                this.selectionListener.forceCallSelectionUpdate();
                this.reset();
                return;
            }
            this.selectionListener.forceUpdate();
            const closestScreenTransform = this.getTouchedScreenTransform(eventData.getTouchPosition());
            if (closestScreenTransform) {
                //@ts-ignore
                if (KeyboardListener_1.KeyboardListener.isKeyPressed(Keys.Key_Control)) {
                    this.addOrRemoveSelectedObject(closestScreenTransform.getSceneObject());
                    return;
                }
                const isNewObjectPicked = !this.gizmoPool.has(closestScreenTransform);
                if (isNewObjectPicked) {
                    this.updateSelection(closestScreenTransform.getSceneObject());
                    return;
                }
            }
            else {
                this.updateSelection(null);
                return;
            }
            touchMoveEvent.enabled = true;
            touchEndEvent.enabled = true;
        };
        const onTouchMove = (eventData) => {
            touchMoveEvent.enabled = false;
            touchEndEvent.enabled = false;
        };
        const onTouchEnd = (eventData) => {
            const closestScreenTransform = this.getTouchedScreenTransform(eventData.getTouchPosition(), this.gizmoPool.size() < 2);
            if (closestScreenTransform) {
                this.updateSelection(closestScreenTransform.getSceneObject());
            }
            touchMoveEvent.enabled = false;
            touchEndEvent.enabled = false;
        };
        touchStartEvent.bind(onTouchStart);
        touchMoveEvent.bind(onTouchMove);
        touchEndEvent.bind(onTouchEnd);
        touchMoveEvent.enabled = false;
        touchEndEvent.enabled = false;
    }
}
exports.SelectionPicker = SelectionPicker;
//# sourceMappingURL=SelectionPicker.js.map