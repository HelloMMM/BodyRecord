//
//  HistoricalRecordViewController.swift
//  BodyRecord
//
//  Created by HellöM on 2020/6/30.
//  Copyright © 2020 HellöM. All rights reserved.
//

import UIKit
import GoogleMobileAds

class HistoricalRecordVC: UIViewController {

    var interstitial: GADInterstitial!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        interstitial = createAndLoadInterstitial()
        topView.backgroundColor = tabBarColor
    }
    
    func createAndLoadInterstitial() -> GADInterstitial {
        
        #if DEBUG
            interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
        #else
            interstitial = GADInterstitial(adUnitID: "ca-app-pub-1223027370530841/9186788056")
        #endif
        interstitial.delegate = self
        interstitial.load(GADRequest())
        
        return interstitial
    }
    
    @IBAction func cancelClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension HistoricalRecordVC: GADInterstitialDelegate {
    
    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
        if !isRemoveAD {
            if interstitial.isReady {
                interstitial.present(fromRootViewController: self)
            } else {
                interstitial = createAndLoadInterstitial()
            }
        }
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {

//        interstitial = createAndLoadInterstitial()
    }
}

extension HistoricalRecordVC: UITableViewDelegate, UITableViewDataSource, SetVCDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return userData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoricalRecordCell", for: indexPath) as! HistoricalRecordCell
        
        cell.date.text = "\(userData[indexPath.row].value(forKey: "date")!)"
        cell.bodyWeight.text = "\(userData[indexPath.row].value(forKey: "bodyWeight")!) kg"
        cell.bodyHeight.text = "\(userData[indexPath.row].value(forKey: "bodyHeight")!) cm"
        cell.age.text = "\(userData[indexPath.row].value(forKey: "age")!) Y"
        let iGender = userData[indexPath.row].value(forKey: "gender")! as! Int
        if iGender == 0 {
            cell.gender.text = "女♀"
        } else {
            cell.gender.text = "男♀"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let setVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SetVC") as! SetVC
        setVC.delegate = self
        present(setVC, animated: true, completion: nil)
        
//        cell.date.text = "\(userData[indexPath.row].value(forKey: "date")!)"
        let bodyWeight = "\(userData[indexPath.row].value(forKey: "bodyWeight")!)"
        let bodyHeight = "\(userData[indexPath.row].value(forKey: "bodyHeight")!)"
        let age = "\(userData[indexPath.row].value(forKey: "age")!)"
        let gender = userData[indexPath.row].value(forKey: "gender")! as! Int
        
        let setData: Dictionary<String, Any> = ["bodyWeight": bodyWeight,
                                                "bodyHeight": bodyHeight,
                                                "age": age,
                                                "gender": gender]
        setVC.setData = setData
    }
    
    func setData(_ data: Dictionary<String, Any>) {
        
        let _ = coreDataConnect.insert(coreDataName, attributeInfo: data)
        let selectResult = coreDataConnect.retrieve(coreDataName, predicate: nil, sort: [["date": false]], limit: nil)

        if let results = selectResult {
            userData = results
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "刪除"
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            let data = "date = '\(userData[indexPath.row].value(forKey: "date")!)'"
            let _ = coreDataConnect.delete(coreDataName, predicate: data)
            
            let selectResult = coreDataConnect.retrieve(coreDataName, predicate: nil, sort: [["date": false]], limit: nil)

            if let results = selectResult {
                userData = results
            }
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
