//
//  MoreVCCell.swift
//  BodyRecord
//
//  Created by HellöM on 2020/6/24.
//  Copyright © 2020 HellöM. All rights reserved.
//

import UIKit

class MoreVCCell: UITableViewCell {

    
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var myTitle: UILabel!
    @IBOutlet weak var version: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
