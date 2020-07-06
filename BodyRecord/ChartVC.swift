//
//  ChartVC.swift
//  BodyRecord
//
//  Created by HellöM on 2020/6/30.
//  Copyright © 2020 HellöM. All rights reserved.
//

import UIKit
import TwicketSegmentedControl
import GoogleMobileAds

class ChartVC: UIViewController {

    var interstitial: GADInterstitial!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var segmentView: TwicketSegmentedControl!
    @IBOutlet weak var scrollView: UIScrollView!
    var nowPage = 0
    var isClickedSegmented = false
    var isScroll = false
    @IBOutlet weak var originWeight: UILabel!
    @IBOutlet weak var currnWeight: UILabel!
    @IBOutlet weak var averageWeight: UILabel!
    @IBOutlet weak var originFat: UILabel!
    @IBOutlet weak var currnFat: UILabel!
    @IBOutlet weak var averageFat: UILabel!
    var bodyWeights: Array<Double> = []
    var totalWeight = 0.0
    var bodyFats: Array<Double> = []
    var totalFat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        interstitial = createAndLoadInterstitial()
        
        topView.backgroundColor = tabBarColor
        segmentView.setSegmentItems(["體重", "體脂"])
        segmentView.backgroundColor = .clear
        segmentView.delegate = self
        
        bodyWeights = userData.map { (objc) -> Double in
            
            let bodyWeight = objc.value(forKey: "bodyWeight")! as! Double
            totalWeight += bodyWeight
            return bodyWeight
        }.reversed()
        
        if bodyWeights.count != 0 {
            
            let setData = UserDefaults.standard.object(forKey: "setData") as! Dictionary<String, Any>
            currnWeight.text = String(format: "%.1f kg", setData["bodyWeight"] as! Double)
            originWeight.text = "\(bodyWeights[0]) kg"
            averageWeight.text = String(format: "%.1f kg", totalWeight/Double(bodyWeights.count))
        }
        
        bodyFats = userData.map { (objc) -> Double in
            
            let age = (objc.value(forKey: "age")! as! Double)
            let gender = (objc.value(forKey: "gender")! as! Double)
            let meter = (objc.value(forKey: "bodyHeight")! as! Double) / 100
            let dHight = meter * meter
            let bodyWeight = objc.value(forKey: "bodyWeight")! as! Double
            let bmi = bodyWeight / dHight
            let bodyFat = (1.2 * bmi) + (0.23 * Double(age) - 5.4) - (10.8 * Double(gender))
            
            totalFat += bodyFat
            return bodyFat
        }.reversed()
        
        if bodyFats.count != 0 {
            
            let setData = UserDefaults.standard.object(forKey: "setData") as! Dictionary<String, Any>
            let meter = (setData["bodyHeight"] as! Double) / 100
            let dHight = meter * meter
            let bmi = (setData["bodyWeight"] as! Double) / dHight
            let age = setData["age"] as! Int
            let gender = setData["gender"] as! Int
            let ibodyFat = (1.2 * bmi) + (0.23 * Double(age) - 5.4) - (10.8 * Double(gender))
            currnFat.text = String(format: "%.1f %@", ibodyFat, "%")
            originFat.text = String(format: "%.1f %@", bodyFats[0], "%")
            averageFat.text = String(format: "%.1f %@", totalFat/Double(bodyFats.count), "%")
        }
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

extension ChartVC: GADInterstitialDelegate {

    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
//        if !isRemoveAD {
//            if interstitial.isReady {
//                interstitial.present(fromRootViewController: self)
//            } else {
//                interstitial = createAndLoadInterstitial()
//            }
//        }
    }
}

extension ChartVC: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if !isClickedSegmented {
            
            isScroll = true
            
            let pageWidth: CGFloat = scrollView.frame.width
            let tmpPageInt: Int = Int(scrollView.contentOffset.x / pageWidth)
            let tmpPageFloat: CGFloat = scrollView.contentOffset.x / pageWidth
            let page: Int = tmpPageFloat - CGFloat(tmpPageInt) >= 0.5 ? tmpPageInt + 1 : tmpPageInt
            
            if nowPage != page {
                
                segmentView.move(to: page)
                nowPage = page
            }
        }
    }
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        isClickedSegmented = false
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let pageWidth: CGFloat = view.frame.width
        let page: Int = Int(scrollView.contentOffset.x / pageWidth)
        
        if segmentView.selectedSegmentIndex != page {
            segmentView.move(to: page)
        }
        isClickedSegmented = false
        isScroll = false
    }
}

extension ChartVC: TwicketSegmentedControlDelegate {
    
    func didSelect(_ segmentIndex: Int) {
        
        if isScroll {
            return
        }
        
        nowPage = segmentIndex
        scrollView.setContentOffset(CGPoint(x: (view.frame.width)*CGFloat(segmentIndex), y: 0), animated: true)
        isClickedSegmented = true
    }
}
