//
//  BluetoothCentralApp.swift
//  BluetoothCentralApp
//
//  Created by Thorn, David on 28.03.20.
//  Copyright © 2020 Thorn, David. All rights reserved.
//

import Foundation
import CoreBluetooth

public final class BluetoothCentralApp: NSObject, CBCentralManagerDelegate {

    public var didDiscover: (CBPeripheral) -> Void = { _ in }

    private var centralManager: CBCentralManager?

    private let queue = DispatchQueue(label: "BluetoothCentralApp.queue" , attributes: .concurrent)

    public override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: queue)
    }

    public func centralManagerDidUpdateState(_ central: CBCentralManager) {
        guard isPoweredOn(state: central.state) else {
            return handleState(state: central.state)
        }

        startScanning()
    }

    private func isPoweredOn(state: CBManagerState) -> Bool {
        state == .poweredOn
    }

    private func handleState(state: CBManagerState) {

    }

    private func startScanning() {
        centralManager?.scanForPeripherals(withServices: nil, options: nil)
    }

    public func centralManager(_ central: CBCentralManager,
                               didDiscover peripheral: CBPeripheral,
                               advertisementData: [String : Any],
                               rssi RSSI: NSNumber) {

        debugPrint("Did discover a peripheral \(String(describing: peripheral.name)) \(peripheral.identifier.uuidString)")
        didDiscover(peripheral)
    }
}
