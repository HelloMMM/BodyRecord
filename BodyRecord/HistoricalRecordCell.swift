//
//  HistoricalRecordCell.swift
//  BodyRecord
//
//  Created by HellöM on 2020/6/30.
//  Copyright © 2020 HellöM. All rights reserved.
//

import UIKit

class HistoricalRecordCell: UITableViewCell {

    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var bodyWeight: UILabel!
    @IBOutlet weak var bodyHeight: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var age: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
