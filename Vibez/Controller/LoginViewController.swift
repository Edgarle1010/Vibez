//
//  LoginViewController.swift
//  Vibez
//
//  Created by Edgar López Enríquez on 01/01/22.
//

import UIKit
import Firebase

class LoginViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.addLine(position: .bottom, color: .darkGray, width: 0.5)
        passwordTextField.addLine(position: .bottom, color: .darkGray, width: 0.5)
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switchBasedNextTextField(textField)
        return true
    }
    
    private func switchBasedNextTextField(_ textField: UITextField) {
        switch textField {
        case emailTextField:
            self.passwordTextField.becomeFirstResponder()
        case passwordTextField:
            loginButton.sendActions(for: .touchUpInside)
        default:
            self.passwordTextField.resignFirstResponder()
        }
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        self.showSpinner()
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                self.removeSpinner()
                if let error = error {
                    let showMessagePrompt = UIAlertController(title: "¡Ha ocurrido un problema!", message: "\(error.localizedDescription)", preferredStyle: .alert)
                    showMessagePrompt.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Defalut action"), style: .default, handler: { (_) in
                        NSLog(error.localizedDescription)
                    }))
                    self.present(showMessagePrompt, animated: true, completion: nil)
                    return
                }
                
                self.performSegue(withIdentifier: "LoginToHome", sender: self)
            }
        }
    }
    
}
