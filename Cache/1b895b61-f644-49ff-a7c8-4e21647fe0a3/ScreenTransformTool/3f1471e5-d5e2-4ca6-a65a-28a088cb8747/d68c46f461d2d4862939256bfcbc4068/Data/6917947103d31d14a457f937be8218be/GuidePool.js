"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.GuidePool = void 0;
const Guide_1 = require("./Guide");
class GuidePool {
    constructor(horizontalGuide, verticalGuide) {
        this.horizontalGuide = horizontalGuide;
        this.verticalGuide = verticalGuide;
        this.poolSize = 2;
        this.verticalPool = [];
        this.horizontalPool = [];
        this.horizontalRef = this.horizontalGuide.getSceneObject();
        this.verticalRef = this.verticalGuide.getSceneObject();
        this.horizontalGuide.visualEnabled = false;
        this.verticalGuide.visualEnabled = false;
        this.horizontalRoot = this.horizontalRef.getParent();
        this.verticalRoot = this.verticalRef.getParent();
        for (let i = 0; i < this.poolSize; i++) {
            this.generateHorizontalGuide();
            this.generateVerticalGuide();
        }
    }
    generateVerticalGuide() {
        const newGuideObject = this.verticalRoot.copyWholeHierarchyAndAssets(this.verticalRef);
        const guide = newGuideObject.getComponent("ScriptComponent");
        guide.setType(Guide_1.GuideType.Vertical);
        this.verticalPool.push(guide);
    }
    generateHorizontalGuide() {
        const newGuideObject = this.horizontalRoot.copyWholeHierarchyAndAssets(this.horizontalRef);
        this.horizontalPool.push(newGuideObject.getComponent("ScriptComponent"));
    }
    getVerticalGuide() {
        this.generateVerticalGuide();
        return this.verticalPool.pop();
    }
    getHorizontalGuide() {
        this.generateHorizontalGuide();
        return this.horizontalPool.pop();
    }
}
exports.GuidePool = GuidePool;
//# sourceMappingURL=GuidePool.js.map