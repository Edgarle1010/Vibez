//
//  TabBarViewController.swift
//  Vibez
//
//  Created by Edgar López Enríquez on 01/01/22.
//

import UIKit
import Firebase

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    @IBOutlet weak var logOutButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
        
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Tendencias"
    }

    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "¿Quieres salir de tu cuenta?", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Volver", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Sí, salir", style: .cancel, handler: { (action) in
            do {
                try Auth.auth().signOut()
                self.navigationController?.popToRootViewController(animated: true)
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }
        }))
        self.present(alert, animated: true)
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
    }

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let currentVC = viewController.restorationIdentifier {
            switch currentVC {
            case "HomeViewController":
                self.navigationItem.title = "Publicaciones"
            case "ChatViewController":
                self.navigationItem.title = "Mensajes"
            case "AddViewController":
                self.navigationItem.title = "Datos"
            case "NotificationsViewController":
                self.navigationItem.title = "Notificaciones"
            case "UserDetailsViewController":
                self.navigationItem.title = "Cuenta"
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                self.navigationItem.rightBarButtonItem?.tintColor = UIColor.black
            default:
                break;
            }
            
            if currentVC != "UserDetailsViewController" {
                self.navigationItem.rightBarButtonItem?.isEnabled = false
                self.navigationItem.rightBarButtonItem?.tintColor = UIColor.clear
            }
        }
    }
}
