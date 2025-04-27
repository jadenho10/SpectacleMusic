// @input SceneObject camera

const transform = script.camera.getTransform();

const EPS = 0.001;

let radius = 200;
let azimuth = Math.PI / 2 // [0, 2 * Math.PI)
let polar = Math.PI / 2; // (0, Math.PI)

let touchStartPosition = null;
let touchStartAzimuth = null;
let touchStartPolar = null;
let touchStartRadius = null;

let blocked = true;

function remap(value, a, b, x, y) {
  return x + ((value - a) * (y - x)) / (b - a);
}

function clamp(value, min, max) {
    return Math.max(min, Math.min(value, max));
}

function calculateCoords(radius, azimuth, polar) {
    return new vec3(
        radius * Math.sin(polar) * Math.cos(azimuth),
        radius * Math.cos(polar),
        radius * Math.sin(polar) * Math.sin(azimuth),
    );
}

script.createEvent("UpdateEvent").bind(onUpdate);

function onTouchStart(eventData) {
    if (blocked) {
        return;
    }
    
    touchStartPosition = eventData.getTouchPosition();
    touchStartAzimuth = azimuth;
    touchStartPolar = polar;
    touchStartRadius = radius;
}

function onTouchMove(eventData) {
    if (blocked) {
        return;
    }
    
    
    currentTouchPosition = eventData.getTouchPosition();
    
    deltaTouch = currentTouchPosition.sub(touchStartPosition);
    
    const azimuthDelta = remapXToAzimuth(deltaTouch.x);
    const polarDelta = remapYToPolar(-deltaTouch.y);
    
    azimuth = (touchStartAzimuth + azimuthDelta) % (2 * Math.PI);
    polar = clamp(touchStartPolar + polarDelta, EPS, Math.PI - EPS);
}

function onTouchEnd(eventData) {
    if (blocked) {
        return;
    }
    
    touchStartPosition = null;
}

function onUpdate(eventData) {
    if (blocked) {
        return;
    }
    
    const newPos = calculateCoords(radius, azimuth, polar);
    transform.setWorldPosition(newPos);
}

function remapXToAzimuth(deltaX) {
    return remap(
        deltaX,
        -1,
        1,
        -2 * Math.PI,
        2 * Math.PI
    );
}

function remapYToPolar(deltaY) {
    return remap(
        deltaY,
        -1, 
        1,
        -Math.PI,
        Math.PI
    );
}

script.createEvent("TouchStartEvent").bind(onTouchStart);
script.createEvent("TouchMoveEvent").bind(onTouchMove);
script.createEvent("TouchEndEvent").bind(onTouchEnd);

function restoreDefaults() {
    radius = 200;
    azimuth = Math.PI / 2;
    polar = Math.PI / 2;

    touchStartPosition = null;
    touchStartAzimuth = null;
    touchStartPolar = null;
    touchStartRadius = null;
    
    const newPos = calculateCoords(radius, azimuth, polar);
    transform.setWorldPosition(newPos);
}

script.init = function() {
    blocked = false;
    restoreDefaults();
}

script.reset = function() {
    restoreDefaults();
    blocked = true;
}