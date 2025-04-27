// @input SceneObject placeholder
// @input Asset.Material materialHolder
// @input Component.ScriptComponent uniqueRenderLayersController
// @input Asset.RemoteMediaModule mediaModule
// @input Component.ScriptComponent lensCommunication
// @input SceneObject planes

let rootSceneObject = null;
let mesh = null;

script.downloadMesh = function(url) {
    script.mediaModule.loadAsGltfAsset(
        url,    
        (glTFAsset) => {
            rootSceneObject = glTFAsset.tryInstantiate(script.placeholder, script.materialHolder);     
            updateLayers(rootSceneObject, script.placeholder.layer);
            try {
                mesh = rootSceneObject.getChild(0).getChild(0).getChild(0).getComponent("Component.RenderMeshVisual");
                let transform = mesh.getTransform().getWorldTransform();
                let d1 = transform.multiplyPoint(mesh.mesh.aabbMin);
                let d2 = transform.multiplyPoint(mesh.mesh.aabbMax);
                
                let height = Math.min(d1.y, d2.y);
                
                let pos = script.planes.getTransform().getWorldPosition();
                pos.y = height;
                script.planes.getTransform().setWorldPosition(pos);
                
                mesh.meshShadowMode = MeshShadowMode.Caster;
                mesh.shadowDensity = 1;
                mesh.shadowColor = new vec4(0, 0, 0, 255);
            
                script.lensCommunication.init();
            } catch(error) {
            }
        },
        (error) => {
        }
    );
}

function updateLayers(root, layerSet) {
    if (root) {
        root.layer = layerSet;    
        
        const childrenCount = root.getChildrenCount();
        for (let i = 0; i < childrenCount; i++) {
            updateLayers(root.getChild(i), layerSet);
        }
    }
}

script.clearMesh = function() {
    if (rootSceneObject) {
        rootSceneObject.destroy();
        rootSceneObject = null;
        mesh = null;
        script.planes.getTransform().setWorldPosition(new vec3(0, 0, 0));
    }
}