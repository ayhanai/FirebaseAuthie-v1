//
//  SignUpViewController.swift
//  FirebaseAuthie-v1
//
//  Created by Sayajin Papuru on 2/13/21.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    func showError(_ message: String) {
        
            errorLabel.text = message
            errorLabel.alpha = 1
    }
    
    func validateFields() -> String? {
        //Check that all fields are filled in
        if (firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)) == "" ||
            lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
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
    
    @IBAction func backTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func signUpTapped(_ sender: UIButton) {
        //Validate the fields
        let error = validateFields()

        if error != nil {
            //There's something wrong with the fields
           showError(error!)
        } else {
            
            //Create cleaned version of the data
            let firstname = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastname = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //Create user
            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                //Check errors
                if error != nil {
                    //There was an error creating user
                    self.showError("Error creating user")
                } else {
                    //User was created successfully
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: ["firstname": firstname, "lastname": lastname, "uid": result!.user.uid]) { (error) in
                        if error != nil {
                            self.showError("User's data couldn't be synced whith our database")
                        }
                    }
                    
                    self.transitionToHome()
                }

            
            }
        }
    }
    
    func transitionToHome() {
        let homeViewController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as? HomeViewController
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    
    
    func setUpElements() {
        Utilities.styleTextField(firstNameTextField)
        Utilities.styleTextField(lastNameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        
        Utilities.styleFilledButton(signUpButton)
        errorLabel.alpha = 0
    }
}
