//
//  ReuseableTableViewModelProtocol.swift
//  ResuableTableViewController
//
//  Created by Thorn, David on 28.03.20.
//  Copyright © 2020 Thorn, David. All rights reserved.
//

import Foundation

public protocol ReuseableTableViewModelProtocol {
    associatedtype Item: IdentifiableItem & Hashable

    var didRemove: (Item) -> Void { get set }
    var didAdd: (Item) -> Void { get set }
    var didChange: (Item) -> Void { get set }

    func add(item: Item)
    func remove(item: Item)
    func update(item: Item)
    func load(completion: @escaping ([Item]) -> Void)
    func didSelect(item: Item)
}
