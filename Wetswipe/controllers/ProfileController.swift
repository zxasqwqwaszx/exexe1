//
//  ProfileController.swift
//  Wetswipe
//
//  Created by Adrià Bosch Saez on 25/02/2018.
//  Copyright © 2018 Adrià Bosch Saez. All rights reserved.
//

import UIKit

class ProfileController: UIViewController {

    @IBAction func editProfileClick() {
        
        self.performSegue(withIdentifier: "ProfileToEdit", sender: self)
    }
    
    @IBAction func settingsClick() {
        
        self.performSegue(withIdentifier: "ProfileToSettings", sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "Profile"
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