//
//  azkarMoslemTableViewCell.swift
//  Azkar
//
//  Created by Kareem on 12/30/20.
//  Copyright © 2020 Kareem. All rights reserved.
//

import UIKit

class azkarMoslemTableViewCell: UITableViewCell {

    @IBOutlet weak var azkarView: UIView!
    @IBOutlet weak var TitleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        azkarView.shadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
