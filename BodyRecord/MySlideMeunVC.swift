//
//  MySlideMeunVC.swift
//  BodyRecord
//
//  Created by HellöM on 2020/6/29.
//  Copyright © 2020 HellöM. All rights reserved.
//

import UIKit

protocol MySlideMeunDelegate {
    func itemClick(_ menuType: MenuType)
}

class MySlideMeunVC: UIViewController {

    var delegate: MySlideMeunDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    
        dismiss(animated: true, completion: nil)
    }
}

extension MySlideMeunVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 2
        case 1:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 60))
        headView.backgroundColor = .clear
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        label.center = CGPoint(x: 60, y: headView.frame.height/2+5)
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .gray
        
        if section != 0 {
            let lineView = UIView(frame: CGRect(x: 20, y: 0, width: tableView.frame.width-40, height: 1))
            lineView.backgroundColor = .gray
            
            headView.addSubview(lineView)
        }
        
        switch section {
        case 0:
            label.text = "紀錄"
        case 1:
            label.text = "其他"
        default:
            break
        }
        
        headView.addSubview(label)
        
        return headView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MySlideMeunCell", for: indexPath) as! MySlideMeunCell
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                cell.title.text = "歷史體重"
                cell.myImageView.image = UIImage(named: "WeightScale")
            } else if indexPath.row == 1 {
                cell.title.text = "數據圖表"
                cell.myImageView.image = UIImage(named: "chart")
            }
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                cell.title.text = "客服與意見回饋"
                cell.myImageView.image = UIImage(named: "question")
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        dismiss(animated: true) {
            
            if indexPath.section == 0 {
                if indexPath.row == 0 {
                    self.delegate?.itemClick(.historical)
                } else if indexPath.row == 1 {
                    self.delegate?.itemClick(.chart)
                }
            } else if indexPath.section == 1 {
                if indexPath.row == 0 {
                    self.delegate?.itemClick(.question)
                }
            }
        }
    }
}
