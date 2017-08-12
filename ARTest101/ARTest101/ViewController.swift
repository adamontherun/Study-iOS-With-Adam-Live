//😘 it is 8/11/17

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController {
    
    var sceneView: ARSCNView!

    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView = ARSCNView(frame: view.frame)
        view.addSubview(sceneView)
        
        let box = SCNBox(width: 0.6, height: 0.6, length: 0.6, chamferRadius: 0)
        let material = SCNMaterial()
        material.diffuse.contents = #imageLiteral(resourceName: "camo")
        
        let node = SCNNode(geometry: box)
        node.geometry?.materials = [material]
        node.position = SCNVector3(0,0, -0.9)
        
        let torus = SCNTorus(ringRadius: 0.1, pipeRadius: 0.1)
        let torusMaterial = SCNMaterial()
        torusMaterial.diffuse.contents = #imageLiteral(resourceName: "sheer")
        let torusNode = SCNNode(geometry: torus)
        torusNode.geometry?.materials = [torusMaterial]
        torusNode.position = SCNVector3(0, 0, -0.5)
        
        let scene = SCNScene()
        scene.rootNode.addChildNode(node)
        scene.rootNode.addChildNode(torusNode)
        sceneView.scene = scene
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(gestureRecognizer:)))
        sceneView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc private func handleTap(gestureRecognizer recognizer: UIGestureRecognizer) {
        guard let sceneView = recognizer.view as? SCNView else { return }
        let touchPoint = recognizer.location(in: sceneView)
        
        let results = sceneView.hitTest(touchPoint, options: nil)
        print(results.count)
        guard let node = results.last?.node else { return }
        
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.cyan
        node.geometry?.materials = [material]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }

}

extension ViewController: ARSCNViewDelegate {
    
}

