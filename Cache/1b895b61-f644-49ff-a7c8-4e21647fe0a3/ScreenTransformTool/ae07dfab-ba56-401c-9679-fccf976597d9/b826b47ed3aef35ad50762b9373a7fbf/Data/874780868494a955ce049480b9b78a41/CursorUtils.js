"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.CursorUtils = void 0;
var CursorUtils;
(function (CursorUtils) {
    function isEditor() {
        //@ts-ignore
        return typeof Editor !== 'undefined';
    }
    CursorUtils.isEditor = isEditor;
    function radToDeg(angle) {
        return angle * 180 / Math.PI;
    }
    CursorUtils.radToDeg = radToDeg;
    function degToRad(angle) {
        return angle * Math.PI / 180;
    }
    CursorUtils.degToRad = degToRad;
})(CursorUtils || (exports.CursorUtils = CursorUtils = {}));
//# sourceMappingURL=CursorUtils.js.map