//
//  LoginViewController.swift
//  Udacity On The Map
//
//  Created by Sandra Adams-Hallie on Mar/29/16.
//  Copyright © 2016 Sandra Adams-Hallie. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    
/* In order for users to authenticate, the following steps need to be handled in this exact order.
(1) Get request token.
(2) Login with the API.
(3) Create a Session ID.
(4) Get the user ID.
(5) Go the next view. */

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }

    @IBAction func loginPressed(sender: AnyObject) {
            self.view.endEditing(true)
            UdacityClient.sharedInstance().authenticateLoginWithViewController(self) { (success, errorString) in
                if success {
                    self.completeLogin()
                } else {
                    self.displayMessage(errorString!)
                }
            }
        
    }
}
