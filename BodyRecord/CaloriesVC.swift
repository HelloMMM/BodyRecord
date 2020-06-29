//
//  CaloriesVC.swift
//  BodyRecord
//
//  Created by HellöM on 2020/6/22.
//  Copyright © 2020 HellöM. All rights reserved.
//

import UIKit

class CaloriesVC: UIViewController {

    var dalegate: TabbarVCDelegate?
    
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var bodyHeight: UILabel!
    @IBOutlet weak var bodyWeight: UILabel!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var type: UIButton!
    @IBOutlet weak var bmr: UILabel!
    @IBOutlet weak var tedd: UILabel!
    @IBOutlet weak var loseWeight: UILabel!
    @IBOutlet weak var statement: UILabel!
    
    var typeAry = ["靜止", "輕度", "中度", "重度"]
    var selectType = 0
    
     var setData: Dictionary<String, Any> = [:] {
           didSet {
               iAge = setData["age"] as! Int
               iGender = setData["gander"] as! Int
               iBodyHeight = setData["bodyHight"] as! Double
               iBodyWeight = setData["bodyWidth"] as! Double
               upDate()
           }
       }
       var iAge = 0 {
           didSet {
               age.text = "\(iAge) Y"
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
       var iBodyHeight = 0.0 {
           didSet {
               if iBodyHeight.truncatingRemainder(dividingBy: 1) > 0 {
                   bodyHeight.text = "\(iBodyHeight) cm"
               } else {
                   bodyHeight.text = "\(Int(iBodyHeight)) cm"
               }
           }
       }
       var iBodyWeight = 0.0 {
           didSet {
               if iBodyWeight.truncatingRemainder(dividingBy: 1) > 0 {
                   bodyWeight.text = "\(iBodyWeight) kg"
               } else {
                   bodyWeight.text = "\(Int(iBodyWeight)) kg"
               }
           }
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        statement.text = "以上資料僅供參考,\n引用資料來源: 行政院衛生署."
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        bodyHeight.layer.addBorder(edge: .right, color: .gray, thickness: 1)
        bodyHeight.layer.addBorder(edge: .left, color: .gray, thickness: 1)
        gender.layer.addBorder(edge: .left, color: .gray, thickness: 1)
    }
    
    func upDate() {
        
        var bmrI = 0.0
        
        if iGender == 0 {
            bmrI = (9.6 * iBodyWeight) + (1.8 * iBodyHeight) - (4.7 * Double(iAge)) + 655
        } else {
            bmrI = (13.7 * iBodyWeight) + (5.0 * iBodyHeight) - (6.8 * Double(iAge)) + 66
        }
        
        bmr.text = "\(Int(bmrI)) kcal"
        
        var teddI = 0
        switch selectType {
        case 0:
            teddI = Int(bmrI * 1.1)
        case 1:
            teddI = Int(bmrI * 1.3)
        case 2:
            teddI = Int(bmrI * 1.5)
        case 3:
            teddI = Int(bmrI * 1.7)
        default:
            break
        }
        tedd.text = "\(teddI) kcal"
        
        let lowTedd = Double(teddI) * 0.8
        let hightTedd = Double(teddI) * 0.9
        
        loseWeight.text = "\(Int(lowTedd)) ~ \(Int(hightTedd)) kcal"
    }
    
    @IBAction func typeClick(_ sender: UIButton) {
        
        let customPickerView = CustomPickerView(typeAry) { (selectNumber) in
            
            sender.setTitle("\(self.typeAry[selectNumber]) ▼", for: .normal)
            self.selectType = selectNumber
            self.upDate()
        }
        
        customPickerView.lastSelect = selectType
    }
    
    @IBAction func menuClick(_ sender: Any) {
        
        dalegate?.showMenu()
    }
}
