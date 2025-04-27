"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.GuideBars = void 0;
var __selfType = requireType("./GuideBars");
function component(target) { target.getTypeName = function () { return __selfType; }; }
const GuidePool_1 = require("./GuidePool");
const Guide_1 = require("./Guide");
const CallScheduler_1 = require("../CallScheduler");
const LensRegion_1 = require("../../Common/Utilities/LensRegion/LensRegion");
const Config_1 = require("../Config");
const Gizmo_1 = require("../Gizmo/Gizmo");
let GuideBars = class GuideBars extends BaseScriptComponent {
    onAwake() {
        this.guidePool = new GuidePool_1.GuidePool(this.horizontalGuideRef, this.verticalGuideRef);
        this.callScheduler = new CallScheduler_1.CallScheduler(this.script, "LateUpdateEvent");
        this.setupInteractions();
        Config_1.Config.isGuideEnabled.addCallback((value) => {
            if (!value) {
                this.guideLines.reset();
            }
            else {
                this.drawLines();
            }
        });
        this.lensRegion.addOnLensRegionUpdate(() => {
            this.callScheduler.scheduleCall(() => this.drawLines());
            this.drawLines();
        });
    }
    getScreenPoints() {
        if (!Config_1.Config.isSnappingToGuideEnabled.value) {
            return [];
        }
        this.guidePointsBuffer = [];
        let horizontalIdx = 0;
        let verticalIdx = 0;
        this.guides.forEach((guide) => {
            if (guide.getType() === Guide_1.GuideType.Vertical) {
                if (verticalIdx >= this.guidePointsBuffer.length) {
                    this.guidePointsBuffer.push(vec2.zero());
                }
                this.guidePointsBuffer[verticalIdx].x = guide.getScreenPosition().x;
                verticalIdx += 1;
            }
            else {
                if (horizontalIdx >= this.guidePointsBuffer.length) {
                    this.guidePointsBuffer.push(vec2.zero());
                }
                this.guidePointsBuffer[horizontalIdx].y = guide.getScreenPosition().y;
                horizontalIdx += 1;
            }
        });
        return this.guidePointsBuffer;
    }
    setupInteractions() {
        this.topInteraction = this.topBar.getComponent("InteractionComponent");
        this.leftInteraction = this.leftBar.getComponent("InteractionComponent");
        this.topInteraction.onTouchStart.add((eventData) => {
            if (!Config_1.Config.isGuideEnabled.value || LensRegion_1.LensRegion.isBusy || Gizmo_1.Gizmo.isBusy || !eventData.position.lengthSquared) {
                return;
            }
            this.mouseHint.setRoundness(0);
            this.mouseHint.enableStroke(true);
            this.mouseHint.show();
            this.mouseHint.updateFromMousePosition(eventData.position);
            this.activeGuide = this.guidePool.getHorizontalGuide();
            this.guides.push(this.activeGuide);
            this.activeGuide.addOnUpdate(() => this.drawLines());
            this.activeGuide.visualEnabled = true;
            this.activeGuide.setScreenPosition(eventData.position);
            this.mouseHint.setText(this.activeGuide.getHint());
            this.callScheduler.scheduleCall(() => { this.drawLines(); });
        });
        this.topInteraction.onTouchMove.add((eventData) => {
            if (!this.activeGuide) {
                return;
            }
            this.mouseHint.updateFromMousePosition(eventData.position);
            this.activeGuide.setScreenPosition(eventData.position);
            this.mouseHint.setText(this.activeGuide.getHint());
            this.callScheduler.scheduleCall(() => { this.drawLines(); });
        });
        this.topInteraction.onTouchEnd.add((eventData) => {
            if (!this.activeGuide) {
                return;
            }
            this.mouseHint.updateFromMousePosition(eventData.position);
            this.activeGuide.setScreenPosition(eventData.position);
            this.mouseHint.setText(this.activeGuide.getHint());
            this.callScheduler.scheduleCall(() => { this.drawLines(); });
            this.mouseHint.hide();
            this.activeGuide = null;
        });
        this.leftInteraction.onTouchStart.add((eventData) => {
            if (!Config_1.Config.isGuideEnabled.value || LensRegion_1.LensRegion.isBusy || Gizmo_1.Gizmo.isBusy || !eventData.position.lengthSquared) {
                return;
            }
            this.mouseHint.setRoundness(0);
            this.mouseHint.enableStroke(true);
            this.mouseHint.show();
            this.mouseHint.updateFromMousePosition(eventData.position);
            this.activeGuide = this.guidePool.getVerticalGuide();
            this.guides.push(this.activeGuide);
            this.activeGuide.addOnUpdate(() => this.drawLines());
            this.activeGuide.visualEnabled = true;
            this.activeGuide.setScreenPosition(eventData.position);
            this.mouseHint.setText(this.activeGuide.getHint());
            this.callScheduler.scheduleCall(() => { this.drawLines(); });
        });
        this.leftInteraction.onTouchMove.add((eventData) => {
            if (!this.activeGuide) {
                return;
            }
            if (!Config_1.Config.isGuideEnabled.value || LensRegion_1.LensRegion.isBusy || Gizmo_1.Gizmo.isBusy) {
                this.activeGuide.visualEnabled = false;
                this.mouseHint.hide();
                this.activeGuide = null;
                return;
            }
            this.mouseHint.updateFromMousePosition(eventData.position);
            this.activeGuide.setScreenPosition(eventData.position);
            this.mouseHint.setText(this.activeGuide.getHint());
            this.callScheduler.scheduleCall(() => { this.drawLines(); });
        });
        this.leftInteraction.onTouchEnd.add((eventData) => {
            if (!this.activeGuide) {
                return;
            }
            this.activeGuide.setScreenPosition(eventData.position);
            this.callScheduler.scheduleCall(() => { this.drawLines(); });
            this.mouseHint.updateFromMousePosition(eventData.position);
            this.mouseHint.setText(this.activeGuide.getHint());
            this.mouseHint.hide();
            this.activeGuide = null;
        });
    }
    drawLines() {
        if (!Config_1.Config.isGuideEnabled.value) {
            return;
        }
        this.guideLines.reset();
        this.guides.forEach((guide) => {
            const pointA = guide.getWorldCenter();
            const pointB = guide.getWorldCenter();
            if (guide.getType() === Guide_1.GuideType.Vertical) {
                pointA.y = 10000;
                pointB.y = -10000;
            }
            else {
                pointA.x = -10000;
                pointB.x = 10000;
            }
            this.guideLines.addLine(pointA, pointB);
        });
        this.guideLines.update();
    }
    __initialize() {
        super.__initialize();
        this.activeGuide = null;
        this.guides = [];
        this.guidePointsBuffer = [];
    }
};
exports.GuideBars = GuideBars;
exports.GuideBars = GuideBars = __decorate([
    component
], GuideBars);
//# sourceMappingURL=GuideBars.js.map