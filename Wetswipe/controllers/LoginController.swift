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
    
  
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    
    @IBAction func facebookClick() {
        
        
    }
    
    
    @IBAction func loginClick() {
        
        if let email = emailText.text , let password = passwordText.text {
            if email.isEmpty {
                
                showAlert(message: "email can't be empty")
                return
            }
            if password.isEmpty {
                
                showAlert(message: "password can't be empty")
                return
            }
            
            self.performSegue(withIdentifier: "LoginToMain", sender: self)
            
        }
    }
    
    func showAlert(message: String) {
        
        let alert = UIAlertController(title: message, message: nil, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func registerClick() {
        
        self.performSegue(withIdentifier: "LoginToRegister", sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "Login"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
