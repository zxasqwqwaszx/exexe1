//
//  MatchesViewController.swift
//  Wetswipe
//
//  Created by Adrià Bosch Saez on 07/09/2018.
//  Copyright © 2018 Adrià Bosch Saez. All rights reserved.
//

import UIKit

class MatchesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var matchTableView: UITableView!
    
    var refreshControl = UIRefreshControl()
    
    let wetswipeApi = WetswipeApi.instance
    
    var matchList: [Match] = []
    
    var indexSelected = -1

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (matchList.count)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MatchCell
        
        let match = matchList[indexPath.row]
        if (match.photos.count > 0) {
         cell.matchImage.sd_setImage(with: URL(string: match.photos[0]))
        } else {
            cell.matchImage.sd_setImage(with: URL(string: "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973461_960_720.png"))
        }
        cell.nameText.text = match.name
        cell.ageText.text = String(match.age)
        
        return (cell)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(indexPath.row)
        indexSelected = indexPath.row
        self.performSegue(withIdentifier: "MatchesToDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let detailViewController = segue.destination as? DetailViewController
        detailViewController?.match = matchList[indexSelected]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        searchMatches()
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: UIControlEvents.valueChanged)
        matchTableView.addSubview(refreshControl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchMatches() {
        wetswipeApi.getMatches() { response  in
            
            DispatchQueue.main.async {
                
                switch(response.result) {
                    
                case ApiResult.FAILED:
                    self.showMessageAlert("Connection error")
                    
                case ApiResult.ERROR:
                    self.showMessageAlert("Something gone wrong")
                    
                    
                default:
                    self.matchList = response.content!
                    for match in self.matchList {
                        print(match.name)
                        print(match.age)
                    }
                    self.matchTableView.reloadData()
                }
            }
        }
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        print("handle refresh")
        wetswipeApi.getMatches() { response  in
            print("response")
            DispatchQueue.main.async {
                
                refreshControl.endRefreshing()
                
                switch(response.result) {
                    
                case ApiResult.FAILED:
                    self.showMessageAlert("Connection error")
                    
                case ApiResult.ERROR:
                    self.showMessageAlert("Something gone wrong")
                    
                    
                default:
                    self.matchList = response.content!
                    for match in self.matchList {
                        print(match.name)
                        print(match.age)
                    }
                    self.matchTableView.reloadData()
                }
            }
        }
    }
    
    func showMessageAlert(_ message: String) {
        let alert = UIAlertController(title: message, message: nil, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
