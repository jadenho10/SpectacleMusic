"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Config = void 0;
const ObservableProperty_1 = require("./ObservableProperty");
var Config;
(function (Config) {
    Config.MaxAttachScreenDistance = 0.01;
    Config.isSnappingEnabled = new ObservableProperty_1.ObservableProperty(false);
    Config.isRecalculateEnabled = new ObservableProperty_1.ObservableProperty(false);
    Config.isIsolated = new ObservableProperty_1.ObservableProperty(false);
    Config.isRulerEnabled = new ObservableProperty_1.ObservableProperty(true);
    Config.isGuideEnabled = new ObservableProperty_1.ObservableProperty(false);
    Config.isSnappingToGuideEnabled = new ObservableProperty_1.ObservableProperty(false);
})(Config || (exports.Config = Config = {}));
//# sourceMappingURL=Config.js.map