"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.ObjectConverter = void 0;
const GizmoUtils_1 = require("./Gizmo/GizmoUtils");
const Utils_1 = require("./Utils");
class ObjectConverter {
    constructor() {
        //@ts-ignore
        this.uuidToObj = {}; // LensStudio
        this.uniqueIdentifierToObj = {}; // LensCore
    }
    hasLensCoreObject(sceneObject) {
        return !!this.uniqueIdentifierToObj[sceneObject.uniqueIdentifier];
    }
    //@ts-ignore
    hasLensStudioObject(sceneObject) {
        return !!this.uuidToObj[sceneObject.id.toString()];
    }
    //@ts-ignore
    addUUID(sceneObject) {
        this.uuidToObj[sceneObject.id.toString()] = sceneObject;
    }
    addUniqueIdentifier(sceneObject) {
        this.uniqueIdentifierToObj[sceneObject.uniqueIdentifier] = sceneObject;
    }
    //@ts-ignore
    convertToLensStudioObject(sceneObject) {
        //@ts-ignore
        const uuid = Editor.Engine.idFromUniqueIdentifier(sceneObject.uniqueIdentifier).toString();
        return this.uuidToObj[uuid];
    }
    //@ts-ignore
    convertToLensCoreObject(sceneObject) {
        const uniqueIdentifier = sceneObject.id.toString();
        return this.uniqueIdentifierToObj[uniqueIdentifier];
    }
    addLensCoreHierarchy(root) {
        if (root.layer.contains(GizmoUtils_1.GizmoUtils.GIZMO_LAYER) || root.layer.contains(Utils_1.Utils.SYSTEM_LAYER)) {
            return;
        }
        this.addUniqueIdentifier(root);
        const childrenCount = root.getChildrenCount();
        for (let i = 0; i < childrenCount; i++) {
            this.addLensCoreHierarchy(root.getChild(i));
        }
    }
    //@ts-ignore
    addLensStudioHierarchy(root) {
        if (!root) {
            return;
        }
        this.addUUID(root);
        root.children.forEach((child) => {
            this.addLensStudioHierarchy(child);
        });
    }
    collectLensCoreObjects(rule) {
        const result = [];
        for (let key in this.uniqueIdentifierToObj) {
            const object = this.uniqueIdentifierToObj[key];
            if (rule(object)) {
                result.push(object);
            }
        }
        return result;
    }
    reset() {
        this.uuidToObj = {};
        this.uniqueIdentifierToObj = {};
    }
}
exports.ObjectConverter = ObjectConverter;
//# sourceMappingURL=ObjectConverter.js.map