//
//  DiscoveryController.swift
//  Wetswipe
//
//  Created by Adrià Bosch Saez on 25/02/2018.
//  Copyright © 2018 Adrià Bosch Saez. All rights reserved.
//

import UIKit

import Koloda
import SDWebImage

class DiscoveryController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    
    var usersArray: [User] = []
    var userNumber: Int = -1
    

    @IBAction func dislikeClick() {
        
        nextUser()
    }
    
    @IBAction func likeClick() {
        
        nextUser()
    }
    
    func nextUser() {
        
        userNumber = userNumber + 1
        
        if userNumber >= usersArray.count {
            userNumber = 0
        }
        
        imageView.sd_setImage(with: URL(string: usersArray[userNumber].photos[0]))
        userLabel.text = usersArray[userNumber].name + " " + String(usersArray[userNumber].age)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        navigationItem.title = "Discovery"
        
        usersArray.append(User(name: "Laura", age: 20, photos: ["http://www.apatita.com/rutas/Huesca/monte_perdido_goriz/fotos/28_monte_perdido.jpg"]))
        usersArray.append(User(name: "Marina", age: 21, photos: ["http://guidevaldaran.com/wp-content/uploads/2017/10/monte-perdido.jpg"]))
        usersArray.append(User(name: "Julia", age: 22, photos: ["http://www.nationalgeographic.com.es/medio/2016/02/25/monte-perdido_960x648_c588e7da.jpg"]))
        usersArray.append(User(name: "Jenny", age: 23, photos: ["http://zetaestaticos.com/aragon/img/noticias/0/791/791960_1.jpg"]))
        usersArray.append(User(name: "Berta", age: 24, photos: ["http://www.komandokroketa.org/cilindro/74-5-Monte-Perdido-Escaleras-glaciar.jpg"]))
        usersArray.append(User(name: "Cristina", age: 25, photos: ["http://3.bp.blogspot.com/-UDUCPoasrxc/UvH2D2RfA2I/AAAAAAAAL4w/VVTkx8N0QDo/s1600/perdido+desde+el+cuello+del+cilindro.jpg"]))
        
        
        nextUser()
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
