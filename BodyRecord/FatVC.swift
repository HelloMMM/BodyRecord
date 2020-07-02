//
//  FatVC.swift
//  BodyRecord
//
//  Created by HellöM on 2020/6/22.
//  Copyright © 2020 HellöM. All rights reserved.
//

import UIKit

enum BodyType {
    case maleLow
    case maleHight
    case femaleLow
    case femaleHight
}

class FatVC: UIViewController {

    var dalegate: TabbarVCDelegate?
    
    @IBOutlet weak var lowValue: UILabel!
    @IBOutlet weak var standardValue: UILabel!
    @IBOutlet weak var averageValue: UILabel!
    @IBOutlet weak var hightValue: UILabel!
    
    @IBOutlet weak var lowText: UILabel!
    @IBOutlet weak var standardText: UILabel!
    @IBOutlet weak var averageText: UILabel!
    @IBOutlet weak var hightText: UILabel!
    var textAry: Array<UILabel>!
    
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var bodyHeight: UILabel!
    @IBOutlet weak var bodyWeight: UILabel!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bodyFat: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var statement: UILabel!
    var bodyType: BodyType!
    
    var setData: Dictionary<String, Any> = [:] {
        didSet {
            iAge = setData["age"] as! Int
            iGender = setData["gender"] as! Int
            iBodyHeight = setData["bodyHeight"] as! Double
            iBodyWeight = setData["bodyWeight"] as! Double
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

        textAry = [lowText, standardText, averageText, hightText]
        
        statement.text = "以上資料僅供參考,\n引用資料來源: 維基百科."
    }
    
    override func viewDidAppear(_ animated: Bool) {
        bodyHeight.layer.addBorder(edge: .right, color: .gray, thickness: 1)
        bodyHeight.layer.addBorder(edge: .left, color: .gray, thickness: 1)
        gender.layer.addBorder(edge: .left, color: .gray, thickness: 1)
    }
    
    func upDate() {
        
        let meter = iBodyHeight / 100
        let dHight = meter * meter
        let bmi = iBodyWeight / dHight
        
        let ibodyFat = (1.2 * bmi) + (0.23 * Double(iAge) - 5.4) - (10.8 * Double(iGender))

        bodyFat.text = String(format: "%.1f %@", ibodyFat,"%")
        
        if iGender == 0 {
            if iAge < 30 {
                lowValue.text = "< 20 %"
                standardValue.text = "20 ~ 25.9 %"
                averageValue.text = "26 ~ 32 %"
                hightValue.text = "≧ 32 %"
                bodyType = .femaleLow
            } else {
                lowValue.text = "< 22 %"
                standardValue.text = "22 ~ 27.9 %"
                averageValue.text = "28 ~ 34 %"
                hightValue.text = "≧ 34 %"
                bodyType = .femaleHight
            }
        } else {
            if iAge < 30 {
                lowValue.text = "< 10 %"
                standardValue.text = "10 ~ 19.9 %"
                averageValue.text = "20 ~ 24.9 %"
                hightValue.text = "≧ 25 %"
                bodyType = .maleLow
            } else {
                lowValue.text = "< 13 %"
                standardValue.text = "13 ~ 22.9 %"
                averageValue.text = "23 ~ 27.9 %"
                hightValue.text = "≧ 28 %"
                bodyType = .maleHight
            }
        }
        
        switch bodyType {
        case .femaleLow:
            if ibodyFat < 20 {
                type.text = "極低"
                type.textColor = lightWeightColor
                lowText.textColor = lightWeightColor
                fixColor(lowText)
            } else if ibodyFat >= 20 && ibodyFat < 26 {
                type.text = "標準"
                type.textColor = normalWeightColor
                standardText.textColor = normalWeightColor
                fixColor(standardText)
            } else if ibodyFat >= 26 && ibodyFat < 32 {
                type.text = "平均"
                type.textColor = exceedWeightColor
                averageText.textColor = exceedWeightColor
                fixColor(averageText)
            } else if ibodyFat >= 32 {
                type.text = "過高"
                type.textColor = severeBesityColor
                hightText.textColor = severeBesityColor
                fixColor(hightText)
            }
        case .femaleHight:
            if ibodyFat < 22 {
                type.text = "極低"
                type.textColor = lightWeightColor
                lowText.textColor = lightWeightColor
                fixColor(lowText)
            } else if ibodyFat >= 22 && ibodyFat < 28 {
                type.text = "標準"
                type.textColor = normalWeightColor
                standardText.textColor = normalWeightColor
                fixColor(standardText)
            } else if ibodyFat >= 28 && ibodyFat < 34 {
                type.text = "平均"
                type.textColor = exceedWeightColor
                averageText.textColor = exceedWeightColor
                fixColor(averageText)
            } else if ibodyFat >= 34 {
                type.text = "過高"
                type.textColor = severeBesityColor
                hightText.textColor = severeBesityColor
                fixColor(hightText)
            }
        case .maleLow:
            if ibodyFat < 10 {
                type.text = "極低"
                type.textColor = lightWeightColor
                lowText.textColor = lightWeightColor
                fixColor(lowText)
            } else if ibodyFat >= 10 && ibodyFat < 20 {
                type.text = "標準"
                type.textColor = normalWeightColor
                standardText.textColor = normalWeightColor
                fixColor(standardText)
            } else if ibodyFat >= 20 && ibodyFat < 25 {
                type.text = "平均"
                type.textColor = exceedWeightColor
                averageText.textColor = exceedWeightColor
                fixColor(averageText)
            } else if ibodyFat >= 25 {
                type.text = "過高"
                type.textColor = severeBesityColor
                hightText.textColor = severeBesityColor
                fixColor(hightText)
            }
        case .maleHight:
            if ibodyFat < 13 {
                type.text = "極低"
                type.textColor = lightWeightColor
                lowText.textColor = lightWeightColor
                fixColor(lowText)
            } else if ibodyFat >= 13 && ibodyFat < 23 {
                type.text = "標準"
                type.textColor = normalWeightColor
                standardText.textColor = normalWeightColor
                fixColor(standardText)
            } else if ibodyFat >= 23 && ibodyFat < 28 {
                type.text = "平均"
                type.textColor = exceedWeightColor
                averageText.textColor = exceedWeightColor
                fixColor(averageText)
            } else if ibodyFat >= 28 {
                type.text = "過高"
                type.textColor = severeBesityColor
                hightText.textColor = severeBesityColor
                fixColor(hightText)
            }
        default:
            break
        }
    }
    
    func fixColor(_ lab: UILabel) {
        
        for objc in textAry {
            
            if objc != lab {
                objc.textColor = UIColor(red: 40.0/255.0, green: 42.0/255.0, blue: 48.0/255.0, alpha: 0.79)
            }
        }
    }
    
    @IBAction func menuClick(_ sender: Any) {
        
        dalegate?.showMenu()
    }
}

