//
//  FatVC.swift
//  BodyRecord
//
//  Created by HellöM on 2020/6/22.
//  Copyright © 2020 HellöM. All rights reserved.
//

import UIKit

class FatVC: UIViewController {

    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var bodyHeight: UILabel!
    @IBOutlet weak var bodyWeight: UILabel!
    @IBOutlet weak var topView: UIView!
    var setData: Dictionary<String, Any> = [:] {
        didSet {
            
            age.text = "\(setData["age"] ?? 0) Y"
            bodyHeight.text = "\(setData["bodyHight"] ?? 0) cm"
            bodyWeight.text = "\(setData["bodyWidth"] ?? 0) kg"
            iGender = setData["gander"] as! Int
        }
    }
    var iGender = 0 {
        didSet {
            if iGender == 0 {
                gender.text = "女♀"
            } else {
                gender.text = "男♀"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        bodyHeight.layer.addBorder(edge: .right, color: .gray, thickness: 1)
        bodyHeight.layer.addBorder(edge: .left, color: .gray, thickness: 1)
        gender.layer.addBorder(edge: .left, color: .gray, thickness: 1)
    }
}
