//
//  ImagePostTableViewCell.swift
//  Birdie-Final
//
//  Created by Donald Seo on 2020-06-26.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class ImagePostTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var messageImage: UIImageView!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
