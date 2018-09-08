//
//  CreateProfileController.swift
//  Wetswipe
//
//  Created by Adrià Bosch Saez on 23/08/2018.
//  Copyright © 2018 Adrià Bosch Saez. All rights reserved.
//

import UIKit

class CreateProfileController: UIViewController {

    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var sexSegmented: UISegmentedControl!
    @IBOutlet weak var lookForSegmented: UISegmentedControl!
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var collegeText: UITextField!
    @IBOutlet weak var workText: UITextField!
    @IBOutlet weak var songText: UITextField!

    @IBAction func saveProfileClick(_ sender: Any) {
        
        guard let name = nameText.text else {
            showMessageAlert("Name can not be empthy")
            return
        }
        
        if (name.isEmpty) {
            showMessageAlert("Name can not be empthy")
            return
        }
        if (name.count < 2) {
            showMessageAlert("Name must contain at least two characters")
            return
        }
        if (name.count > 12) {
            showMessageAlert("Name can not have more than twelve characters")
            return
        }
        
        let now = Date()
        let birthday: Date = datePicker.date
        let calendar = Calendar.current
        
        let ageComponents = calendar.dateComponents([.year], from: birthday, to: now)
        let age = ageComponents.year!
        
        if (age < 18) {
            showMessageAlert("Minors can not use this application")
            return
        }
        
        let sexIndex = sexSegmented.selectedSegmentIndex
        var sex = ""
        if (sexIndex == -1) {
            showMessageAlert("To create a profile we need your gender")
            return
        } else if (sexIndex == 0) {
            sex = "man"
        } else {
            sex = "woman"
        }
        
        let lookForIndex = lookForSegmented.selectedSegmentIndex
        var lookFor = ""
        if (lookForIndex == -1) {
            showMessageAlert("To create a profile we need to know what you're looking for")
            return
        } else if (lookForIndex == 0) {
            lookFor = "man"
        } else if (lookForIndex == 1) {
            lookFor = "woman"
        } else {
            lookFor = "both"
        }
        
        let userProfile = UserProfile(
            name: name,
            age: age,
            sex: sex,
            lookFor: lookFor,
            minAge: 18,
            maxAge: 60,
            description: "",
            currentWork: "",
            college: "",
            favoriteSong: "")
        
        createProfile(userProfile)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Create Profile"
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
    
    func createProfile(_ userProfile: UserProfile) {
        
        showLoadingAlert()
        Network.instance.updateUser(userProfile) { response in
            
            DispatchQueue.main.async {
                
                self.dismiss(animated: false) {
                    
                    switch(response.result) {
                        
                    case ApiResult.FAILED:
                        self.showMessageAlert("Connection error")
                        
                    case ApiResult.ERROR:
                        if (response.errorCode == -1) {
                            self.showMessageAlert("Something gone wrong")
                        } else if (response.errorCode == 0) {
                            self.showMessageAlert("Invalid data")
                        }
                        
                    default:
                        self.performSegue(withIdentifier: "ProfileToMain", sender: self)
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
