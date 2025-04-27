"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.GizmoPool = void 0;
const Gizmo_1 = require("./Gizmo/Gizmo");
const Utils_1 = require("./Utils");
class GizmoPool {
    constructor(gizmoRef, poolSize, tree) {
        this.gizmoRef = gizmoRef;
        this.poolSize = poolSize;
        this.tree = tree;
        this.pool = [];
        this.visualZoom = 1;
        this.layer = null;
        this.camera = null;
        this.alignmentFunctions = [];
        this.onUpdateFunctions = [];
        this.activeScreenTransforms = [];
        //@ts-ignore
        this.activeFijiScreenTransforms = [];
        this.activeGizmos = [];
        this.gizmoRef.hide();
        this.sceneObject = this.gizmoRef.getSceneObject();
        this.root = this.sceneObject.getParent();
        for (let i = 0; i < poolSize; i++) {
            this.spawnNewGizmo();
        }
    }
    //@ts-ignore
    createFromObjects(objects, fijiObjects) {
        this.destroyActiveGizmos();
        objects.forEach((obj, idx) => {
            this.activeGizmos.push(this.setupGizmo(this.getNewGizmo(), obj, fijiObjects[idx]));
        });
        this.updateActiveGizmos();
        this.activeGizmos.forEach(gizmo => {
            this.activeScreenTransforms.push(gizmo.getEditableScreenTransform());
            this.activeFijiScreenTransforms.push(gizmo.getFijiScreenTransform());
        });
        Gizmo_1.Gizmo.ActiveGizmos = this.filterOutDependentGizmos(this.activeGizmos);
    }
    getActiveScreenTransforms() {
        return this.activeScreenTransforms;
    }
    //@ts-ignore
    getActiveFijiScreenTransforms() {
        return this.activeFijiScreenTransforms;
    }
    getScreenTransformByWorldPoint(point) {
        let result = null;
        let closestPosition = 0;
        for (let i = 0; i < this.activeGizmos.length; i++) {
            if (this.activeGizmos[i].containsWorldPoint(point)) {
                const pos = this.activeScreenTransforms[i].getTransform().getWorldPosition().z;
                if (!result || closestPosition > pos) {
                    result = this.activeScreenTransforms[i];
                    closestPosition = pos;
                }
            }
        }
        return result;
    }
    getScreenTransformByScreenPoint(point) {
        let result = null;
        let closestPosition = 0;
        for (let i = 0; i < this.activeGizmos.length; i++) {
            if (this.activeGizmos[i].containsScreenPoint(point)) {
                const pos = this.activeScreenTransforms[i].getTransform().getWorldPosition().z;
                if (!result || closestPosition > pos) {
                    result = this.activeScreenTransforms[i];
                    closestPosition = pos;
                }
            }
        }
        return result;
    }
    getActiveGizmos() {
        return this.activeGizmos;
    }
    addAlignmentFunction(alignmentFunction) {
        this.alignmentFunctions.push(alignmentFunction);
        this.activeGizmos.forEach(gizmo => gizmo.addAlignmentFunction(alignmentFunction));
    }
    addOnUpdateCallback(callback) {
        this.onUpdateFunctions.push(callback);
        this.activeGizmos.forEach(gizmo => gizmo.addOnUpdateCallback(callback));
    }
    setVisualZoom(value) {
        this.visualZoom = value;
        this.activeGizmos.forEach(gizmo => gizmo.setVisualZoom(value));
    }
    setLayer(layer) {
        this.layer = layer;
        this.activeGizmos.forEach(gizmo => gizmo.setLayer(layer));
    }
    setInteractionCamera(camera) {
        this.camera = camera;
        this.activeGizmos.forEach(gizmo => gizmo.setInteractionCamera(camera));
    }
    // There are some properties that need to be checked manually. That's what this method does
    updateActiveGizmos() {
        this.activeGizmos.forEach(gizmo => {
            gizmo.updatePivot();
            gizmo.updateAdvancedMode();
            gizmo.updateVisualScale();
            gizmo.updateAnchorsFrame();
            gizmo.setLayer(this.layer);
        });
    }
    callForceUpdateForActiveGizmos() {
        this.activeGizmos.forEach(gizmo => gizmo.forceUpdate());
    }
    destroyActiveGizmos() {
        Gizmo_1.Gizmo.ActiveGizmos = [];
        this.activeGizmos.forEach(gizmo => !isNull(gizmo) && gizmo.getSceneObject().destroy());
        this.activeGizmos = [];
        this.activeScreenTransforms = [];
        this.activeFijiScreenTransforms = [];
    }
    isValid() {
        for (let i = 0; i < this.activeGizmos.length; i++) {
            if (isNull(this.activeGizmos[i]) || !this.activeGizmos[i].isValid()) {
                return false;
            }
        }
        return true;
    }
    isEmpty() {
        return !this.activeGizmos.length;
    }
    isVisible() {
        return this.activeGizmos.length ? this.activeGizmos[0].isVisible() : false;
    }
    size() {
        return this.activeGizmos.length;
    }
    show() {
        this.activeGizmos.forEach(gizmo => gizmo.show());
    }
    hide() {
        this.activeGizmos.forEach(gizmo => gizmo.hide());
    }
    has(screenTransform) {
        for (let i = 0; i < this.activeScreenTransforms.length; i++) {
            if (this.activeScreenTransforms[i].uniqueIdentifier === screenTransform.uniqueIdentifier) {
                return true;
            }
        }
        return false;
    }
    isSame(sceneObjects) {
        var _a, _b;
        if (this.activeScreenTransforms.length !== sceneObjects.length) {
            return false;
        }
        for (let i = 0; i < this.activeScreenTransforms.length; i++) {
            if (((_a = this.activeScreenTransforms[i]) === null || _a === void 0 ? void 0 : _a.uniqueIdentifier) !== ((_b = sceneObjects[i]) === null || _b === void 0 ? void 0 : _b.uniqueIdentifier)) {
                return false;
            }
        }
        return true;
    }
    filterOutDependentGizmos(gizmos) {
        const result = [];
        for (let i = 0; i < gizmos.length; i++) {
            let skip = false;
            for (let j = 0; j < gizmos.length; j++) {
                if (i == j) {
                    continue;
                }
                if (this.tree.isInHierarchy(gizmos[j].getEditable(), gizmos[i].getEditable())) {
                    skip = true;
                    break;
                }
            }
            if (!skip) {
                result.push(gizmos[i]);
            }
        }
        return result;
    }
    getNewGizmo() {
        this.spawnNewGizmo();
        const gizmo = this.pool.pop();
        gizmo.init();
        return gizmo;
    }
    //@ts-ignore
    setupGizmo(gizmo, object, fijiObject) {
        gizmo.setEditable(object);
        gizmo.setTree(this.tree);
        //@ts-ignore
        gizmo.setFijiScreenTransform(fijiObject.getComponent("ScreenTransform"));
        this.alignmentFunctions.forEach(alignmentFunc => gizmo.addAlignmentFunction(alignmentFunc));
        this.onUpdateFunctions.forEach(onUpdateFunc => gizmo.addOnUpdateCallback(onUpdateFunc));
        gizmo.updateAdvancedMode();
        gizmo.setVisualZoom(this.visualZoom);
        this.camera && gizmo.setInteractionCamera(this.camera);
        this.layer && gizmo.setLayer(this.layer);
        return gizmo;
    }
    spawnNewGizmo() {
        const newGizmoObject = this.root.copyWholeHierarchyAndAssets(this.sceneObject);
        const newGizmo = newGizmoObject.getComponent("ScriptComponent");
        newGizmo.setLayer(Utils_1.Utils.SYSTEM_LAYER);
        newGizmo.hide();
        this.pool.push(newGizmo);
    }
}
exports.GizmoPool = GizmoPool;
//# sourceMappingURL=GizmoPool.js.map