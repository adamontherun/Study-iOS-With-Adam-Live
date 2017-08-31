//😘 it is 8/30/17

import UIKit
import Social

class ShareViewController: SLComposeServiceViewController {

    override func isContentValid() -> Bool {
        charactersRemaining = 30 - contentText.characters.count as NSNumber
        if contentText.characters.count > 0 && contentText.characters.count < 30 {
            return true
        }
        return false
    }
    
//    override func loadPreviewView() -> UIView! {
//        let frame = CGRect(x: 20, y: 20, width: 200, height: 200)
//        let label = UILabel(frame: frame)
//        label.text = "OK then"
//        return label
//    }

    override func didSelectPost() {

        self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
    }

    override func configurationItems() -> [Any]! {
        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
        return []
    }

}
