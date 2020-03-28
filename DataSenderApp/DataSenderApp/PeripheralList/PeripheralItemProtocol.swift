//
//  PeripheralItemProtocol.swift
//  DataSenderApp
//
//  Created by Thorn, David on 28.03.20.
//  Copyright © 2020 Thorn, David. All rights reserved.
//

import Foundation
import CoreBluetooth
import ResuableTableViewController

protocol PeripheralItemProtocol: IdentifiableItem {
    var identifier: String { get }
    var name: String? { get }
    var peripheral: CBPeripheral  { get }
}
