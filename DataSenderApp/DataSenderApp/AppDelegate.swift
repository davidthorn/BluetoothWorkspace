//
//  AppDelegate.swift
//  DataSenderApp
//
//  Created by Thorn, David on 28.03.20.
//  Copyright © 2020 Thorn, David. All rights reserved.
//

import UIKit
import CoreBluetooth

struct Item: Identifiable, Hashable {

    var identifier: String
    var name: String?
    init(peripheral: CBPeripheral) {
        identifier = peripheral.identifier.uuidString
        name = peripheral.name ?? "Unknown"
    }
    func setup(cell: UITableViewCell) {
        cell.textLabel?.text = name
        cell.detailTextLabel?.text = identifier

    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        let rootViewController = PeripheralListViewController<PeripheralCell, Item>()

        let didDiscover: (CBPeripheral) -> Void = { peripheral in
            let item = Item(peripheral: peripheral)
            guard !rootViewController.items.contains(item: item) else { return }
            DispatchQueue.main.async {
                rootViewController.tableview.beginUpdates()
                rootViewController.tableview.insertRows(at: [.init(row: rootViewController.items.count, section: 0)],
                                                        with: .automatic)
                rootViewController.items.add(item: item)
                rootViewController.tableview.endUpdates()
            }
        }

        rootViewController.didDiscover = didDiscover

        let navigationController = UINavigationController(rootViewController: rootViewController)
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        return true
    }


    


}

