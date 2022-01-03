//
//  SigninViewController.swift
//  Vibez
//
//  Created by Edgar López Enríquez on 01/01/22.
//

import UIKit
import Firebase
import FirebaseStorage

class SigninViewController: UIViewController, UIImagePickerControllerDelegate, UITextFieldDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    let db = Firestore.firestore()
    let storage = Storage.storage().reference()
    
    let imagePicker = UIImagePickerController()
    var imageProfile = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userImageView.makeRounded()
        userNameTextField.addLine(position: .bottom, color: .darkGray, width: 0.5)
        emailTextField.addLine(position: .bottom, color: .darkGray, width: 0.5)
        passwordTextField.addLine(position: .bottom, color: .darkGray, width: 0.5)
        
        userNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switchBasedNextTextField(textField)
        return true
    }
    
    private func switchBasedNextTextField(_ textField: UITextField) {
        switch textField {
        case userNameTextField:
            emailTextField.becomeFirstResponder()
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            signInButton.sendActions(for: .touchUpInside)
        default:
            self.passwordTextField.resignFirstResponder()
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let userPickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            userImageView.image = userPickedImage
            imageProfile = userPickedImage
        }
    
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addImagePressed(_ sender: UIButton) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func signInPressed(_ sender: UIButton) {
        
        guard let imageData = self.imageProfile.pngData() else {
            let showMessagePrompt = UIAlertController(title: "¡Ha ocurrido un problema!", message: "Para continuar necesitas subir una foto", preferredStyle: .alert)
            showMessagePrompt.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Defalut action"), style: .default, handler: { (_) in
                
            }))
            self.present(showMessagePrompt, animated: true, completion: nil)
            return
        }
        
        if let userName = userNameTextField.text,
            let email = emailTextField.text,
            let password = passwordTextField.text {
            showSpinner()
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                self.removeSpinner()
                if let error = error {
                    let showMessagePrompt = UIAlertController(title: "¡Ha ocurrido un problema!", message: "\(error.localizedDescription)", preferredStyle: .alert)
                    showMessagePrompt.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Defalut action"), style: .default, handler: { (_) in
                        NSLog(error.localizedDescription)
                    }))
                    self.present(showMessagePrompt, animated: true, completion: nil)
                    return
                } else {
                    if let user = Auth.auth().currentUser {
                        let changeRequest = user.createProfileChangeRequest()
                        changeRequest.displayName = userName
                        self.showSpinner()
                        changeRequest.commitChanges { (error) in
                            self.removeSpinner()

                            self.showSpinner()
                            self.storage.child("profilePictures/\(user.uid)/profileImage.jpg").putData(imageData, metadata: nil, completion: { _, error in
                                self.removeSpinner()
                                if let error = error {
                                    print("Failed upload, \(error.localizedDescription)")
                                } else {
                                    self.showSpinner()
                                    self.storage.child("profilePictures/\(user.uid)/profileImage.jpg").downloadURL { url, error in
                                        self.removeSpinner()
                                        guard let url = url, error == nil else {
                                            print("Failed upload, \(String(describing: error?.localizedDescription))")
                                            return
                                        }
                                        
                                        let urlString = url.absoluteString
                                        print("Download URL: \(urlString)")
                                        
                                        let docData: [String: Any] = [
                                            "userName": userName,
                                            "email": email,
                                            "url_photo": urlString
                                        ]
                                        self.showSpinner()
                                        self.db.collection("users").document(user.uid).setData(docData) { err in
                                            self.removeSpinner()
                                            if let err = err {
                                                print("Error writing document: \(err)")
                                            } else {
                                                self.performSegue(withIdentifier: "SigninToHome", sender: self)
                                            }
                                        }
                                    }
                                }
                            })
                        }
                    }
                }
            }
        }
    }
    
}
