//
//  ViewController.swift
//  BodyRecord
//
//  Created by HellöM on 2020/6/22.
//  Copyright © 2020 HellöM. All rights reserved.
//

import UIKit

let lightWeightColor = UIColor(red: 4.0/255.0, green: 125.0/255.0, blue: 1.0, alpha: 1.0)
let normalWeightColor = UIColor(red: 0.0, green: 180.0/255.0, blue: 0.0, alpha: 1.0)
let exceedWeightColor = UIColor(red: 1.0, green: 223.0/255.0, blue: 90.0/255.0, alpha: 1.0)
let mildoBesityColor = UIColor(red: 1.0, green: 147.0/255.0, blue: 0.0, alpha: 1.0)
let mediumBesityColor = UIColor(red: 227.0/255.0, green: 76.0/255.0, blue: 0.0, alpha: 1.0)
let severeBesityColor = UIColor(red: 1.0, green: 38.0/255.0, blue: 0.0, alpha: 1.0)

class MainVC: UIViewController {

    
    @IBOutlet weak var lightText: UILabel!
    @IBOutlet weak var normalText: UILabel!
    @IBOutlet weak var exceedText: UILabel!
    @IBOutlet weak var mildoText: UILabel!
    @IBOutlet weak var mediumText: UILabel!
    @IBOutlet weak var severeText: UILabel!
    var textAry: Array<UILabel>!
    @IBOutlet weak var bodyWeightRange: UILabel!
    
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var bodyHeight: UILabel!
    @IBOutlet weak var bodyWeight: UILabel!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bmi: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var statement: UILabel!
    
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
        
        textAry = [lightText, normalText, exceedText, mildoText, mediumText, severeText]

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
        let iBmi = String(format: "%.1f", iBodyWeight / dHight)
        bmi.text = iBmi
        
        if Double(iBmi)! < 18.5 {
            type.text = "體重過輕"
            type.textColor = lightWeightColor
            lightText.textColor = lightWeightColor
            fixColor(lightText)
        } else if Double(iBmi)! >= 18.5 && Double(iBmi)! < 25 {
            type.text = "健康體位"
            type.textColor = normalWeightColor
            normalText.textColor = normalWeightColor
            fixColor(normalText)
        } else if Double(iBmi)! >= 25 && Double(iBmi)! < 28 {
            type.text = "過重"
            type.textColor = exceedWeightColor
            exceedText.textColor = exceedWeightColor
            fixColor(exceedText)
        } else if Double(iBmi)! >= 28 && Double(iBmi)! < 31 {
            type.text = "輕度肥胖"
            type.textColor = mildoBesityColor
            (mildoText).textColor = mildoBesityColor
            fixColor(mildoText)
        } else if Double(iBmi)! >= 31 && Double(iBmi)! < 36 {
            type.text = "中度肥胖"
            type.textColor = mediumBesityColor
            mediumText.textColor = mediumBesityColor
            fixColor(mediumText)
        } else if Double(iBmi)! >= 36  {
            type.text = "重度肥胖"
            type.textColor = severeBesityColor
            severeText.textColor = severeBesityColor
            fixColor(severeText)
        }
        
        var standardW = 0.0
        if iGender == 0 {
            standardW = (iBodyHeight - 70) * 0.6
        } else {
            standardW = (iBodyHeight - 80) * 0.7
        }
        
        let lowStandardW = standardW * 0.9
        let hightStandardW = standardW * 1.1
        
        bodyWeightRange.text = String(format: "%.1f ~ %.1f kg", lowStandardW, hightStandardW)
    }
    
    func fixColor(_ lab: UILabel) {
        
        for objc in textAry {
            
            if objc != lab {
                objc.textColor = UIColor(red: 40.0/255.0, green: 42.0/255.0, blue: 48.0/255.0, alpha: 0.79)
            }
        }
    }
}

extension CALayer {

    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {

        let border = CALayer()

        switch edge {
        case .top:
            border.frame = CGRect(x: 0, y: 0, width: self.frame.height, height: thickness)
            break
        case .bottom:
            border.frame = CGRect(x: 0, y: self.frame.height - thickness, width: UIScreen.main.bounds.width, height: thickness)
            break
        case .left:
            border.frame = CGRect(x: 0, y: 0, width: thickness, height: self.frame.height)
            break
        case .right:
            border.frame = CGRect(x: self.frame.width - thickness, y: 0, width: thickness, height: self.frame.height)
            break
        default:
            break
        }

        border.backgroundColor = color.cgColor;

        self.addSublayer(border)
    }
}
