//😘 it is 8/24/17

import UIKit
import BirdKit
import MobileCoreServices


class ViewController: UIViewController {

    @IBOutlet weak var birdNameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        BirdCallGenerator.makeBirdCall()
    }
    
    @IBAction func handleShareActionTapped(_ sender: Any) {

        let activityViewController = UIActivityViewController(activityItems: [birdNameLabel.text!], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
        
        activityViewController.completionWithItemsHandler = {
            (activityType, completed, returnedItems, error) in
            
            guard
                let returnedItems = returnedItems,
                returnedItems.count > 0,
                let textItem = returnedItems.first as? NSExtensionItem,
                let textItemProvider = textItem.attachments?.first as? NSItemProvider,
                textItemProvider.hasItemConformingToTypeIdentifier(kUTTypeText as String)
                else { return }
            
            textItemProvider.loadItem(forTypeIdentifier: kUTTypeText as String, options: nil, completionHandler: { (string, error) in
                guard
                    error == nil,
                    let newText = string as? String else { return }
                DispatchQueue.main.async {
                    self.birdNameLabel.text = newText
                }
            })
            
        }
    }
    
}

