//
//  AppDelegate.swift
//  Example
//
//  Created by Omid Golparvar on 9/5/18.
//  Copyright © 2018 Omid Golparvar. All rights reserved.
//

import UIKit
import IDOneSignal

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?


	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		
		IDOneSignal.Setup(baseURL: "", appID: "", routes: ("", ""))
		
		return true
	}
	
}

