"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.ObservableProperty = void 0;
class ObservableProperty {
    constructor(initialValue) {
        this.callbacks = [];
        this._value = initialValue;
    }
    addCallback(cb) {
        this.callbacks.push(cb);
    }
    get value() {
        return this._value;
    }
    set value(newValue) {
        if (newValue !== this._value) {
            this._value = newValue;
            this.doCalls();
        }
    }
    doCalls() {
        this.callbacks.forEach((cb) => {
            cb && cb(this._value);
        });
    }
}
exports.ObservableProperty = ObservableProperty;
//# sourceMappingURL=ObservableProperty.js.map