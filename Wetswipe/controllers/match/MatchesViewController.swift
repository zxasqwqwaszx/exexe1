//
//  MatchesViewController.swift
//  Wetswipe
//
//  Created by Adrià Bosch Saez on 07/09/2018.
//  Copyright © 2018 Adrià Bosch Saez. All rights reserved.
//

import UIKit

class MatchesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let matchList = ["Milk", "honey", "tomatoes"]

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchList.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = matchList[indexPath.row]
        
        return cell
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
