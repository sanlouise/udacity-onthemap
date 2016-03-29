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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }

    @IBAction func loginPressed(sender: AnyObject) {
        UdacityClient.sharedInstance().authenticateLoginWithViewController(self) { (success, errorString) in
            performUIUpdatesOnMain {
                if success {
                    self.completeLogin()
                } else {
                    self.displayError(errorString)
                }
            }
        }
    }
    
    // MARK: Login
    
    private func completeLogin() {
        let controller = storyboard!.instantiateViewControllerWithIdentifier("WhenLoggedIn") as! UINavigationController
        presentViewController(controller, animated: true, completion: nil)
    }
    
    private func displayError(errorString: String?) {
        if let errorString = errorString {
            loginLabel.text = errorString
        }
    }
    
}


