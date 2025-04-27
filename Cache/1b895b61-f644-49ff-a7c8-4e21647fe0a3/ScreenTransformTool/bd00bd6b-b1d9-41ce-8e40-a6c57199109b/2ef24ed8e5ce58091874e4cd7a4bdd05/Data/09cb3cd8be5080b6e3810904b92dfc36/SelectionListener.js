"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.SelectionListener = void 0;
const Utils_1 = require("./Utils");
class SelectionListener {
    constructor(script) {
        this.script = script;
        //@ts-ignore
        this.selectedObjects = [null];
        //@ts-ignore
        this.selectedParents = [null];
        this.onSelectionUpdate = () => { };
        if (Utils_1.Utils.isEditor()) {
            this.updateEvent = this.script.createEvent("UpdateEvent");
            this.updateEvent.bind(() => {
                if (this.checkForSelectionUpdate()) {
                    this.onSelectionUpdate && this.onSelectionUpdate();
                }
            });
        }
    }
    //@ts-ignore
    getSelectedObject() {
        return this.selectedObjects;
    }
    setOnSelectionUpdate(cb) {
        this.onSelectionUpdate = cb;
    }
    forceUpdate() {
        if (this.checkForSelectionUpdate()) {
            this.onSelectionUpdate && this.onSelectionUpdate();
        }
    }
    forceCallSelectionUpdate() {
        this.onSelectionUpdate && this.onSelectionUpdate();
    }
    checkForSelectionUpdate() {
        if (!Utils_1.Utils.isEditor()) {
            return false;
        }
        const newSelectedObjects = this.getSelection();
        if (!this.compareSelections(newSelectedObjects)) {
            this.selectedObjects = newSelectedObjects;
            this.selectedParents = this.selectedObjects.map(obj => obj === null || obj === void 0 ? void 0 : obj.getParent());
            return true;
        }
        return false;
    }
    //@ts-ignore
    compareSelections(selectionB) {
        var _a, _b, _c, _d;
        if (this.selectedObjects.length !== selectionB.length) {
            return false;
        }
        for (let i = 0; i < this.selectedParents.length; i++) {
            if (isNull(this.selectedObjects[i])) {
                this.selectedObjects[i] = null;
            }
            if (isNull(this.selectedParents[i])) {
                this.selectedParents[i] = null;
            }
            if (isNull(selectionB[i])) {
                selectionB[i] = null;
            }
            const parentB = (_a = selectionB[i]) === null || _a === void 0 ? void 0 : _a.getParent();
            if (((_b = this.selectedObjects[i]) === null || _b === void 0 ? void 0 : _b.id.toString()) !== ((_c = selectionB[i]) === null || _c === void 0 ? void 0 : _c.id.toString())
                || ((_d = this.selectedParents[i]) === null || _d === void 0 ? void 0 : _d.id.toString()) !== (parentB === null || parentB === void 0 ? void 0 : parentB.id.toString())) {
                return false;
            }
        }
        return true;
    }
    //@ts-ignore
    getSelection() {
        var _a, _b;
        try {
            //@ts-ignore
            const currentSelection = (_a = Editor === null || Editor === void 0 ? void 0 : Editor.context) === null || _a === void 0 ? void 0 : _a.selection;
            return ((_b = currentSelection === null || currentSelection === void 0 ? void 0 : currentSelection.sceneObjects) === null || _b === void 0 ? void 0 : _b.length) ? currentSelection.sceneObjects : [null];
        }
        catch (e) {
            return [];
        }
    }
}
exports.SelectionListener = SelectionListener;
//# sourceMappingURL=SelectionListener.js.map