//
//  ProfileController.swift
//  Wetswipe
//
//  Created by Adrià Bosch Saez on 25/02/2018.
//  Copyright © 2018 Adrià Bosch Saez. All rights reserved.
//

import UIKit

class ProfileController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameAgeText: UILabel!
    @IBOutlet weak var descriptionField: UITextField!
    @IBOutlet weak var workField: UITextField!
    @IBOutlet weak var collegeField: UITextField!
    @IBOutlet weak var songField: UITextField!
    
    private let wetswipeApi = WetswipeApi.instance
    
    @IBAction func saveClick(_ sender: Any) {
        
        let updateProfile = UpdateProfile(
            description: descriptionField.text!,
            currentWork: workField.text!,
            college: collegeField.text!,
            favoriteSong: songField.text!)
        
        wetswipeApi.updateProfile(updateProfile) { response  in
            
            DispatchQueue.main.async {
                
                switch(response.result) {
                    
                case ApiResult.FAILED:
                    self.showMessageAlert("Connection error")
                    
                case ApiResult.ERROR:
                    self.showMessageAlert("Something gone wrong")
                    
                    
                default:
                    print("ok")
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "Profile"
        
        wetswipeApi.getUser() { response  in
            
            DispatchQueue.main.async {
                
                switch(response.result) {
                    
                case ApiResult.FAILED:
                    self.showMessageAlert("Connection error")
                    
                case ApiResult.ERROR:
                    self.showMessageAlert("Something gone wrong")
                    
                    
                default:
                    self.setUserFields(response.content!)
                }
            }
        }
    }
    
    func setUserFields(_ user: User) {
        
        if (user.photos.count > 0) {
            imageView.sd_setImage(with: URL(string: user.photos[0]))
        } else {
            imageView.sd_setImage(with: URL(string: "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973461_960_720.png"))
        }
        
        nameAgeText.text = user.name + ", " + String(user.age)
        descriptionField.text = user.description
        workField.text = user.currentWork
        collegeField.text = user.college
        songField.text = user.favoriteSong
    }
    
    func showMessageAlert(_ message: String) {
        let alert = UIAlertController(title: message, message: nil, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
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
