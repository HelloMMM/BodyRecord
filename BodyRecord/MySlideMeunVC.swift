//
//  MySlideMeunVC.swift
//  BodyRecord
//
//  Created by HellöM on 2020/6/29.
//  Copyright © 2020 HellöM. All rights reserved.
//

import UIKit

protocol MySlideMeunDelegate {
    func itemClick()
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
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 1
        case 1:
            return 2
        case 2:
            return 2
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
            label.text = "首頁"
        case 1:
            label.text = "圖表"
        case 2:
            label.text = "其他"
        default:
            break
        }
        
        headView.addSubview(label)
        
        return headView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MySlideMeunCell", for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        dismiss(animated: true) {
            
            self.delegate?.itemClick()
        }
    }
}
