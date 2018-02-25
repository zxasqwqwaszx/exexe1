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
    
    @IBOutlet weak var registerButton: UIButton!
    
    @IBAction func registerClick() {
        
        if let email = emailText.text , let password1 = passwordText.text,
            let password2 = passwordConfirmText.text {
            
            if email.isEmpty {
                
                 showAlert(message: "Email can't be empty")
                return
            }
            if password1.isEmpty {
                
                showAlert(message: "Password can't be empty")
                return
            }
            if password1 != password2 {
                
                showAlert(message: "Passwords do not match")
                return
            }
            
             self.performSegue(withIdentifier: "RegisterToMain", sender: self)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "Register"
    }
    
    func showAlert(message: String) {
        
        let alert = UIAlertController(title: message, message: nil, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
