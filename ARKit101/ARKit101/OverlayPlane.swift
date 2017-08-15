//Some text.

import UIKit
import ARKit

class OverlayPlane: SCNNode {
    
    var anchor : ARPlaneAnchor
    var planeGeometery: SCNPlane!

     init(anchor: ARPlaneAnchor) {
        self.anchor = anchor
        super.init()
        setup()
    }
    
    private func setup() {
        planeGeometery = SCNPlane(width: CGFloat(anchor.extent.x), height: CGFloat(anchor.extent.z))
        let material = SCNMaterial()
        material.diffuse.contents = #imageLiteral(resourceName: "grid")
        planeGeometery.materials = [material]
        let planeNode = SCNNode(geometry: planeGeometery)
        planeNode.position = SCNVector3Make(anchor.center.x, 0, anchor.center.z)
        planeNode.transform = SCNMatrix4MakeRotation(Float(-Double.pi / 2.0), 1.0, 0, 0)
        self.addChildNode(planeNode)
    }
    
    func update(anchor: ARPlaneAnchor) {
        planeGeometery.width = CGFloat(anchor.extent.x)
        planeGeometery.height = CGFloat(anchor.extent.z)
        position = SCNVector3Make(anchor.center.x, 0, anchor.center.z)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
