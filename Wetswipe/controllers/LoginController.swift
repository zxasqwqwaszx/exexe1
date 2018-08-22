//
//  LoginController.swift
//  Wetswipe
//
//  Created by Adrià Bosch Saez on 24/02/2018.
//  Copyright © 2018 Adrià Bosch Saez. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    @IBAction func facebookClick() {
        // TODO
    }
    
    @IBAction func loginClick() {
        
        if let email = emailText.text , let password = passwordText.text {
            
            if email.isEmpty {
                showMessageAlert("email can't be empty")
                return
            }
            if password.isEmpty {
                showMessageAlert("password can't be empty")
                return
            }
            self.performSegue(withIdentifier: "LoginToMain", sender: self)
        }
    }
    
    @IBAction func registerClick() {
        
        self.performSegue(withIdentifier: "LoginToRegister", sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "Login"
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
