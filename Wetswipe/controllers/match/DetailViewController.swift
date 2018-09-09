//
//  DetailViewController.swift
//  Wetswipe
//
//  Created by Adrià Bosch Saez on 08/09/2018.
//  Copyright © 2018 Adrià Bosch Saez. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var nameAgeText: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionText: UILabel!
    @IBOutlet weak var workText: UILabel!
    @IBOutlet weak var collegeText: UILabel!
    @IBOutlet weak var favoriteSongText: UILabel!
    
    var match: Match? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Detail"
        
        
        if let match = match {
            
            nameAgeText.text = match.name + ", " + String(match.age)
            if (match.photos.count > 0) {
                imageView.sd_setImage(with: URL(string: match.photos[0]))
            } else {
                imageView.sd_setImage(with: URL(string: "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973461_960_720.png"))
            }
            descriptionText.text = match.description
            workText.text = match.currentWork
            collegeText.text = match.college
            favoriteSongText.text = match.favoriteSong
        }
        
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
