"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.CallScheduler = void 0;
class CallScheduler {
    constructor(script, eventType) {
        this.call = null;
        this.event = script.createEvent(eventType);
        this.event.bind(() => {
            this.call && this.call();
            this.call = null;
        });
    }
    scheduleCall(call) {
        this.call = call;
    }
}
exports.CallScheduler = CallScheduler;
//# sourceMappingURL=CallScheduler.js.map