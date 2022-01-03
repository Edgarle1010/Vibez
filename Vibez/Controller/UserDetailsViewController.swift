//
//  UserDetailsViewController.swift
//  Vibez
//
//  Created by Edgar López Enríquez on 01/01/22.
//

import UIKit
import Firebase

class UserDetailsViewController: UIViewController {
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userImageView.makeRounded()
        
        loadDataUser()
    }
    
    func loadDataUser() {
        
        if let user = Auth.auth().currentUser {
            userNameLabel.text = user.displayName
            let docRef = db.collection("users").document(user.uid)
            
            userImageView.showLoading(style: .gray)
            docRef.getDocument { (document, error) in
                self.userImageView.stopLoading()
                if let document = document, document.exists {
                    let data = document.data()
                    guard let urlString = data?["url_photo"] as? String,
                          let url = URL(string: urlString) else {
                              return
                          }
                    
                    self.userImageView.showLoading(style: .gray)
                    let task = URLSession.shared.dataTask(with: url, completionHandler: {data, _, error in
                        guard let data = data, error == nil else {
                            return
                        }
                        
                        DispatchQueue.main.async {
                            let image = UIImage(data: data)
                            self.userImageView.image = image
                            self.userImageView.stopLoading()
                        }
                    })
                    
                    task.resume()
                } else {
                    print("Document does not exist")
                }
            }
        }
    }
    
}
