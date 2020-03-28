//
//  PeripheralItem.swift
//  DataSenderApp
//
//  Created by Thorn, David on 28.03.20.
//  Copyright © 2020 Thorn, David. All rights reserved.
//

import UIKit
import ResuableTableViewController
import CoreBluetooth

struct PeripheralItem: IdentifiableItem, Hashable {

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
