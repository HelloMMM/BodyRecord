//
//  SetVC.swift
//  BodyRecord
//
//  Created by HellöM on 2020/6/23.
//  Copyright © 2020 HellöM. All rights reserved.
//

import UIKit

protocol SetVCDelegate {
    func setData(_ data: Dictionary<String, Any>)
}

class SetVC: UIViewController {

    var delegate: SetVCDelegate?
    @IBOutlet weak var yearOld: UITextField!
    @IBOutlet weak var gander: UIButton!
    @IBOutlet weak var bodyHight: UITextField!
    @IBOutlet weak var bodyWidth: UITextField!
    let ganders = ["女♀", "男♂"]
    var selectGander = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if UserDefaults.standard.object(forKey: "setData") != nil {
            
            let setData = UserDefaults.standard.object(forKey: "setData") as! Dictionary<String, Any>
            yearOld.text = "\(setData["age"] ?? 0)"
            bodyHight.text = "\(setData["bodyHight"] ?? 0)"
            bodyWidth.text = "\(setData["bodyWidth"] ?? 0)"
            selectGander = setData["gander"] as! Int
            if selectGander == 0 {
                gander.setTitle("女♀ ▼", for: .normal)
            } else {
                gander.setTitle("男♀ ▼", for: .normal)
            }
        }
        
        yearOld.addTarget(self, action: #selector(textFieldChange(_:)), for: .editingChanged)
        bodyHight.addTarget(self, action: #selector(textFieldChange(_:)), for: .editingChanged)
        bodyWidth.addTarget(self, action: #selector(textFieldChange(_:)), for: .editingChanged)
    }
    
    @objc func textFieldChange(_ textField: UITextField) {
        
        var newText = textField.text!

        if newText.count > 5 {
            newText.removeLast()
            textField.shake()
            showToast("最多五位數")
        }
        
        textField.text = newText
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        view.endEditing(true)
    }
    
    @IBAction func ganderClick(_ sender: UIButton) {
        
        view.endEditing(true)
        
        let customPickerView = CustomPickerView(ganders) { (selectNumber) in
            
            sender.setTitle("\(self.ganders[selectNumber]) ▼", for: .normal)
            self.selectGander = selectNumber
        }
        
        customPickerView.lastSelect = selectGander
    }
    
    @IBAction func determineClick(_ sender: Any) {
        
        view.endEditing(true)
        
        guard let age = Int(yearOld.text!) else {
            yearOld.shake()
            showToast("請輸入正確年紀")
            yearOld.becomeFirstResponder()
            return
        }
        guard let hight = Double(bodyHight.text!) else {
            bodyHight.shake()
            showToast("請輸入正確身高")
            bodyHight.becomeFirstResponder()
            return
        }
        guard let width = Double(bodyWidth.text!) else {
            bodyWidth.shake()
            showToast("請輸入正確體重")
            bodyWidth.becomeFirstResponder()
            return
        }
        
        let gander = selectGander
        var sHight = ""
        var sWidth = ""
        
        if hight.truncatingRemainder(dividingBy: 1) > 0 {
            sHight = "\(hight)"
        } else {
            sHight = "\(Int(hight))"
        }
        if width.truncatingRemainder(dividingBy: 1) > 0 {
            sWidth = "\(width)"
        } else {
            sWidth = "\(Int(width))"
        }
        
        delegate?.setData(["age": age,
                           "gander": gander,
                           "bodyHight": sHight,
                           "bodyWidth": sWidth])
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelClick(_ sender: Any) {
        view.endEditing(true)
        dismiss(animated: true, completion: nil)
    }
}

extension SetVC: UITextFieldDelegate {
    
    
}
