//😘 it is 8/14/17

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate, ARSessionDelegate {
    
    private var planes = [OverlayPlane]()
    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        let scene = SCNScene()
        sceneView.scene = scene
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        sceneView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc private func handleTap(_ recognizer: UIGestureRecognizer) {
        let postion = recognizer.location(in: sceneView)
        
        guard let hitResult = sceneView.hitTest(postion, types: .existingPlane).first else { return }
        
        let cubeNode = SCNNode(geometry: SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0))
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.cyan
        cubeNode.position = SCNVector3(hitResult.worldTransform.columns.3.x, hitResult.worldTransform.columns.3.y + 0.3, hitResult.worldTransform.columns.3.z)
        sceneView.scene.rootNode.addChildNode(cubeNode)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let overlayPlane = planes.first(where: {$0.anchor.identifier == anchor.identifier}),
            let anchor = anchor as? ARPlaneAnchor
            else { return }
        overlayPlane.update(anchor: anchor)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        let planeNode = OverlayPlane(anchor: planeAnchor)
        planes.append(planeNode)
        node.addChildNode(planeNode)
    }
    
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        
    }

}
