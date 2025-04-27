"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.GlowEffectView = void 0;
const HandInteractor_1 = require("../../../Core/HandInteractor/HandInteractor");
const Interactor_1 = require("../../../Core/Interactor/Interactor");
const WorldCameraFinderProvider_1 = require("../../../Providers/CameraProvider/WorldCameraFinderProvider");
const HandInputData_1 = require("../../../Providers/HandInputData/HandInputData");
const SIKLogLevelProvider_1 = require("../../../Providers/InteractionConfigurationProvider/SIKLogLevelProvider");
const animate_1 = require("../../../Utils/animate");
const LensConfig_1 = require("../../../Utils/LensConfig");
const validate_1 = require("../../../Utils/validate");
const GlowEffectViewModel_1 = require("./GlowEffectViewModel");
const HandVisual_1 = require("./HandVisual");
const TAG = "GlowEffectView";
const GLOW_QUAD_WORLD_SCALE = new vec3(0.3, 0.3, 0.3);
const PINCH_BASE_BONUS_RATIO = 0.7;
const PINCH_ANIMATION_DURATION = 0.3;
const WAIT_BETWEEN_FIELD_TRANSITIONS = 0.5;
const FIELD_TRANSITION_BRIGHTNESS_LOWERING = 0.5;
const PINCH_STRENGTH_NEAR_PINCH_EXIT_THRESHOLD = 0.2;
const PINCH_STRENGTH_NEAR_PINCH_ENTER_THRESHOLD = 0.5;
const HAND_MESH_MATERIAL_BRIGHTNESS_FARFIELD = 1.0;
const HAND_MESH_MATERIAL_BRIGHTNESS_NEARFIELD = 2.0;
const HAND_MESH_MATERIAL_BRIGHTNESS_INCREASE = 2.0;
const HAND_MESH_MATERIAL_BRIGHTNESS_REMAPPED_NEARFIELD = 4.0;
const HAND_MESH_MATERIAL_FULL_BRIGHTNESS_DISTANCE_NEARFIELD = 0.8;
const HAND_MESH_MATERIAL_BRIGHTNESS_TRIGGERED = 2.0;
const HAND_MESH_MATERIAL_FADEUP_NEARFIELD = 1.5;
const HAND_MESH_MATERIAL_FADEDOWN_FARFIELD = 1.5;
const GLOW_MATERIAL_START_BRIGHTNESS_DISTANCE_NEARFIELD = 0.3;
const GLOW_MATERIAL_FULL_BRIGHTNESS_DISTANCE_NEARFIELD = 0.8;
const GLOW_MATERIAL_BRIGHTNESS_NEARFIELD = 1.0;
const GLOW_MATERIAL_BRIGHTNESS_TRIGGERED = 1.0;
const GLOW_MATERIAL_BRIGHTNESS_BEHIND_MIN = 1.5;
const GLOW_MATERIAL_BRIGHTNESS_BEHIND_MAX = 1.0;
const GLOW_MATERIAL_DISTANCE_BEHIND_MIN = 0.9;
const GLOW_MATERIAL_DISTANCE_BEHIND_MAX = 1.0;
const GLOW_MATERIAL_DEFAULT_BRIGHTNESS = 0.5;
/*
 * This determines what we consider to be "palm facing the camera", so a smaller value
 * means that your palm would need to be to be looking more "directly" at the camera
 * for us to consider it to be "facing the camera"
 */
const HAND_FACING_CAMERA_THRESHOLD_DEGREES = 90;
const VEC3_UP = vec3.up();
/**
 * GlowEffectView controls the glow effect that happens when pinching and tapping.
 *
 * I did not extend View class because while this q
 * acts like a View in the sense that it is messing with UI/visuals, it does so through SceneObjects and textures which are passed
 * in as parameters, instead of needing its own SceneObject hierarchy to be added.
 */
