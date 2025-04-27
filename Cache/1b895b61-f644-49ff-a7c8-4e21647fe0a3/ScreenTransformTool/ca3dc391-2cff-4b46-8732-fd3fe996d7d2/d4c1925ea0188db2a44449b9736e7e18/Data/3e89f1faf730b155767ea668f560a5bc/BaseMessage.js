"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.BaseMessage = void 0;
class BaseMessage {
    static createFromJSON(json) {
        const result = new this();
        Object.apply(result, JSON.parse(json));
        return result;
    }
    static create(object) {
        const result = new this();
        Object.assign(result, object);
        return result;
    }
    static getTypeName() {
        return this.name;
    }
    constructor() {
        this.type = this.constructor.name;
    }
    applyJSON(message) {
        this.apply(JSON.parse(message));
    }
    apply(object) {
        Object.assign(this, object);
    }
}
exports.BaseMessage = BaseMessage;
//# sourceMappingURL=BaseMessage.js.map