//😘 it is 8/2/17

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var dragSourceView: UIView!
    @IBOutlet weak var dropSourceView: UIView!
    @IBOutlet weak var testLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let dragInteraction = UIDragInteraction(delegate: self)
        dragSourceView.addInteraction(dragInteraction)
        
        let dropInteraction = UIDropInteraction(delegate: self)
        dropSourceView.addInteraction(dropInteraction)
    }
}

extension ViewController: UIDragInteractionDelegate {
    
    func dragInteraction(_ interaction: UIDragInteraction, itemsForBeginning session: UIDragSession) -> [UIDragItem] {
        let itemProvider = NSItemProvider(object: "Hello World!" as NSString)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        return [dragItem]
    }
    
    func dragInteraction(_ interaction: UIDragInteraction, previewForLifting item: UIDragItem, session: UIDragSession) -> UITargetedDragPreview? {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "helloworld"))
        let dragView = interaction.view!
        let dragPoint = session.location(in: dragView)
        let target = UIDragPreviewTarget(container: dragView, center: dragPoint)
        return UITargetedDragPreview(view: imageView, parameters: UIDragPreviewParameters(), target: target)
    }
    
    func dragInteraction(_ interaction: UIDragInteraction, sessionDidMove session: UIDragSession) {
        //print(session.location(in: view))
    }
    
    func dragInteraction(_ interaction: UIDragInteraction, session: UIDragSession, didEndWith operation: UIDropOperation) {
        print("drag interaction finished")
    }
    func dragInteraction(_ interaction: UIDragInteraction, willAnimateLiftWith animator: UIDragAnimating, session: UIDragSession) {
        animator.addAnimations {
            self.view.alpha = 0.7
        }
        
//        animator.addCompletion { (position) in
//            switch position {
//            case .start:
//                self.view.backgroundColor = .green
//            case .end:
//                self.view.backgroundColor = .orange
//            case .current:
//                self.view.backgroundColor = .blue
//            }
//        }
    }
    
    func dragInteraction(_ interaction: UIDragInteraction, item: UIDragItem, willAnimateCancelWith animator: UIDragAnimating) {
        animator.addAnimations {
            print("animate an update to the UI with cancelation of drag")
        }
    }
    
    func dragInteraction(_ interaction: UIDragInteraction, sessionDidTransferItems session: UIDragSession) {
        print("All of the data is transfered")
    }
    
    func dragInteraction(_ interaction: UIDragInteraction, sessionAllowsMoveOperation session: UIDragSession) -> Bool {
        return false
    }
    
}

extension ViewController: UIDropInteractionDelegate {
    
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: NSString.self)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        return UIDropProposal(operation: .copy)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        session.loadObjects(ofClass: NSString.self) { (messages) in
            let messages = messages as! [NSString]
            self.testLabel.text = messages.first! as String
        }
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidEnter session: UIDropSession) {
        print("hovering at point \(session.location(in: dropSourceView))")
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidExit session: UIDropSession) {
        print("exit")
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, item: UIDragItem, willAnimateDropWith animator: UIDragAnimating) {
        animator.addAnimations {
            self.view.alpha = 1.0
        }
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, previewForDropping item: UIDragItem, withDefault defaultPreview: UITargetedDragPreview) -> UITargetedDragPreview? {
//        let imageView = UIImageView(image: #imageLiteral(resourceName: "helloworld2"))
//        let dragPoint = dropView.center
//        let target = UIDragPreviewTarget(container: dropView, center: dragPoint)
//        return UITargetedDragPreview(view: imageView, parameters: UIDragPreviewParameters(), target: target)
        return nil
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidEnd session: UIDropSession) {
        print("and we're done")
    }
}

