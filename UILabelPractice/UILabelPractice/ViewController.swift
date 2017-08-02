//😘 it is 8/1/17

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var attributedLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mutableString = NSMutableAttributedString(string: "Here's a basic string with a FUN ending")
        
        let americanFont = UIFont(name: "AmericanTypewriter-Bold",size: 24.0)!
        let americanFontRange = NSRange(location: 29, length: 3)
        mutableString.addAttribute(.font, value: americanFont, range: americanFontRange)
        attributedLabel.attributedText = mutableString
    }
}

