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
let exceedWeightColor = UIColor(red: 1.0, green: 167.0/255.0, blue: 90.0/255.0, alpha: 1.0)
let mildoBesityColor = UIColor(red: 1.0, green: 147.0/255.0, blue: 0.0, alpha: 1.0)
let mediumBesityColor = UIColor(red: 227.0/255.0, green: 76.0/255.0, blue: 0.0, alpha: 1.0)
let severeBesityColor = UIColor(red: 1.0, green: 38.0/255.0, blue: 0.0, alpha: 1.0)

class MainVC: UIViewController {

    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var bodyHeight: UILabel!
    @IBOutlet weak var bodyWeight: UILabel!
    @IBOutlet weak var topView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        bodyHeight.layer.addBorder(edge: .right, color: .gray, thickness: 1)
        bodyHeight.layer.addBorder(edge: .left, color: .gray, thickness: 1)
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
