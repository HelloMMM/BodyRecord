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
import Hero

var tabbarVC: ESTabBarController!
var tabBarColor: UIColor!

protocol TabbarVCDelegate {
    func showMenu()
}

enum MenuType {
    case historical
    case chart
    case question
}

class TabbarVC: ESTabBarController {

    var bannerView: GADBannerView!
    var interstitial: GADInterstitial!
    var mainVC: MainVC!
    var addVC: UIViewController!
    var moreVC: MoreVC!
    var fatVC: FatVC!
    var caloriesVC: CaloriesVC!
    var setData: Dictionary<String, Any> = [:] {
        didSet {
            
            mainVC.setData = setData
            fatVC.setData = setData
            caloriesVC.setData = setData
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interstitial = createAndLoadInterstitial()
        if !isRemoveAD {
            addBannerViewToView()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(removeAD), name: NSNotification.Name("RemoveAD") , object: nil)
        
        let main = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainVC") as! MainVC
        main.dalegate = self
        
        let fat = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FatVC") as! FatVC
        fat.dalegate = self
        
        let calories = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CaloriesVC") as! CaloriesVC
        calories.dalegate = self
        
        let more = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MoreVC") as! MoreVC
        more.delegate = self
        
        mainVC = main
        fatVC = fat
        addVC = UIViewController()
        addVC.hero.isEnabled = true
        caloriesVC = calories
        moreVC = more
        
        changeStyle(Style(rawValue: appStyle)!)
        
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
            
            self!.addClick()
        }
        
        if UserDefaults.standard.object(forKey: "setData") != nil {
            let setData = UserDefaults.standard.object(forKey: "setData") as! Dictionary<String, Any>
            self.setData = setData
        }
        
        tabbarVC = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if UserDefaults.standard.object(forKey: "firstStart") == nil {
            
            let testVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TestVC") as! TestVC
            testVC.alpha = 0.7
            testVC.testVCDelegate = self
            
            present(testVC, animated: true, completion: nil)
            UserDefaults.standard.set(false, forKey: "firstStart")
        }
        
    }
    
