//
//  SignInViewController.swift
//  FirebaseAuthie-v1
//
//  Created by Sayajin Papuru on 2/13/21.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    @IBAction func signInTapped(_ sender: UIButton) {
        //Validate all fields
        let error = validateFields()
        
        if error != nil {
            //There's an error
            showError(error!)
        } else {
            //Create cleaned version of the data
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        //Sign In the user
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                
                if error != nil {
                    self.errorLabel.text = error?.localizedDescription
                    self.errorLabel.alpha = 1
                } else {
                    //Transition to home view
                    self.transitionToHome()
                }
            }
        }
    }
    
    @IBAction func backTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    func setUpElements() {
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        
        Utilities.styleFilledButton(signInButton)
        errorLabel.alpha = 0
    }
    
    func transitionToHome() {
        let homeViewController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as? HomeViewController
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    
    func validateFields() -> String? {
        //Check that all fields are filled in
        
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
           passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields."
        }
        
        //Check if password is secured
        let securedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.isPasswordSecured(securedPassword) == false {
            //Password isn't secure enough
            
            return "Please make sure your password is at least 8 characters, contains one special character and a number"
        }
        return nil
    }
    
    func showError(_ message: String) {
        
            errorLabel.text = message
            errorLabel.alpha = 1
    }
}
