"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.MessageCenter = void 0;
class MessageCenter {
    static get instance() {
        if (!this._instance) {
            this._instance = new MessageCenter();
        }
        return this._instance;
    }
    constructor() {
        this.registeredMessageTypes = {};
        this.registeredCallbacks = {};
    }
    subscribe(messageType, callback) {
        if (!this.registeredMessageTypes[messageType.name]) {
            this.registeredMessageTypes[messageType.name] = messageType;
            this.registeredCallbacks[messageType.name] = [];
        }
        this.registeredCallbacks[messageType.name].push(callback);
    }
    notify(message) {
        if (!this.registeredMessageTypes[message.constructor.name]) {
            return;
        }
        this.registeredCallbacks[message.constructor.name].forEach((cb) => {
            cb && cb(message);
        });
    }
    process(messageObject) {
        if (!messageObject.hasOwnProperty('type')) {
            throw new Error("[MessageProcessor] Message is missing 'type' property: " + JSON.stringify(messageObject));
        }
        const messageConstructor = this.registeredMessageTypes[messageObject['type']];
        if (!messageConstructor) {
            return;
        }
        const message = new messageConstructor();
        message.apply(messageObject);
        this.notify(message);
    }
}
exports.MessageCenter = MessageCenter;
//# sourceMappingURL=MessageCenter.js.map