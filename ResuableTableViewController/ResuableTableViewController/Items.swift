//
//  Items.swift
//  ResuableTableViewController
//
//  Created by Thorn, David on 28.03.20.
//  Copyright © 2020 Thorn, David. All rights reserved.
//

import Foundation

final public class Items<Item: IdentifiableItem & Hashable>: Hashable {

    private var items = [Item]()
    private let queue = DispatchQueue(label: "items.queue")

    public init(items: [Item] = []) {
        self.items = items
    }

    public var allItems: [Item] {
        queue.sync {
            return items
        }
    }

    public var count: Int {
        queue.sync {
            return items.count
        }
    }

    public func contains(item: Item) -> Bool {
        queue.sync {
            return items.contains(where: { $0.identifier == item.identifier })
        }
    }

    public func get(index: Int) -> Item {
        queue.sync {
            guard items.indices.contains(index) else {
                fatalError("Index does not exist")
            }

            return items[index]
        }

    }

    public func add(items: [Item]) {
        items.forEach {
            self.add(item: $0)
        }
    }

    public func add(item: Item) {
        queue.sync {
            guard !items.contains(where: { $0 == item }) else { return }
            items.append(item)
        }
    }

    public func remove(item: Item) {
        queue.sync {
            items.removeAll(where: { $0.identifier == item.identifier})
        }
    }

    public func update(item: Item) {
        queue.sync {
            guard let index = items.firstIndex(where: { $0.identifier == item.identifier }) else { return }
            items[index] = item
        }
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(items)
        hasher.combine(queue)
        hasher.combine(count)
    }

    public static func == (lhs: Items<Item>, rhs: Items<Item>) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }

}
