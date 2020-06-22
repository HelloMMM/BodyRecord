//
//  TabbarVC.swift
//  BodyRecord
//
//  Created by HellöM on 2020/6/22.
//  Copyright © 2020 HellöM. All rights reserved.
//

import UIKit
import ESTabBarController_swift
import GoogleMobileAds

class TabbarVC: ESTabBarController {

    var bannerView: GADBannerView!
    var mainVC: MainVC!
    var addVC: UIViewController!
    var moreVC: MoreVC!
    var fatVC: FatVC!
    var caloriesVC: CaloriesVC!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addBannerViewToView()
        
        let main = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainVC") as! MainVC
        let more = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MoreVC") as! MoreVC
        let fat = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FatVC") as! FatVC
        let calories = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CaloriesVC") as! CaloriesVC
        
        mainVC = main
        fatVC = fat
        addVC = UIViewController()
        caloriesVC = calories
        moreVC = more
        
        changeStyle()
        
        viewControllers = [mainVC, fatVC, addVC, caloriesVC, moreVC]
        
        shouldHijackHandler = {
            tabbarController, viewController, index in
            if index == 2 {
                return true
            }
            return false
        }
        
        didHijackHandler = {
            [weak self] tabbarController, viewController, index in
            
//            self!.v1.addClick()
        }
    }
    
    func changeStyle() {
        
        let exampleIrregularityContentView = ExampleIrregularityContentView()
        let basicContentView1 = ExampleIrregularityBasicContentView()
        basicContentView1.backdropColor = .clear
        basicContentView1.highlightBackdropColor = .clear
        let basicContentView2 = ExampleIrregularityBasicContentView()
        basicContentView2.backdropColor = .clear
        basicContentView2.highlightBackdropColor = .clear
        let basicContentView3 = ExampleIrregularityBasicContentView()
        basicContentView3.backdropColor = .clear
        basicContentView3.highlightBackdropColor = .clear
        let basicContentView4 = ExampleIrregularityBasicContentView()
        basicContentView4.backdropColor = .clear
        basicContentView4.highlightBackdropColor = .clear
        
        tabBar.backgroundColor = UIColor(red: 10/255.0, green: 66/255.0, blue: 91/255.0, alpha: 1.0)
        mainVC.view.backgroundColor = UIColor(red: 165.0/255.0, green: 222.0/255.0, blue: 228.0/255.0, alpha: 1.0)
        mainVC.topView.backgroundColor = UIColor(red: 10/255.0, green: 66/255.0, blue: 91/255.0, alpha: 1.0)
        moreVC.view.backgroundColor = UIColor(red: 165.0/255.0, green: 222.0/255.0, blue: 228.0/255.0, alpha: 1.0)
        fatVC.view.backgroundColor = UIColor(red: 165.0/255.0, green: 222.0/255.0, blue: 228.0/255.0, alpha: 1.0)
        caloriesVC.view.backgroundColor = UIColor(red: 165.0/255.0, green: 222.0/255.0, blue: 228.0/255.0, alpha: 1.0)
        
        mainVC.tabBarItem = ESTabBarItem(basicContentView1, title: "BMI", image: UIImage(named: "bmi"), selectedImage: UIImage(named: "bmi_1"))
        fatVC.tabBarItem = ESTabBarItem(basicContentView2, title: "體脂肪", image: UIImage(named: "fat"), selectedImage: UIImage(named: "fat"))
        addVC.tabBarItem = ESTabBarItem(exampleIrregularityContentView, title: nil, image: UIImage(named: "add"), selectedImage: UIImage(named: "add"))
        caloriesVC.tabBarItem = ESTabBarItem(basicContentView3, title: "代謝率", image: UIImage(named: "calories"), selectedImage: UIImage(named: "calories"))
        moreVC.tabBarItem = ESTabBarItem(basicContentView4, title: "更多", image: UIImage(named: "more"), selectedImage: UIImage(named: "more"))
    }
    
    func addBannerViewToView() {
        
        bannerView = GADBannerView(adSize: kGADAdSizeFullBanner)

        #if DEBUG
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        #else
        bannerView.adUnitID = "ca-app-pub-1223027370530841/2056267916"
        #endif

        bannerView.delegate = self
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(bannerView)
        bannerView.bottomAnchor.constraint(equalTo: tabBar.topAnchor, constant: 0).isActive = true
        bannerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        bannerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        
        view.bringSubviewToFront(tabBar)
    }
}

extension TabbarVC: GADBannerViewDelegate {
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
      print("adViewDidReceiveAd")
    }

    /// Tells the delegate an ad request failed.
    func adView(_ bannerView: GADBannerView,
        didFailToReceiveAdWithError error: GADRequestError) {
      print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }

    /// Tells the delegate that a full-screen view will be presented in response
    /// to the user clicking on an ad.
    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
      print("adViewWillPresentScreen")
    }

    /// Tells the delegate that the full-screen view will be dismissed.
    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
      print("adViewWillDismissScreen")
    }

    /// Tells the delegate that the full-screen view has been dismissed.
    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
      print("adViewDidDismissScreen")
    }

    /// Tells the delegate that a user click will open another app (such as
    /// the App Store), backgrounding the current app.
    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
      print("adViewWillLeaveApplication")
    }
}
