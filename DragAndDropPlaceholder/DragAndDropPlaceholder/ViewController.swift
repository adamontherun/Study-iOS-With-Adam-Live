//😘 it is 8/9/17

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var donkeyImageView: UIImageView!
    let photo = Photo(image: #imageLiteral(resourceName: "donkey"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        donkeyImageView.image = photo.image
        let dragInteraction = UIDragInteraction(delegate: self)
        donkeyImageView.addInteraction(dragInteraction)
        donkeyImageView.isUserInteractionEnabled = true
    }
}

extension ViewController: UIDragInteractionDelegate {
    func dragInteraction(_ interaction: UIDragInteraction, itemsForBeginning session: UIDragSession) -> [UIDragItem] {
        let itemProvider = NSItemProvider(object: photo)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        return [dragItem]
    }
 
}

