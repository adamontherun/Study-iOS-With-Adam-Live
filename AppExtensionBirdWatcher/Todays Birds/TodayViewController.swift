//😘 it is 8/24/17

import UIKit
import NotificationCenter
import BirdKit

class TodayViewController: UIViewController, NCWidgetProviding {
    
    @IBOutlet weak var stackView: UIStackView!
    private var birds = [UIImageView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        extensionContext?.widgetLargestAvailableDisplayMode = .expanded
        BirdCallGenerator.makeBirdCall()
    }
    

    @IBAction func handleButtonWasTapped(_ sender: Any) {
        let url = URL(string: "birdApp://")!
        extensionContext?.open(url, completionHandler: nil)
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        
        birds.forEach{ stackView.removeArrangedSubview($0)}
        birds.removeAll()
        birds = BirdFetcher.fetchFeaturedBirds()

        if birds.count > 0 {
           birds.forEach{ stackView.insertArrangedSubview($0, at: 0) }
            completionHandler(NCUpdateResult.newData)
        } else {
            completionHandler(NCUpdateResult.noData)
        }
    }
    
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        switch activeDisplayMode {
        case .compact:
            preferredContentSize = maxSize
        case .expanded:
            preferredContentSize = maxSize
        }
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (context) in
            if size.height > 111 {
                self.view.backgroundColor = .red
            } else {
                self.view.backgroundColor = .green
            }
        }) { (context) in
            print("done animating.")
        }
    }
}
