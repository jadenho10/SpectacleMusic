// @input SceneObject so
// @input bool autoRotate

const smoothingFactor = 0.1;
const targetRotationSpeed = 0.2;
let currentRotationSpeed = 0;

const transform = script.so.getTransform();
const initRotation = transform.getLocalRotation();

let blocked = true;

function onUpdate(eventData) {
    if (blocked) {
        return;
    }
    
    const targetSpeed = script.autoRotate ? targetRotationSpeed : 0;
    
    currentRotationSpeed = lerp(currentRotationSpeed, targetSpeed, smoothingFactor);
    
    const deltaTime = eventData.getDeltaTime();
    
    var rotation = transform.getLocalRotation();
    
    var rotationY = quat.angleAxis(currentRotationSpeed * deltaTime, vec3.up());
    
    // Combine the rotations
    var newRotation = rotationY.multiply(rotation);
    
    transform.setLocalRotation(newRotation);
}

function onTouchStart() {
    script.autoRotate = false;
}

function onTouchEnd() {
    script.autoRotate = true;
}

script.createEvent("TouchStartEvent").bind(onTouchStart);
script.createEvent("UpdateEvent").bind(onUpdate);
script.createEvent("TouchEndEvent").bind(onTouchEnd);

function lerp(start, end, factor) {
    return start + (end - start) * factor;
}

script.init = function() {
    blocked = false;
    transform.setLocalRotation(initRotation);
    currentRotationSpeed = 0;
    script.autoRotate = true;
}

script.reset = function() {
    blocked = true;
    script.autoRotate = false;
    currentRotationSpeed = 0;
    transform.setLocalRotation(initRotation);
}