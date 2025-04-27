"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var SharedContent_1;
Object.defineProperty(exports, "__esModule", { value: true });
exports.SharedContent = void 0;
var __selfType = requireType("./SharedContent");
function component(target) { target.getTypeName = function () { return __selfType; }; }
let SharedContent = SharedContent_1 = class SharedContent extends BaseScriptComponent {
    static getInstance() {
        return this.instance;
    }
    onAwake() {
        SharedContent_1.instance = this;
    }
};
exports.SharedContent = SharedContent;
exports.SharedContent = SharedContent = SharedContent_1 = __decorate([
    component
], SharedContent);
//# sourceMappingURL=SharedContent.js.map