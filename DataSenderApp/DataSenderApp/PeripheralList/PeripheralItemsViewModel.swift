//
//  PeripheralItemsViewModel.swift
//  DataSenderApp
//
//  Created by Thorn, David on 28.03.20.
//  Copyright © 2020 Thorn, David. All rights reserved.
//

import UIKit
import ResuableTableViewController

final class PeripheralItemsViewModel<T: PeripheralItemProtocol & Hashable>: ReuseableTableViewModelProtocol {

    typealias PeripheralItemHandler = (Item) -> Void

    typealias Item = T

    private let items = Items<T>()

    var didRemove: PeripheralItemHandler = { _ in }

    var didAdd: PeripheralItemHandler = { _ in }

    var didChange: PeripheralItemHandler = { _ in }

    func add(item: Item) {
        guard !items.contains(item: item) else { return }
        items.add(item: item)
        didAdd(item)
    }

    func remove(item: Item) {
        guard items.contains(item: item) else { return }
        items.remove(item: item)
        didRemove(item)
    }

    func update(item: Item) {
        guard items.contains(item: item) else { return }
        items.update(item: item)
        didChange(item)
    }

    func load(completion: @escaping ([Item]) -> Void) {
        completion(items.allItems)
    }

    func didSelect(item: Item) {
        debugPrint("Item was selected \(item.identifier)")
        let delegate = (UIApplication.shared.delegate as? AppDelegate)
        guard let navigationController = delegate?.window?.rootViewController as? UINavigationController else { return }
        
        let detailViewController = PeripheralDetailViewController(item: item)
        navigationController.pushViewController(detailViewController, animated: true)

        delegate?.centralManager.connect(peripheral: item.peripheral)
        
    }


}
