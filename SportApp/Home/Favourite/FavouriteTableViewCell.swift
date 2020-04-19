//
//  FavouriteTableViewCell.swift
//  SportApp
//
//  Created by Ahmed Elesdody on 4/19/20.
//  Copyright © 2020 Ahmed Elesdody. All rights reserved.
//

import UIKit

class FavouriteTableViewCell: UITableViewCell {

    @IBOutlet weak var watchLeage: UIButton!
    @IBOutlet weak var leageImage: UIImageView!
    @IBOutlet weak var leagueName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
