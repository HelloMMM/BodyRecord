//
//  MoreVCViewController.swift
//  BodyRecord
//
//  Created by HellöM on 2020/6/22.
//  Copyright © 2020 HellöM. All rights reserved.
//

import UIKit

protocol MoreVCDelegate {
    
    func changeStyle(_ style: Style)
}

enum Style: Int {
    case blue
    case yellow
    case pink
}

class MoreVC: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var tableView: UITableView!
    let titleAry = ["去除廣告", "恢復購買", "樣式", "當前版本"]
    let styleNames = ["天空☁️", "布丁🍮", "櫻花🌸"]
    var lastSelect = 0
    var delegate: MoreVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lastSelect = appStyle
        tableView.tableFooterView = UIView()
    }
}

extension MoreVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoreVCCell", for: indexPath) as! MoreVCCell
        
        if indexPath.row == 2 {
            cell.version.text = styleNames[appStyle]
        } else if indexPath.row == 3 {
            cell.version.text = "v1.0.0"
        } else {
            cell.version.text = ""
        }
        
        cell.myTitle.text = titleAry[indexPath.row]
        cell.myImageView.image = UIImage(named: "cell_\(indexPath.row)")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            let _ = IAPManager.shared.startPurchase()
        case 1:
            let _ = IAPManager.shared.restorePurchase()
        case 2:
            changeStyle()
        default:
            break
        }
    }
    
    func changeStyle() {
        
        let customPickerView = CustomPickerView(styleNames) { (selectNumber) in
            
            self.lastSelect = selectNumber
            appStyle = selectNumber
            UserDefaults.standard.set(appStyle, forKey: "appStyle")
            self.delegate?.changeStyle(Style(rawValue: selectNumber)!)
            self.tableView.reloadData()
        }
        
        customPickerView.lastSelect = lastSelect
    }
}
