"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.FrameUpdatedMessage = void 0;
const BaseMessage_1 = require("./BaseMessage");
class FrameUpdatedMessage extends BaseMessage_1.BaseMessage {
    constructor() {
        super(...arguments);
        this.timestamp = 0;
    }
}
exports.FrameUpdatedMessage = FrameUpdatedMessage;
//# sourceMappingURL=FrameUpdatedMessage.js.map