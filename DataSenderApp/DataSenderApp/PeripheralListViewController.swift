//
//  PeripheralListViewController.swift
//  DataSenderApp
//
//  Created by Thorn, David on 28.03.20.
//  Copyright © 2020 Thorn, David. All rights reserved.
//

import UIKit
import BluetoothCentralApp
import CoreBluetooth

protocol BaseCellProtocol {
    static var cellIdentifer: String { get }
    var identifier: String? { get set }
}

protocol Identifiable {
    var identifier: String { get }
    func setup(cell: UITableViewCell)
}

final class Items<Item: Identifiable & Hashable>: Hashable {

    private var items = [Item]()
    private let queue = DispatchQueue(label: "items.queue")

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

    func hash(into hasher: inout Hasher) {
        hasher.combine(items)
        hasher.combine(queue)
        hasher.combine(count)
    }

    static func == (lhs: Items<Item>, rhs: Items<Item>) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }

}

class PeripheralListViewController<BaseCell: UITableViewCell & BaseCellProtocol, Item: Identifiable & Hashable>: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let tableview = UITableView()

    let centerApp = BluetoothCentralApp()
    var items: Items<Item> = Items<Item>()

    var didDiscover: (CBPeripheral) -> Void = { _ in }

    override func viewDidLoad() {
        super.viewDidLoad()

        centerApp.didDiscover = { peripheral in
            DispatchQueue.main.async { [weak self] in
                self?.didDiscover(peripheral)
            }
        }

        view.backgroundColor = .white
        tableview.register(BaseCell.self, forCellReuseIdentifier: BaseCell.cellIdentifer)
        tableview.delegate = self
        tableview.dataSource = self
        view.addSubview(tableview)

        tableview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableview.topAnchor.constraint(equalTo: view.topAnchor),
            tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }



    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items.get(index: indexPath.row)

        guard var baseCell = tableView.dequeueReusableCell(withIdentifier: BaseCell.cellIdentifer,
                                                           for: indexPath) as? BaseCell  else {
            return UITableViewCell()
        }

        baseCell.identifier = item.identifier
        item.setup(cell: baseCell)
        return baseCell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }


}

