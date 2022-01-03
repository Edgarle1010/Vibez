//
//  ViewController.swift
//  Vibez
//
//  Created by Edgar López Enríquez on 30/12/21.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AppManager.shared.appContainer = self
        AppManager.shared.showApp()
    }


}

