//
//  AppManager.swift
//  Vibez
//
//  Created by Edgar López Enríquez on 01/01/22.
//

import UIKit
import Firebase
 
class AppManager {
    static let shared = AppManager()
    private let storyboard = UIStoryboard(name: "Main", bundle: nil)
    var appContainer: WelcomeViewController!
    private init() { }
    
    func showApp() {
        var viewController: UIViewController
        if Auth.auth().currentUser != nil {
            self.appContainer.showSpinner()
            viewController = storyboard.instantiateViewController(withIdentifier: "TabBarController")
            appContainer.navigationController?.pushViewController(viewController, animated: true)
            self.appContainer.removeSpinner()
        }
    }
    
}
