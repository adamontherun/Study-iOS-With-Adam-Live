//😘 it is 8/28/17

import UIKit
import MobileCoreServices
import BirdKit

class ActionViewController: UIViewController {

    @IBOutlet weak var scienceNameLabel: UILabel!
    @IBOutlet weak var commonNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        
//        guard
//            let context = extensionContext,
//           let extensionItem = context.inputItems.first as? NSExtensionItem
//      
//        else { return }
//              let firstAttachments = extensionItem.attachments
//              let contentItem = firstAttachments?.first as? NSItemProvider
        
        
        let textItem = extensionContext!.inputItems[0] as! NSExtensionItem
        let textItemProvider = textItem.attachments![0] as! NSItemProvider
        
        if textItemProvider.hasItemConformingToTypeIdentifier(kUTTypeText as String) {
            textItemProvider.loadItem(forTypeIdentifier: kUTTypeText as String, options: nil, completionHandler: { (result, error) in
                let commonName = result as? String
                self.commonNameLabel.text = commonName
                if self.commonNameLabel != nil {
                    self.scienceNameLabel.text = BirdNameTranslator.translate(commonName: commonName!)
                }
            })
        }
    }


    @IBAction func done() {
        
        let returnProvider = NSItemProvider(item: scienceNameLabel.text! as NSSecureCoding, typeIdentifier: kUTTypeText as String)
        let returnItem = NSExtensionItem()
        returnItem.attachments = [returnProvider]
        extensionContext!.completeRequest(returningItems: [returnItem], completionHandler: nil)
    }
}
