//
//  DiscoveryController.swift
//  Wetswipe
//
//  Created by Adrià Bosch Saez on 25/02/2018.
//  Copyright © 2018 Adrià Bosch Saez. All rights reserved.
//

import UIKit

//import Koloda
import SDWebImage

class DiscoveryController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    
    let wetswipeApi = WetswipeApi.instance
    
    var discoveryArray: [Discovery] = []
    

    @IBAction func dislikeClick() {
        setState(state: "dislike")
    }
    
    @IBAction func likeClick() {
        setState(state: "like")
    }
    
    func setState(state: String) {
        if discoveryArray.count == 0 {
            return
        }
        
        wetswipeApi.setLike(dicoveryId: discoveryArray[0]._id, state: state) { response  in
            
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
        nextDiscovery()
    }
    
    func searchForDiscovery() {
        
        wetswipeApi.discoveryUsers { response  in
            
            DispatchQueue.main.async {
                
                switch(response.result) {
                    
                case ApiResult.FAILED:
                    self.showMessageAlert("Connection error")
                    
                case ApiResult.ERROR:
                    self.showMessageAlert("Something gone wrong")
                    
                    
                default:
                    self.discoveryArray = response.content!
                    for discovery in response.content! {
                        print(discovery.name)
                    }
                    self.setDiscovery()
                }
            }
        }
    }
    
    func nextDiscovery() {
        
        print(discoveryArray.count)
        
        if discoveryArray.count == 0 {
            return
        }
        
        discoveryArray.remove(at: 0)
        
        setDiscovery()
    }
    
    func setDiscovery() {
        
        if discoveryArray.count == 0 {
            return
        }
        
        let discovery = discoveryArray[0]
        if (discovery.photos.count > 0) {
            imageView.sd_setImage(with: URL(string: discovery.photos[0]))
        } else {
            imageView.sd_setImage(with: URL(string: "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973461_960_720.png"))
        }
        userLabel.text = discovery.name + " " + String(discovery.age)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "Discovery"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchForDiscovery()
    }
    
    func showMessageAlert(_ message: String) {
        let alert = UIAlertController(title: message, message: nil, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}
