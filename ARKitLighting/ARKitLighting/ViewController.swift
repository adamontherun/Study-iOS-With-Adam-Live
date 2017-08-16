//😘 it is 8/15/17

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.delegate = self
        
        // Create a new scene
        let scene = SCNScene()
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        // Set the scene to the view
        sceneView.scene = scene
        
        //sceneView.autoenablesDefaultLighting = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        sceneView.addGestureRecognizer(tapGestureRecognizer)
        insertSpotlight()
    }
    
    @objc private func handleTap(_ recognzier: UIGestureRecognizer) {
        let touchPoint = recognzier.location(in: sceneView)
        guard let hitResult = sceneView.hitTest(touchPoint, types: .featurePoint).first else { return }
        let cubeNode = SCNNode(geometry: SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0))
        cubeNode.position = SCNVector3(hitResult.worldTransform.columns.3.x, hitResult.worldTransform.columns.3.y, hitResult.worldTransform.columns.3.z)
//
//        let material = SCNMaterial()
//        material.lightingModel = .physicallyBased
//        material.diffuse.contents = #imageLiteral(resourceName: "sandstonecliff-albedo")
//        material.roughness.contents = #imageLiteral(resourceName: "sandstonecliff-roughness")
//        material.metalness.contents = #imageLiteral(resourceName: "sandstonecliff-metalness")
//        material.normal.contents = #imageLiteral(resourceName: "sandstonecliff-normal-ue")
//
//        cubeNode.geometry?.materials = [material]
        
        sceneView.scene.rootNode.addChildNode(cubeNode)
    }
    
    private func insertSpotlight() {
        let spotLight = SCNLight()
        spotLight.type = .spot
        spotLight.spotInnerAngle = 45
        spotLight.spotOuterAngle = 45
        
        let spotLightNode = SCNNode()
        spotLightNode.light = spotLight
        spotLightNode.name = "SpotNode"
        spotLightNode.position = SCNVector3(0, 1.0, 0)
        spotLightNode.eulerAngles = SCNVector3Make(-Float.pi / 2, 0, -0.2)
        
        sceneView.scene.rootNode.addChildNode(spotLightNode)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    


    // MARK: - ARSCNViewDelegate

    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        guard let lightEstimate = sceneView.session.currentFrame?.lightEstimate,
        let spotNode = sceneView.scene.rootNode.childNode(withName: "SpotNode", recursively: true)
        else { return }
        spotNode.light?.intensity = lightEstimate.ambientIntensity
    }

}
