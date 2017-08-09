//Some text.

import UIKit

class PictureLoverViewController: UIViewController {

    @IBOutlet weak var dogImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let dropInteraction = UIDropInteraction(delegate: self)
        view.addInteraction(dropInteraction)
    }
}

extension PictureLoverViewController: UIDropInteractionDelegate {
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: UIImage.self)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        return UIDropProposal(operation: .copy)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        guard let item = session.items.first else { return }
        let provider = item.itemProvider
        
        provider.loadObject(ofClass: UIImage.self) { (image, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            } else {
                guard let image = image as? UIImage else { return }
                DispatchQueue.main.async {
                    self.dogImageView.image = image
                }
            }
        }
    }
    
}
