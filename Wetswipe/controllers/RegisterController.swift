//
//  RegisterController.swift
//  Wetswipe
//
//  Created by Adrià Bosch Saez on 24/02/2018.
//  Copyright © 2018 Adrià Bosch Saez. All rights reserved.
//

import UIKit

class RegisterController: UIViewController {
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var passwordConfirmText: UITextField!
    
    @IBAction func registerClick() {
        
        if let email = emailText.text, let password = passwordText.text,
            let confirmPassword = passwordConfirmText.text {
            
            if email.isEmpty {
                 showMessageAlert("Email can't be empty")
                return
            }
            if password.isEmpty {
                
                showMessageAlert("Password can't be empty")
                return
            }
            if password != confirmPassword {
                
                showMessageAlert("Passwords do not match")
                return
            }
            registerUser(email, password)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "Register"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func showMessageAlert(_ message: String) {
        
        let alert = UIAlertController(title: message, message: nil, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func showLoadingAlert() {
        let loadingAlert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating();
        
        loadingAlert.view.addSubview(loadingIndicator)
        present(loadingAlert, animated: true, completion: nil)
    }
    
    func registerUser(_ email: String,_ password: String) {
        showLoadingAlert()
        
        Network.instance.registerUser(email, password) { response in
            
            DispatchQueue.main.async {
            
                self.dismiss(animated: false) {
                    
                    switch(response.result) {
                        
                    case ApiResult.FAILED:
                        self.showMessageAlert("Connection error")
                        
                    case ApiResult.ERROR:
                        if (response.errorCode == -1) {
                            self.showMessageAlert("Something gone wrong")
                        } else if (response.errorCode == 0) {
                            self.showMessageAlert("Invalid credentials")
                        } else if (response.errorCode == 1) {
                            self.showMessageAlert("This email already exist")
                        }
                        
                    default:
                        self.performSegue(withIdentifier: "RegisterToMain", sender: self)
                    }
                }
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
