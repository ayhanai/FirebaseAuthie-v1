//
//  ViewController.swift
//  FirebaseAuthie-v1
//
//  Created by Sayajin Papuru on 2/13/21.
//

import UIKit

class StartViewController: UIViewController {

    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    func setUpElements() {
        Utilities.styleFilledButton(signInButton)
        Utilities.styleFilledButton(signUpButton)
    }


}

