"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var CursorIcons_1;
Object.defineProperty(exports, "__esModule", { value: true });
exports.CursorIcons = void 0;
var __selfType = requireType("./CursorIcons");
function component(target) { target.getTypeName = function () { return __selfType; }; }
let CursorIcons = CursorIcons_1 = class CursorIcons extends BaseScriptComponent {
    onAwake() {
        CursorIcons_1.macIconTextures = this.macIconTexturesInput;
        CursorIcons_1.winIconTextures = this.winIconTexturesInput;
    }
};
exports.CursorIcons = CursorIcons;
CursorIcons.macIconTextures = [];
CursorIcons.winIconTextures = [];
exports.CursorIcons = CursorIcons = CursorIcons_1 = __decorate([
    component
], CursorIcons);
//# sourceMappingURL=CursorIcons.js.map