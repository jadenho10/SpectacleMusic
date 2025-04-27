"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.ToolbarButtons = void 0;
var __selfType = requireType("./ToolbarButtons");
function component(target) { target.getTypeName = function () { return __selfType; }; }
const MessageCenter_1 = require("./MessageCenter/MessageCenter");
const ScreenTransformMessages_1 = require("./MessageCenter/MessageTypes/ScreenTransformMessages");
const Config_1 = require("./Config");
let ToolbarButtons = class ToolbarButtons extends BaseScriptComponent {
    onAwake() {
        MessageCenter_1.MessageCenter.instance.subscribe(ScreenTransformMessages_1.SnappingButtonMessage, (message) => {
            //@ts-ignore
            Config_1.Config.isSnappingEnabled.value = message.checked;
        });
        MessageCenter_1.MessageCenter.instance.subscribe(ScreenTransformMessages_1.RulersButtonMessage, (message) => {
            //@ts-ignore
            Config_1.Config.isRulerEnabled.value = message.checked;
        });
        MessageCenter_1.MessageCenter.instance.subscribe(ScreenTransformMessages_1.GuidesButtonMessage, (message) => {
            //@ts-ignore
            Config_1.Config.isGuideEnabled.value = message.checked;
        });
        MessageCenter_1.MessageCenter.instance.subscribe(ScreenTransformMessages_1.SnappingToGuidesButtonMessage, (message) => {
            //@ts-ignore
            Config_1.Config.isSnappingToGuideEnabled.value = message.checked;
        });
        MessageCenter_1.MessageCenter.instance.subscribe(ScreenTransformMessages_1.ResetButtonMessage, (message) => {
            this.main.getLensRegion().resetPosition();
            this.main.getLensRegion().resetScale();
        });
    }
};
exports.ToolbarButtons = ToolbarButtons;
exports.ToolbarButtons = ToolbarButtons = __decorate([
    component
], ToolbarButtons);
//# sourceMappingURL=ToolbarButtons.js.map