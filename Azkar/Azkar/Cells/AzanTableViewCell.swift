//
//  AzanTableViewCell.swift
//  Azkar
//
//  Created by Kareem on 1/4/21.
//  Copyright © 2021 Kareem. All rights reserved.
//

import UIKit

class AzanTableViewCell: UITableViewCell {

    @IBOutlet weak var azanNameLabel: UILabel!
    @IBOutlet weak var AzanTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
