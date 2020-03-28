//
//  AppDelegate.swift
//  DataSenderApp
//
//  Created by Thorn, David on 28.03.20.
//  Copyright © 2020 Thorn, David. All rights reserved.
//

import UIKit
import CoreBluetooth
import ResuableTableViewController
import BluetoothCentralApp

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var centralManager = BluetoothCentralApp()

    var window: UIWindow?

    let viewModel = PeripheralItemsViewModel<PeripheralItem>()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        let didDiscover: (CBPeripheral) -> Void = { peripheral in
            let item = PeripheralItem(peripheral: peripheral)
            self.viewModel.add(item: item)
        }

        let rootViewController = ReuseableTableViewController<PeripheralCell, PeripheralItemsViewModel>(viewModel: viewModel)

        centralManager.didDiscover = didDiscover

        let navigationController = UINavigationController(rootViewController: rootViewController)
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        return true
    }


    


}

