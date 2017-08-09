//Some text.

import UIKit

class DogLoverViewController: UIViewController {

    @IBOutlet weak var dogImageView: UIImageView!
    @IBOutlet weak var maxBarkLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        maxBarkLabel.text = nil
        let dropInteraction = UIDropInteraction(delegate: self)
        view.addInteraction(dropInteraction)
    }
}

extension DogLoverViewController: UIDropInteractionDelegate {
    
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: Dog.self)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        return UIDropProposal(operation: .copy)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        guard let item = session.items.first  else { return }
        let provider = item.itemProvider
        provider.loadObject(ofClass: Dog.self) { (theDog, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                DispatchQueue.main.async {
                    guard let dog = theDog as? Dog else { return }
                    self.dogImageView.image = dog.image
                    if let maxBarkVolume = dog.maxBarkVolume {
                        self.maxBarkLabel.text = "max is: \(maxBarkVolume)"
                    }
                }
            }
        }
    }
}
