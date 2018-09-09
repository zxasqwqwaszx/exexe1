//
//  MatchCell.swift
//  Wetswipe
//
//  Created by Adrià Bosch Saez on 07/09/2018.
//  Copyright © 2018 Adrià Bosch Saez. All rights reserved.
//

import UIKit

class MatchCell: UITableViewCell {

    @IBOutlet weak var matchImage: UIImageView!
    @IBOutlet weak var nameText: UILabel!
    @IBOutlet weak var ageText: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
