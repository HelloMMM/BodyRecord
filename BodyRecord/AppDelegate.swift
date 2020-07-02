//
//  AppDelegate.swift
//  BodyRecord
//
//  Created by HellöM on 2020/6/22.
//  Copyright © 2020 HellöM. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import CoreData

var isRemoveAD: Bool = false
var appStyle = 0
var userData: Array<NSManagedObject> = []
let coreDataName = "User"
let myContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
let coreDataConnect = CoreDataConnect(context: myContext)

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if let style = UserDefaults.standard.object(forKey: "appStyle") {
            
            appStyle = style as! Int
        }
        
        if let removeAD = UserDefaults.standard.object(forKey: "isRemoveAD") {
            
            isRemoveAD = removeAD as! Bool
        }
        
        IQKeyboardManager.shared.enable = true
        
        let selectResult = coreDataConnect.retrieve(coreDataName, predicate: nil, sort: [["date": false]], limit: nil)
        
        if let results = selectResult {
            userData = results
        }
        
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "UserCoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

