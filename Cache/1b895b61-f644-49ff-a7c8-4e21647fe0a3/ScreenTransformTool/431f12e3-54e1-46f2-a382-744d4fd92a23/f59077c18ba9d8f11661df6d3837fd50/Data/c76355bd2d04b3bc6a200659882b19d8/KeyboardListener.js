"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var KeyboardListener_1;
Object.defineProperty(exports, "__esModule", { value: true });
exports.KeyboardListener = void 0;
var __selfType = requireType("./KeyboardListener");
function component(target) { target.getTypeName = function () { return __selfType; }; }
const Utils_1 = require("./Utils");
let KeyboardListener = KeyboardListener_1 = class KeyboardListener extends BaseScriptComponent {
    //@ts-ignore
    static isKeyPressed(key) {
        return KeyboardListener_1.isPressed[key];
    }
    //@ts-ignore
    static subscribeToKey(key, onPressed, onReleased) {
        if (!KeyboardListener_1.onPressedSubs[key]) {
            KeyboardListener_1.onPressedSubs[key] = [];
            KeyboardListener_1.onReleasedSubs[key] = [];
        }
        KeyboardListener_1.onPressedSubs[key].push(onPressed);
        KeyboardListener_1.onReleasedSubs[key].push(onReleased);
    }
    createKeyboardEvents() {
        //@ts-ignore
        this.createEvent("KeyPressedEvent").bind(this.onKeyPressed);
        //@ts-ignore
        this.createEvent("KeyReleasedEvent").bind(this.onKeyReleased);
    }
    __initialize() {
        super.__initialize();
        this.onAwake = () => {
            if (Utils_1.Utils.isEditor()) {
                this.createKeyboardEvents();
            }
        };
        this.onKeyPressed = (eventData) => {
            KeyboardListener_1.isPressed[eventData.key] = true;
            if (KeyboardListener_1.onPressedSubs[eventData.key]) {
                KeyboardListener_1.onPressedSubs[eventData.key].forEach(cb => cb(eventData));
            }
        };
        this.onKeyReleased = (eventData) => {
            KeyboardListener_1.isPressed[eventData.key] = false;
            if (KeyboardListener_1.onReleasedSubs[eventData.key]) {
                KeyboardListener_1.onReleasedSubs[eventData.key].forEach(cb => cb(eventData));
            }
        };
    }
};
exports.KeyboardListener = KeyboardListener;
KeyboardListener.isPressed = {};
KeyboardListener.onPressedSubs = {};
KeyboardListener.onReleasedSubs = {};
exports.KeyboardListener = KeyboardListener = KeyboardListener_1 = __decorate([
    component
], KeyboardListener);
//# sourceMappingURL=KeyboardListener.js.map