"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.FrameUpdateRequestMessage = void 0;
const BaseMessage_1 = require("./BaseMessage");
class FrameUpdateRequestMessage extends BaseMessage_1.BaseMessage {
    constructor() {
        super(...arguments);
        this.timestamp = 0;
    }
}
exports.FrameUpdateRequestMessage = FrameUpdateRequestMessage;
//# sourceMappingURL=FrameUpdateRequestMessage.js.map