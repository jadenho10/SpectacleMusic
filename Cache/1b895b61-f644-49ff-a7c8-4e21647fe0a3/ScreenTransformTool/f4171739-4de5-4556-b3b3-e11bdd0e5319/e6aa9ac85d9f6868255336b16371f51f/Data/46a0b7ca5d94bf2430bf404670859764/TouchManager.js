"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.TouchManager = void 0;
var __selfType = requireType("./TouchManager");
function component(target) { target.getTypeName = function () { return __selfType; }; }
let TouchManager = class TouchManager extends BaseScriptComponent {
    register(receiver, parent = null) {
        receiver.trackedEvents.forEach((event) => {
            if (this.registeredEvents[event]) {
                return;
            }
            this.registeredEvents[event] = this.createEvent(event);
            this.registeredEvents[event].bind(this.notify);
        });
        if (parent) {
            const parentIndex = this.leafReceiverIds.indexOf(parent.uniqueIdentifier);
            if (parentIndex !== -1) {
                this.leafReceiverIds.splice(parentIndex, 1);
            }
            if (this.nonLeafReceiverIds.indexOf(parent.uniqueIdentifier) === -1) {
                this.nonLeafReceiverIds.push(parent.uniqueIdentifier);
            }
            this.idToObject[parent.uniqueIdentifier] = parent;
        }
        const receiverIndex = this.nonLeafReceiverIds.indexOf(receiver.uniqueIdentifier);
        if (receiverIndex === -1) {
            this.leafReceiverIds.push(receiver.uniqueIdentifier);
        }
        this.idToObject[receiver.uniqueIdentifier] = receiver;
    }
    __initialize() {
        super.__initialize();
        this.registeredEvents = {};
        this.idToObject = {};
        this.leafReceiverIds = [];
        this.nonLeafReceiverIds = [];
        this.onAwake = () => {
        };
        this.notify = (eventData) => {
            const processedObjects = {};
            const queue = this.leafReceiverIds.map((id) => this.idToObject[id]);
            while (queue.length) {
                const receiver = queue.shift();
                if (isNull(receiver)) {
                    continue;
                }
                queue.push(receiver.touchParent);
                if (!receiver.trackedEvents.some(event => event === eventData.getTypeName())) {
                    continue;
                }
                if (processedObjects[receiver.uniqueIdentifier]) {
                    continue;
                }
                processedObjects[receiver.uniqueIdentifier] = true;
                if (receiver.eventFilter(eventData)) {
                    return;
                }
            }
        };
    }
};
exports.TouchManager = TouchManager;
exports.TouchManager = TouchManager = __decorate([
    component
], TouchManager);
//# sourceMappingURL=TouchManager.js.map