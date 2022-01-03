//
//  HomeViewController.swift
//  Vibez
//
//  Created by Edgar López Enríquez on 01/01/22.
//

import UIKit
import Firebase
import FirebaseStorage

class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let db = Firestore.firestore()
    
    var post: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "PostCell", bundle: nil), forCellReuseIdentifier: "postCell")
        
        if let user = Auth.auth().currentUser {
            print(user)
            tableView.showLoading(style: .gray)
            db.collection("post").addSnapshotListener() { (querySnapshot, err) in
                self.post.removeAll()
                self.tableView.stopLoading()
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        let data = document.data()
                        if let userId = data["userId"] as? String,
                           let description = data["description"] as? String,
                           let likes = data["likes"] as? Int {
                            let newPost = Post(userId: userId, description: description, likes: likes)
                            self.post.append(newPost)
                            
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        }
                    }
                }
            }
        }
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
        
    }
    
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return post.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostCell
        cell.descriptionLabel.text = post[indexPath.row].description
        cell.LikesLabel.text = String(post[indexPath.row].likes)
        
        let user = post[indexPath.row].userId
        
        let docRef = db.collection("users").document(user)
        
        cell.userImageView.showLoading(style: .gray)
        docRef.getDocument { (document, error) in
            cell.userImageView.stopLoading()
            if let document = document, document.exists {
                let data = document.data()
                guard let urlString = data?["url_photo"] as? String,
                      let userName = data?["userName"] as? String,
                      let url = URL(string: urlString) else {
                          return
                      }
                
                cell.userNameLabel.text = userName
                
                cell.userImageView.showLoading(style: .gray)
                let task = URLSession.shared.dataTask(with: url, completionHandler: {data, _, error in
                    guard let data = data, error == nil else {
                        return
                    }
                    
                    DispatchQueue.main.async {
                        let image = UIImage(data: data)
                        cell.userImageView.image = image
                        cell.userImageView.makeRounded()
                        cell.userImageView.stopLoading()
                    }
                })
                
                task.resume()
            } else {
                print("Document does not exist")
            }
        }
        
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
