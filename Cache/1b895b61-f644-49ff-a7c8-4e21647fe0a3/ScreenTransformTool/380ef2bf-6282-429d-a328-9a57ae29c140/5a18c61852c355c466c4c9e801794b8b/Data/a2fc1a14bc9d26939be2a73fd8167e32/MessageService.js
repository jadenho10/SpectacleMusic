"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.MessageService = void 0;
var __selfType = requireType("./MessageService");
function component(target) { target.getTypeName = function () { return __selfType; }; }
const Utils_1 = require("../Utils");
const MessageCenter_1 = require("./MessageCenter");
const FrameUpdatedMessage_1 = require("./MessageTypes/FrameUpdatedMessage");
const FrameUpdateRequestMessage_1 = require("./MessageTypes/FrameUpdateRequestMessage");
let MessageService = class MessageService extends BaseScriptComponent {
    onAwake() {
        if (Utils_1.Utils.isEditor()) {
            //@ts-ignore
            this.createEvent("MessageEvent").bind((event) => {
                MessageCenter_1.MessageCenter.instance.process(event.data);
            });
        }
        MessageCenter_1.MessageCenter.instance.subscribe(FrameUpdateRequestMessage_1.FrameUpdateRequestMessage, (message) => {
            //@ts-ignore
            Editor.context.postMessage(FrameUpdatedMessage_1.FrameUpdatedMessage.create({
                timestamp: getTime()
            }));
        });
    }
};
exports.MessageService = MessageService;
exports.MessageService = MessageService = __decorate([
    component
], MessageService);
//# sourceMappingURL=MessageService.js.map