class GlowEffectView {
    constructor(config) {
        var _a, _b;
        this.config = config;
        this.sikLogLevelProvider = SIKLogLevelProvider_1.default.getInstance();
        this.updateDispatcher = LensConfig_1.LensConfig.getInstance().updateDispatcher;
        this.handProvider = HandInputData_1.HandInputData.getInstance();
        this.tapGlowEnabled = this.handProvider.getDominantHand().handType === this.config.handType;
        this.hand = this.handProvider.getHand(this.config.handType);
        this.handVisuals = this.hand.getHandVisuals();
        this.indexTipSceneObject = (_a = this.handVisuals) === null || _a === void 0 ? void 0 : _a.indexTip;
        this.thumbTipSceneObject = (_b = this.handVisuals) === null || _b === void 0 ? void 0 : _b.thumbTip;
        this.hoverColor = this.config.hoverColor;
        this.triggerColor = this.config.triggerColor;
        this.behindColor = this.config.behindColor;
        // handToTap is the hand NOT passed to this class
        this.handToTap = this.handProvider.getHand(this.config.handType === "left" ? "right" : "left");
        this.camera = WorldCameraFinderProvider_1.default.getInstance();
        /*
         * Pinch glow effect uses a quad with glow material and texture on index
         * and thumb tip, both billboarded towards the camera
         */
        this.indexQuadSceneObject = this.setupTipQuadSceneObject(this.indexTipSceneObject, "indexTipQuadSceneObject");
        this.indexQuadTransform = this.indexQuadSceneObject.getTransform();
        this.thumbQuadSceneObject = this.setupTipQuadSceneObject(this.thumbTipSceneObject, "thumbTipQuadSceneObject");
        this.thumbQuadTransform = this.thumbQuadSceneObject.getTransform();
        /**
         * Pinch glow effect manipulates these materials to create the "glow"
         */
        this.tipGlowMaterialIndexTip = this.indexQuadSceneObject.getComponent("Component.RenderMeshVisual")
            .mainMaterial;
        this.tipGlowMaterialThumbTip = this.thumbQuadSceneObject.getComponent("Component.RenderMeshVisual")
            .mainMaterial;
        this.handInteractor = this.config.handInteractor;
        this.indexGlowBonusCancelSet = new animate_1.CancelSet();
        this.indexGlowStrengthCancelSet = new animate_1.CancelSet();
        this.thumbGlowBonusCancelSet = new animate_1.CancelSet();
        this.thumbGlowStrengthCancelSet = new animate_1.CancelSet();
        this.indexGlowBonus = 0;
        this.indexGlowBase = 0;
        this.thumbGlowBonus = 0;
        this.thumbGlowBase = 0;
        this.isInPalmUIMode = false;
        this.isInTargetingMode = false;
        this.isInNearPinchMode = false;
        this.pinchTransitionColor = vec4.one();
        this.visualSelection = this.config.visualSelection;
        this.handOutlineMaterial = this.config.handOutlineMaterial;
        this.handOccluderMaterial = this.config.handOccluderMaterial;
        this.shouldThumbPokeGlow = this.config.shouldThumbPokeGlow;
        this.lastFrameField = HandInteractor_1.FieldTargetingMode.FarField;
        this.nearFieldStartTime = 0;
        this.farFieldStartTime = 0;
        this.timeSinceLastTransition = 0;
        this.pokeFingerBrightness = 0;
        this.pokeGlowBrightness = 0;
        this.pinchFingerBrightness = 0;
        this.pinchGlowBrightness = 0;
        this.currentFingerBrightness = 0;
        this.currentGlowBrightness = 0;
        this.lastFingerBrightness = 0;
        this.lastGlowBrightness = 0;
        this.fieldTransitionLerp = 0;
        this.glowEffectViewModel = new GlowEffectViewModel_1.GlowEffectViewModel({
            handType: this.config.handType,
            logLevel: this.sikLogLevelProvider.logLevel,
        });
        // Cached value from API .enabled calls
        // eslint-disable-next-line @typescript-eslint/no-inferrable-types
        this._enabled = true;
        // Connect to ViewModel events. This is how the glow effect will be driven
        this.glowEffectViewModel.animateIndexGlowBase.add((animateGlowBaseUp) => {
            this.animateIndexGlowBase(animateGlowBaseUp);
        });
        this.glowEffectViewModel.animateIndexGlowBonus.add((animateGlowBonusUp) => {
            this.animateIndexGlowBonus(animateGlowBonusUp);
        });
        this.glowEffectViewModel.animateThumbGlowBase.add((animateGlowBaseUp) => {
            this.animateThumbGlowBase(animateGlowBaseUp);
        });
        this.glowEffectViewModel.animateThumbGlowBonus.add((animateGlowBonusUp) => {
            this.animateThumbGlowBonus(animateGlowBonusUp);
        });
        this.glowEffectViewModel.tapModeChanged((tapModeEntered) => {
            var _a;
            (0, validate_1.validate)((_a = this.handVisuals) === null || _a === void 0 ? void 0 : _a.handMesh);
            if (tapModeEntered === true) {
                this.handVisuals.handMesh.mainPass["indexBrightness"] =
                    HAND_MESH_MATERIAL_BRIGHTNESS_TRIGGERED;
                this.handVisuals.handMesh.mainPass["thumbBrightness"] = 0;
                this.handVisuals.handMesh.mainPass["indexGlowColor"] = this.triggerColor;
                this.handVisuals.handMesh.mainPass["thumbGlowColor"] = this.triggerColor;
                this.tipGlowMaterialIndexTip.mainPass["pinchBrightness"] =
                    GLOW_MATERIAL_BRIGHTNESS_TRIGGERED;
                this.tipGlowMaterialThumbTip.mainPass["pinchBrightness"] = 0;
                this.tipGlowMaterialIndexTip.mainPass["glowColor"] = this.triggerColor;
                this.tipGlowMaterialThumbTip.mainPass["glowColor"] = this.triggerColor;
            }
            else {
                this.handVisuals.handMesh.mainPass["indexBrightness"] =
                    HAND_MESH_MATERIAL_BRIGHTNESS_TRIGGERED;
                this.handVisuals.handMesh.mainPass["thumbBrightness"] = 0;
                this.handVisuals.handMesh.mainPass["indexGlowColor"] = this.hoverColor;
                this.handVisuals.handMesh.mainPass["thumbGlowColor"] = this.hoverColor;
                this.tipGlowMaterialIndexTip.mainPass["pinchBrightness"] =
                    GLOW_MATERIAL_BRIGHTNESS_TRIGGERED;
                this.tipGlowMaterialThumbTip.mainPass["pinchBrightness"] = 0;
                this.tipGlowMaterialIndexTip.mainPass["glowColor"] = this.hoverColor;
                this.tipGlowMaterialThumbTip.mainPass["glowColor"] = this.hoverColor;
            }
        });
        if (this.visualSelection === HandVisual_1.HandVisualSelection.Occluder) {
            this.tipGlowMaterialIndexTip.mainPass["brightness"] = 0;
            this.tipGlowMaterialThumbTip.mainPass["brightness"] = 0;
            this.handVisuals.handMesh.mainMaterial = this.handOccluderMaterial;
        }
        // Set up initial conditions
        this.setIsInPalmUiMode(this.calculateIsInPalmUIMode());
        this.setIsInTargetingMode(this.calculateIsInTargetingMode());
        this.setupPinchEvents();
        this.updateDispatcher
            .createUpdateEvent("GlowEffectViewUpdateEvent")
            .bind(() => {
            // If disabled via API, do not update the glow.
            if (!this._enabled ||
                this.visualSelection === HandVisual_1.HandVisualSelection.Occluder) {
                return;
            }
            const cameraPosition = this.camera.getWorldPosition();
            this.indexQuadTransform.setWorldRotation(quat.lookAt(cameraPosition.sub(this.indexQuadTransform.getWorldPosition()), VEC3_UP));
            this.thumbQuadTransform.setWorldRotation(quat.lookAt(cameraPosition.sub(this.thumbQuadTransform.getWorldPosition()), VEC3_UP));
            this.setIsInPalmUiMode(this.calculateIsInPalmUIMode());
            this.setIsInTargetingMode(this.calculateIsInTargetingMode());
            this.setIsInNearPinchMode(this.calculateIsInNearPinchMode());
        });
        this.updateDispatcher
            .createLateUpdateEvent("GlowEffectViewLateUpdateEvent")
            .bind(() => {
            // If disabled via API, do not update the glow.
            if (!this._enabled ||
                this.visualSelection === HandVisual_1.HandVisualSelection.Occluder) {
                return;
            }
            this.updateMaterial();
        });
    }
    /**
     * Enable/disable the SceneObject's created by this class
     * @param isEnabled - boolean representing whether to enable or disable this class
     */
    set enabled(isEnabled) {
        this._enabled = isEnabled;
        this.indexQuadSceneObject.enabled = isEnabled;
        this.thumbQuadSceneObject.enabled = isEnabled;
    }
    setVisualSelection(visualSelection) {
        this.visualSelection = visualSelection;
        if (this.visualSelection === HandVisual_1.HandVisualSelection.Occluder) {
            this.tipGlowMaterialIndexTip.mainPass["brightness"] = 0;
            this.tipGlowMaterialThumbTip.mainPass["brightness"] = 0;
            this.handVisuals.handMesh.mainPass["indexBrightness"] = 0;
            this.handVisuals.handMesh.mainPass["thumbBrightness"] = 0;
            this.handVisuals.handMesh.mainMaterial = this.handOccluderMaterial;
        }
        else {
            this.handVisuals.handMesh.mainMaterial = this.handOutlineMaterial;
            this.tipGlowMaterialIndexTip.mainPass["brightness"] =
                GLOW_MATERIAL_DEFAULT_BRIGHTNESS;
            this.tipGlowMaterialThumbTip.mainPass["brightness"] =
                GLOW_MATERIAL_DEFAULT_BRIGHTNESS;
            this.handVisuals.handMesh.mainPass["indexBrightness"] = 0;
            this.handVisuals.handMesh.mainPass["thumbBrightness"] = 0;
        }
    }
    /**
     * Clean up the SceneObject's created by PinchGlow
     */
    destroy() {
        this.indexQuadSceneObject.destroy();
        this.thumbQuadSceneObject.destroy();
    }
    setupTipQuadSceneObject(parentSceneObject, sceneObjectName) {
        (0, validate_1.validate)(parentSceneObject);
        // Create the quad SceneObject to hold glow material and texture
        const quadSceneObject = global.scene.createSceneObject(sceneObjectName);
        quadSceneObject.setParent(parentSceneObject);
        quadSceneObject.getTransform().setWorldScale(GLOW_QUAD_WORLD_SCALE);
        const quadComponent = quadSceneObject.createComponent("Component.RenderMeshVisual");
        quadComponent.mesh = this.config.unitPlaneMesh;
        quadComponent.setRenderOrder(this.config.tipGlowRenderOrder);
        // Initialize the quad RenderMeshVisual with the glow material
        const tipGlowMaterial = this.config.tipGlowMaterial.clone();
        tipGlowMaterial.mainPass.depthTest = false;
        tipGlowMaterial.mainPass.depthWrite = false;
        tipGlowMaterial.mainPass.glowColor = this.hoverColor;
        tipGlowMaterial.mainPass.brightness = GLOW_MATERIAL_DEFAULT_BRIGHTNESS;
        quadComponent.mainMaterial = tipGlowMaterial;
        return quadSceneObject;
    }
    updateMaterial() {
        var _a, _b;
        (0, validate_1.validate)((_a = this.handVisuals) === null || _a === void 0 ? void 0 : _a.handMesh);
        const pinchStrength = (_b = this.hand.getPinchStrength()) !== null && _b !== void 0 ? _b : 0;
        const scaledIndexGlowBase = this.indexGlowBase * PINCH_BASE_BONUS_RATIO;
        const scaledIndexGlowBonus = this.indexGlowBonus * (1 - PINCH_BASE_BONUS_RATIO);
        const combinedIndexGlowFactor = scaledIndexGlowBase + scaledIndexGlowBonus;
        const scaledThumbGlowBase = this.thumbGlowBase * PINCH_BASE_BONUS_RATIO;
        const scaledThumbGlowBonus = this.indexGlowBonus * (1 - PINCH_BASE_BONUS_RATIO);
        const combinedThumbGlowFactor = scaledThumbGlowBase + scaledThumbGlowBonus;
        switch (this.handInteractor.fieldTargetingMode) {
            case HandInteractor_1.FieldTargetingMode.FarField:
                if (this.lastFrameField !== HandInteractor_1.FieldTargetingMode.FarField &&
                    getTime() - this.timeSinceLastTransition >
                        WAIT_BETWEEN_FIELD_TRANSITIONS) {
                    this.timeSinceLastTransition = getTime();
                    this.farFieldStartTime = getTime();
                    this.lastFingerBrightness =
                        this.currentFingerBrightness * FIELD_TRANSITION_BRIGHTNESS_LOWERING;
                    this.lastGlowBrightness =
                        this.currentGlowBrightness * FIELD_TRANSITION_BRIGHTNESS_LOWERING;
                }
                this.fieldTransitionLerp = MathUtils.clamp((getTime() - this.farFieldStartTime) /
                    HAND_MESH_MATERIAL_FADEDOWN_FARFIELD, 0, 1);
                this.handVisuals.handMesh.mainPass["blend_coef"] = 0;
                switch (this.handInteractor.currentTrigger) {
                    case Interactor_1.InteractorTriggerType.None:
                        this.pinchGlowBrightness =
                            combinedIndexGlowFactor *
                                GLOW_MATERIAL_BRIGHTNESS_NEARFIELD *
                                pinchStrength;
                        this.pinchFingerBrightness =
                            this.pinchGlowBrightness * HAND_MESH_MATERIAL_BRIGHTNESS_INCREASE;
                        this.currentFingerBrightness = MathUtils.lerp(this.lastFingerBrightness, this.pinchFingerBrightness, this.fieldTransitionLerp);
                        this.currentGlowBrightness = MathUtils.lerp(this.lastGlowBrightness, this.pinchGlowBrightness, this.fieldTransitionLerp);
                        this.handVisuals.handMesh.mainPass["indexBrightness"] =
                            this.currentFingerBrightness;
                        this.handVisuals.handMesh.mainPass["thumbBrightness"] =
                            this.pinchFingerBrightness;
                        this.tipGlowMaterialIndexTip.mainPass["pinchBrightness"] =
                            this.currentGlowBrightness;
                        this.tipGlowMaterialThumbTip.mainPass["pinchBrightness"] =
                            this.pinchGlowBrightness;
                        this.tipGlowMaterialIndexTip.mainPass["pokeBrightness"] = 0;
                        this.tipGlowMaterialThumbTip.mainPass["pokeBrightness"] = 0;
                        this.handVisuals.handMesh.mainPass["indexGlowColor"] =
                            this.hoverColor;
                        this.handVisuals.handMesh.mainPass["thumbGlowColor"] =
                            this.hoverColor;
                        this.tipGlowMaterialIndexTip.mainPass["glowColor"] = this.hoverColor;
                        this.tipGlowMaterialThumbTip.mainPass["glowColor"] = this.hoverColor;
                        break;
                    case Interactor_1.InteractorTriggerType.Pinch:
                        this.currentFingerBrightness = MathUtils.lerp(this.lastFingerBrightness, HAND_MESH_MATERIAL_BRIGHTNESS_TRIGGERED, this.fieldTransitionLerp);
                        this.currentGlowBrightness = MathUtils.lerp(this.lastGlowBrightness, GLOW_MATERIAL_BRIGHTNESS_TRIGGERED, this.fieldTransitionLerp);
                        this.handVisuals.handMesh.mainPass["indexBrightness"] =
                            this.currentFingerBrightness;
                        this.handVisuals.handMesh.mainPass["thumbBrightness"] =
                            this.currentFingerBrightness;
                        this.tipGlowMaterialIndexTip.mainPass["pinchBrightness"] =
                            this.currentGlowBrightness;
                        this.tipGlowMaterialThumbTip.mainPass["pinchBrightness"] =
                            this.currentGlowBrightness;
                        this.tipGlowMaterialIndexTip.mainPass["pokeBrightness"] = 0;
                        this.tipGlowMaterialThumbTip.mainPass["pokeBrightness"] = 0;
                        this.handVisuals.handMesh.mainPass["indexGlowColor"] =
                            this.triggerColor;
                        this.handVisuals.handMesh.mainPass["thumbGlowColor"] =
                            this.triggerColor;
                        this.tipGlowMaterialIndexTip.mainPass["glowColor"] =
                            this.triggerColor;
                        this.tipGlowMaterialThumbTip.mainPass["glowColor"] =
                            this.triggerColor;
                        break;
                    default:
                        break;
                }
                break;
            case HandInteractor_1.FieldTargetingMode.NearField:
            case HandInteractor_1.FieldTargetingMode.Direct:
                if (this.lastFrameField === HandInteractor_1.FieldTargetingMode.FarField &&
                    getTime() - this.timeSinceLastTransition >
                        WAIT_BETWEEN_FIELD_TRANSITIONS) {
                    this.timeSinceLastTransition = getTime();
                    this.nearFieldStartTime = getTime();
                    this.lastFingerBrightness = this.currentFingerBrightness;
                    this.lastGlowBrightness = this.currentGlowBrightness;
                }
                this.fieldTransitionLerp = MathUtils.clamp((getTime() - this.nearFieldStartTime) /
                    HAND_MESH_MATERIAL_FADEUP_NEARFIELD, 0, 1);
                switch (this.handInteractor.currentTrigger) {
                    case Interactor_1.InteractorTriggerType.None:
                        this.handVisuals.handMesh.mainPass["blend_coef"] = 0;
                        this.pokeFingerBrightness = MathUtils.clamp(MathUtils.remap(this.handInteractor.nearFieldProximity, 0, HAND_MESH_MATERIAL_FULL_BRIGHTNESS_DISTANCE_NEARFIELD, 0, HAND_MESH_MATERIAL_BRIGHTNESS_REMAPPED_NEARFIELD), 0, HAND_MESH_MATERIAL_BRIGHTNESS_REMAPPED_NEARFIELD);
                        this.pokeGlowBrightness = MathUtils.remap(this.handInteractor.nearFieldProximity, GLOW_MATERIAL_START_BRIGHTNESS_DISTANCE_NEARFIELD, GLOW_MATERIAL_FULL_BRIGHTNESS_DISTANCE_NEARFIELD, 0, GLOW_MATERIAL_BRIGHTNESS_NEARFIELD);
                        this.pinchGlowBrightness =
                            combinedIndexGlowFactor *
                                GLOW_MATERIAL_BRIGHTNESS_NEARFIELD *
                                pinchStrength;
                        this.pinchFingerBrightness =
                            this.pinchGlowBrightness * HAND_MESH_MATERIAL_BRIGHTNESS_INCREASE;
                        this.currentFingerBrightness =
                            this.pokeFingerBrightness > this.pinchFingerBrightness
                                ? this.pokeFingerBrightness
                                : this.pinchFingerBrightness;
                        this.currentGlowBrightness =
                            this.pokeGlowBrightness > this.pinchGlowBrightness
                                ? this.pokeGlowBrightness
                                : this.pinchGlowBrightness;
                        this.currentFingerBrightness = MathUtils.lerp(this.lastFingerBrightness, this.currentFingerBrightness, this.fieldTransitionLerp);
                        this.currentGlowBrightness = MathUtils.lerp(this.lastGlowBrightness, this.currentFingerBrightness, this.fieldTransitionLerp);
                        this.handVisuals.handMesh.mainPass["indexBrightness"] =
                            this.currentFingerBrightness;
                        this.tipGlowMaterialIndexTip.mainPass["pinchBrightness"] =
                            this.pinchGlowBrightness;
                        this.tipGlowMaterialIndexTip.mainPass["pokeBrightness"] =
                            this.pokeGlowBrightness;
                        if (this.shouldThumbPokeGlow) {
                            this.handVisuals.handMesh.mainPass["thumbBrightness"] =
                                this.currentFingerBrightness;
                            this.tipGlowMaterialThumbTip.mainPass["pokeBrightness"] =
                                this.pokeGlowBrightness;
                            this.tipGlowMaterialThumbTip.mainPass["pokeBrightness"] =
                                this.pinchFingerBrightness;
                        }
                        else {
                            this.handVisuals.handMesh.mainPass["thumbBrightness"] =
                                this.pinchFingerBrightness;
                            this.tipGlowMaterialThumbTip.mainPass["pokeBrightness"] = 0;
                            this.tipGlowMaterialThumbTip.mainPass["pinchBrightness"] =
                                this.pinchGlowBrightness;
                        }
                        this.handVisuals.handMesh.mainPass["indexGlowColor"] =
                            this.hoverColor;
                        this.handVisuals.handMesh.mainPass["thumbGlowColor"] =
                            this.hoverColor;
                        this.tipGlowMaterialIndexTip.mainPass["glowColor"] = this.hoverColor;
                        this.tipGlowMaterialThumbTip.mainPass["glowColor"] = this.hoverColor;
                        break;
                    case Interactor_1.InteractorTriggerType.Pinch:
                    case Interactor_1.InteractorTriggerType.Poke:
                    case Interactor_1.InteractorTriggerType.Select:
                        if (this.handInteractor.nearFieldProximity >
                            GLOW_MATERIAL_DISTANCE_BEHIND_MIN) {
                            this.currentFingerBrightness =
                                HAND_MESH_MATERIAL_BRIGHTNESS_NEARFIELD;
                            this.currentGlowBrightness = MathUtils.remap(this.handInteractor.nearFieldProximity, GLOW_MATERIAL_DISTANCE_BEHIND_MIN, GLOW_MATERIAL_DISTANCE_BEHIND_MAX, GLOW_MATERIAL_BRIGHTNESS_BEHIND_MIN, GLOW_MATERIAL_BRIGHTNESS_BEHIND_MAX);
                            this.handVisuals.handMesh.mainPass["indexGlowColor"] =
                                this.behindColor;
                            this.tipGlowMaterialIndexTip.mainPass["glowColor"] =
                                this.behindColor;
                            this.handVisuals.handMesh.mainPass["thumbGlowColor"] =
                                this.behindColor;
                            this.tipGlowMaterialThumbTip.mainPass["glowColor"] =
                                this.behindColor;
                        }
                        else {
                            this.currentFingerBrightness =
                                HAND_MESH_MATERIAL_BRIGHTNESS_TRIGGERED;
                            this.currentGlowBrightness = GLOW_MATERIAL_BRIGHTNESS_TRIGGERED;
                            this.handVisuals.handMesh.mainPass["indexGlowColor"] =
                                this.triggerColor;
                            this.handVisuals.handMesh.mainPass["thumbGlowColor"] =
                                this.triggerColor;
                            this.tipGlowMaterialIndexTip.mainPass["glowColor"] =
                                this.triggerColor;
                            this.tipGlowMaterialThumbTip.mainPass["glowColor"] =
                                this.triggerColor;
                        }
                        if (this.handInteractor.currentTrigger === Interactor_1.InteractorTriggerType.Poke) {
                            this.handVisuals.handMesh.mainPass["blend_coef"] = 1;
                        }
                        else {
                            this.handVisuals.handMesh.mainPass["blend_coef"] = 0;
                        }
                        this.currentFingerBrightness = MathUtils.lerp(this.lastFingerBrightness, this.currentFingerBrightness, this.fieldTransitionLerp);
                        this.currentGlowBrightness = MathUtils.lerp(this.lastGlowBrightness, this.currentGlowBrightness, this.fieldTransitionLerp);
                        this.handVisuals.handMesh.mainPass["indexBrightness"] =
                            this.currentFingerBrightness;
                        this.tipGlowMaterialIndexTip.mainPass["pinchBrightness"] =
                            this.currentGlowBrightness;
                        this.tipGlowMaterialThumbTip.mainPass["pokeBrightness"] = 0;
                        if (this.handInteractor.currentTrigger ===
                            Interactor_1.InteractorTriggerType.Poke &&
                            !this.shouldThumbPokeGlow) {
                            this.handVisuals.handMesh.mainPass["thumbBrightness"] = 0;
                            this.tipGlowMaterialThumbTip.mainPass["pinchBrightness"] = 0;
                        }
                        else {
                            this.handVisuals.handMesh.mainPass["thumbBrightness"] =
                                this.currentFingerBrightness;
                            this.tipGlowMaterialThumbTip.mainPass["pinchBrightness"] =
                                this.currentGlowBrightness;
                        }
                        break;
                    default:
                        break;
                }
                break;
            default:
                break;
        }
        this.lastFrameField = this.handInteractor.fieldTargetingMode;
    }
    setIsInPalmUiMode(isInPalmUIMode) {
        if (isInPalmUIMode === this.isInPalmUIMode) {
            return;
        }
        this.isInPalmUIMode = isInPalmUIMode;
        this.glowEffectViewModel.palmUIModeEvent(this.isInPalmUIMode);
    }
    setIsInTargetingMode(isInTargetingMode) {
        if (isInTargetingMode === this.isInTargetingMode) {
            return;
        }
        this.isInTargetingMode = isInTargetingMode;
        this.glowEffectViewModel.targetingEvent(this.isInTargetingMode);
    }
    setIsInNearPinchMode(isInNearPinchMode) {
        if (isInNearPinchMode === this.isInNearPinchMode) {
            return;
        }
        this.isInNearPinchMode = isInNearPinchMode;
        this.glowEffectViewModel.nearPinchEvent(this.isInNearPinchMode);
    }
    setupPinchEvents() {
        this.hand.onPinchDown.add(() => {
            this.glowEffectViewModel.pinchEvent(true);
        });
        this.hand.onPinchUp.add(() => {
            this.glowEffectViewModel.pinchEvent(false);
        });
        this.hand.onPinchCancel.add(() => {
            this.glowEffectViewModel.pinchEvent(false);
        });
    }
    calculateIsInNearPinchMode() {
        var _a;
        const pinchStrength = (_a = this.hand.getPinchStrength()) !== null && _a !== void 0 ? _a : 0;
        if (pinchStrength > PINCH_STRENGTH_NEAR_PINCH_ENTER_THRESHOLD &&
            this.isInNearPinchMode === false) {
            return true;
        }
        else if (pinchStrength < PINCH_STRENGTH_NEAR_PINCH_EXIT_THRESHOLD &&
            this.hand.isPinching() === false) {
            return false;
        }
        return true;
    }
    /**
     * @returns boolean
     */
    calculateIsInTargetingMode() {
        return !this.isHandFacingCamera(this.hand);
    }
    /**
     * Cannot use this.config.hand.isFacingCamera() as that only triggers if hand
     * is facing directly at camera, where we need more broad definition
     *
     * @param hand - the BaseHand to check
     * @returns boolean
     */
    isHandFacingCamera(hand) {
        const handAngle = hand.getFacingCameraAngle();
        if (handAngle === null ||
            handAngle > HAND_FACING_CAMERA_THRESHOLD_DEGREES) {
            return false;
        }
        return true;
    }
    /*
     * isInPalmUI
     * 1) are both hands tracked
     * 2) are both hands visible / important landmarks visible in the display fov
     * 3) non dominant hand isPalmFacingCamera == true and dominant hand is not facing camera
     * 4) if distance between index finger tip and palm center is less than the threshold
     */
    calculateIsInPalmUIMode() {
        if (!this.tapGlowEnabled || !this.bothHandsTracked()) {
            return false;
        }
        const handToTapPinkyKnuckle = this.handToTap.pinkyKnuckle;
        const tappingHandIndexTip = this.hand.indexTip;
        if (handToTapPinkyKnuckle === null || tappingHandIndexTip === null) {
            return false;
        }
        const handToTapPinkyKnucklePos = handToTapPinkyKnuckle.position;
        const tappingHandIndexTipPos = tappingHandIndexTip.position;
        if (!this.camera.inFoV(handToTapPinkyKnucklePos) ||
            !this.camera.inFoV(tappingHandIndexTipPos)) {
            return false;
        }
        if (!this.isHandFacingCamera(this.handToTap) ||
            this.isHandFacingCamera(this.hand)) {
            return false;
        }
        const handToTapPalmCenterPos = this.handToTap.getPalmCenter();
        if (handToTapPalmCenterPos === null) {
            return false;
        }
        const distanceToPalmCenter = tappingHandIndexTipPos.distance(handToTapPalmCenterPos);
        if (distanceToPalmCenter >= this.config.tapProximityThreshold) {
            return false;
        }
        return true;
    }
    bothHandsTracked() {
        return (this.handProvider.getDominantHand().isTracked() &&
            this.handProvider.getNonDominantHand().isTracked());
    }
    animateIndexGlowBase(animateUp) {
        this.indexGlowStrengthCancelSet();
        (0, animate_1.default)({
            cancelSet: this.indexGlowStrengthCancelSet,
            duration: PINCH_ANIMATION_DURATION,
            easing: "ease-in-out-back-cubic",
            start: this.indexGlowBase,
            end: animateUp ? 1 : 0,
            update: (t) => {
                this.indexGlowBase = t;
            },
        });
    }
    animateIndexGlowBonus(animateUp) {
        this.indexGlowBonusCancelSet();
        (0, animate_1.default)({
            cancelSet: this.indexGlowBonusCancelSet,
            duration: PINCH_ANIMATION_DURATION,
            easing: "ease-in-out-back-cubic",
            start: this.indexGlowBonus,
            end: animateUp ? 1 : 0,
            update: (t) => {
                this.indexGlowBonus = t;
            },
        });
    }
    animateThumbGlowBase(animateUp) {
        this.thumbGlowStrengthCancelSet();
        (0, animate_1.default)({
            cancelSet: this.thumbGlowStrengthCancelSet,
            duration: PINCH_ANIMATION_DURATION,
            easing: "ease-in-out-back-cubic",
            start: this.thumbGlowBase,
            end: animateUp ? 1 : 0,
            update: (t) => {
                this.thumbGlowBase = t;
            },
        });
    }
    animateThumbGlowBonus(animateUp) {
        this.thumbGlowBonusCancelSet();
        (0, animate_1.default)({
            cancelSet: this.thumbGlowBonusCancelSet,
            duration: PINCH_ANIMATION_DURATION,
            easing: "ease-in-out-back-cubic",
            start: this.thumbGlowBonus,
            end: animateUp ? 1 : 0,
            update: (t) => {
                this.thumbGlowBonus = t;
            },
        });
    }
}
exports.GlowEffectView = GlowEffectView;
//# sourceMappingURL=GlowEffectView.js.map