    @objc func removeAD(notification: NSNotification) {
            
        isRemoveAD = true
        
        if bannerView != nil {
            bannerView.removeFromSuperview()
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
    
    func addClick() {
        
        let setVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SetVC") as! SetVC
        setVC.delegate = self
        present(setVC, animated: true, completion: nil)
        
        if UserDefaults.standard.object(forKey: "setData") != nil {
            var setData = UserDefaults.standard.object(forKey: "setData") as! Dictionary<String, Any>
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy/MM/dd"
            let date = formatter.string(from: Date())
            setData["date"] = date
            setVC.setData = setData
        }
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

extension TabbarVC: TabbarVCDelegate, MySlideMeunDelegate {
    
    func showMenu() {
        
        let mySlideMeunVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MySlideMeunVC") as! MySlideMeunVC
        mySlideMeunVC.delegate = self
        present(mySlideMeunVC, animated: true, completion: nil)
    }
    
    func itemClick(_ menuType: MenuType) {
        
        var vc: UIViewController?
        
        if menuType == .historical {
            vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HistoricalRecordVC") as! HistoricalRecordVC
            present(vc!, animated: false, completion: nil)
        } else if menuType == .chart {
            vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChartVC") as! ChartVC
            present(vc!, animated: false, completion: nil)
        } else if menuType == .question {
            
            let urlString =  "itms-apps:itunes.apple.com/us/app/apple-store/id1520163103?mt=8&action=write-review"
            let url = URL(string: urlString)!
            UIApplication.shared.open(url, completionHandler: nil)
        }
    }
}

extension TabbarVC: MoreVCDelegate {
 
    func changeStyle(_ style: Style) {
        
        let exampleIrregularityContentView = ExampleIrregularityContentView()
        exampleIrregularityContentView.imageView.hero.isEnabled = true
        exampleIrregularityContentView.imageView.hero.isEnabledForSubviews = true
        exampleIrregularityContentView.imageView.hero.id = "ContentView"
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
        
        var bgColor: UIColor!
        var basicColor: UIColor!
        if style == .blue {
            
            tabBarColor = UIColor(red: 10/255.0, green: 66/255.0, blue: 91/255.0, alpha: 1.0)
            bgColor = UIColor(red: 165.0/255.0, green: 222.0/255.0, blue: 228.0/255.0, alpha: 1.0)
            basicColor = UIColor.init(red: 23/255.0, green: 149/255.0, blue: 158/255.0, alpha: 1.0)
        } else if style == .yellow {
            
            tabBarColor = UIColor(red: 217.0/255.0, green: 127.0/255.0, blue: 71.0/255.0, alpha: 1.0)
            bgColor = UIColor(red: 248.0/255.0, green: 223.0/255.0, blue: 152.0/255.0, alpha: 1.0)
            basicColor = UIColor(red: 246.0/255.0, green: 189.0/255.0, blue: 96.0/255.0, alpha: 1.0)
            
        } else {
            tabBarColor = UIColor(red: 243.0/255.0, green: 163.0/255.0, blue: 178.0/255.0, alpha: 1.0)
            bgColor = UIColor(red: 245.0/255.0, green: 202.0/255.0, blue: 195.0/255.0, alpha: 1.0)
            basicColor = UIColor(red: 227.0/255.0, green: 141.0/255.0, blue: 131.0/255.0, alpha: 1.0)
        }
        
        tabBar.backgroundColor = tabBarColor
        
        mainVC.view.backgroundColor = bgColor
        mainVC.topView.backgroundColor = tabBarColor
        
        fatVC.view.backgroundColor = bgColor
        fatVC.topView.backgroundColor = tabBarColor
            
        caloriesVC.view.backgroundColor = bgColor
        caloriesVC.topView.backgroundColor = tabBarColor
        
        moreVC.view.backgroundColor = bgColor
        moreVC.topView.backgroundColor = tabBarColor
        
        exampleIrregularityContentView.imageView.backgroundColor = basicColor
        basicContentView1.highlightTextColor = basicColor
        basicContentView1.highlightIconColor = basicColor
        basicContentView2.highlightTextColor = basicColor
        basicContentView2.highlightIconColor = basicColor
        basicContentView3.highlightTextColor = basicColor
        basicContentView3.highlightIconColor = basicColor
        basicContentView4.highlightTextColor = basicColor
        basicContentView4.highlightIconColor = basicColor
        
        mainVC.tabBarItem = ESTabBarItem(basicContentView1, title: "BMI", image: UIImage(named: "bmi"), selectedImage: UIImage(named: "bmi_1"))
        fatVC.tabBarItem = ESTabBarItem(basicContentView2, title: "體脂肪", image: UIImage(named: "fat"), selectedImage: UIImage(named: "fat"))
        addVC.tabBarItem = ESTabBarItem(exampleIrregularityContentView, title: nil, image: UIImage(named: "add"), selectedImage: UIImage(named: "add"))
        caloriesVC.tabBarItem = ESTabBarItem(basicContentView3, title: "代謝率", image: UIImage(named: "calories"), selectedImage: UIImage(named: "calories"))
        moreVC.tabBarItem = ESTabBarItem(basicContentView4, title: "更多", image: UIImage(named: "more"), selectedImage: UIImage(named: "more"))
    }
}

extension TabbarVC: SetVCDelegate {
    
    func setData(_ data: Dictionary<String, Any>) {
        
        setData = data
        UserDefaults.standard.set(data, forKey: "setData")
        
        if !isRemoveAD {
            if interstitial.isReady {
                interstitial.present(fromRootViewController: self)
            } else {
                interstitial = createAndLoadInterstitial()
            }
        }
        
        let _ = coreDataConnect.insert(coreDataName, attributeInfo: data)
        let selectResult = coreDataConnect.retrieve(coreDataName, predicate: nil, sort: [["date": false]], limit: nil)
        
        if let results = selectResult {
            userData = results
        }
    }
}

extension TabbarVC: GADInterstitialDelegate {
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {

        interstitial = createAndLoadInterstitial()
    }
}

extension TabbarVC: TestVCDelegate {
    
    func enterMain() {
        
        addClick()
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
