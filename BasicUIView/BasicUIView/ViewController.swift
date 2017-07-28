//
//  ViewController.swift
//  BasicUIView
//
//  Created by adam smith on 7/27/17.
//  Copyright © 2017 Adam Smith Software LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var parentView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        let newView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
//        newView.backgroundColor = .red
//        view.addSubview(newView)
    }


    @IBAction func handleHideButtonTapped(_ sender: Any) {
        parentView.removeFromSuperview()
    }


}

