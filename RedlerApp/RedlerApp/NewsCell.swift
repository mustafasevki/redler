//
//  NewsCell.swift
//  RedlerApp
//
//  Created by Mustafa Sevki Cosar on 23.12.2017.
//  Copyright © 2017 Mustafa Sevki Cosar. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {
    
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var author: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
