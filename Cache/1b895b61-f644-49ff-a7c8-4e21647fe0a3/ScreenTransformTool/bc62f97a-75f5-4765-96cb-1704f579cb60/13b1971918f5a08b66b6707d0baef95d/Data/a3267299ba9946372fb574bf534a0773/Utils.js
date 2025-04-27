"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Utils = void 0;
const SharedContent_1 = require("../Shared/SharedContent");
var Utils;
(function (Utils) {
    Utils.SYSTEM_LAYER = LayerSet.makeUnique();
    function isEditor() {
        //@ts-ignore
        return typeof Editor !== 'undefined';
    }
    Utils.isEditor = isEditor;
    function screenSpaceToWorldSpace(pos) {
        return SharedContent_1.SharedContent.getInstance().orthoCamera.screenSpaceToWorldSpace(pos, 0);
    }
    Utils.screenSpaceToWorldSpace = screenSpaceToWorldSpace;
    function vec4ToRect(vec) {
        return Rect.create(vec.x, vec.y, vec.z, vec.w);
    }
    Utils.vec4ToRect = vec4ToRect;
    function sign(val) {
        if (val > 0) {
            return 1;
        }
        if (val < 0) {
            return -1;
        }
        return 0;
    }
    Utils.sign = sign;
    function performOnHierarchy(root, func) {
        const res = func(root);
        if (!res) {
            return;
        }
        root.children.forEach(child => performOnHierarchy(child, func));
    }
    Utils.performOnHierarchy = performOnHierarchy;
    function getPass(obj) {
        var _a, _b;
        return ((_a = obj.getComponent("Image")) === null || _a === void 0 ? void 0 : _a.mainPass) || ((_b = obj.getComponent("MeshVisual")) === null || _b === void 0 ? void 0 : _b.mainPass);
    }
    Utils.getPass = getPass;
    function setAlpha(obj, alpha) {
        const textComponent = obj.getComponent("Text");
        if (textComponent) {
            const fill = textComponent.textFill;
            const color = fill.color;
            color.a = alpha;
            fill.color = color;
            textComponent.textFill = fill;
        }
        const pass = getPass(obj);
        if (pass && pass.baseColor) {
            const color = pass.baseColor;
            color.a = alpha;
            pass.baseColor = color;
        }
    }
    Utils.setAlpha = setAlpha;
    function setAlphaForHierarchy(root, alpha) {
        performOnHierarchy(root, obj => {
            setAlpha(obj, alpha);
            return true;
        });
    }
    Utils.setAlphaForHierarchy = setAlphaForHierarchy;
    function forceUpdateCamera(camera) {
        camera.getViewProjectionMatrix();
    }
    Utils.forceUpdateCamera = forceUpdateCamera;
    function delay(script, func, time) {
        const event = script.createEvent("DelayedCallbackEvent");
        event.bind(func);
        event.reset(time);
    }
    Utils.delay = delay;
})(Utils || (exports.Utils = Utils = {}));
//# sourceMappingURL=Utils.js.map