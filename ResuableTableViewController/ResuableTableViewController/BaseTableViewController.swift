//
//  BaseTableViewController.swift
//  ResuableTableViewController
//
//  Created by Thorn, David on 28.03.20.
//  Copyright © 2020 Thorn, David. All rights reserved.
//

import UIKit
import CoreBluetooth

open class BaseTableViewController<BaseCell: UITableViewCell & BaseCellProtocol,T: ReuseableTableViewModelProtocol>: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private let tableview = UITableView()
    private var items: Items<T.Item> = Items<T.Item>()
    private var viewModel: T

    public init(viewModel: T) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override open func viewDidLoad() {
        super.viewDidLoad()

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

        viewModel.didAdd = { [weak self] item in
            self?.shouldAddItem(item: item)
        }

        viewModel.load { [weak self] loadedItems in
            self?.addInitialItems(items: loadedItems)
        }
    }

    // MARK: Table View Methods

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items.get(index: indexPath.row)

        guard var baseCell = tableView.dequeueReusableCell(withIdentifier: BaseCell.cellIdentifer,
                                                           for: indexPath) as? BaseCell  else {
            return UITableViewCell()
        }

        baseCell.identifier = item.identifier
        item.setup(cell: baseCell)
        return baseCell
    }

    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    // MARK: Helper Methods

    private func addInitialItems(items: [T.Item]) {
        let notLoadeditems = items.filter { !self.items.contains(item: $0) }

        let indexPaths = self.createIndexPaths(from: notLoadeditems, currentCount: items.count)

        guard !notLoadeditems.isEmpty else { return }

        self.addItems(items: notLoadeditems, indexPaths: indexPaths)
    }

    private func shouldAddItem(item: T.Item) {
        guard !items.contains(item: item) else { return  }

        let count = self.items.count
        self.addItems(items: [item], indexPaths: [IndexPath(row: count, section: 0)])
    }

    private func addItems(items: [T.Item] , indexPaths: [IndexPath]) {
        DispatchQueue.main.async {
            self.tableview.beginUpdates()
            self.tableview.insertRows(at: indexPaths, with: .automatic)
            self.items.add(items: items)
            self.tableview.endUpdates()
        }
    }

    private func createIndexPaths(from items: [T.Item], currentCount: Int) -> [IndexPath] {
        var indexPaths = [IndexPath]()
        _ = items.reduce(IndexPath(row: currentCount, section: 0)) { (indexPath, item) -> IndexPath in
            let path = IndexPath.init(row: indexPath.row + 1, section: indexPath.section)
            indexPaths.append(path)
            return path
        }
        return indexPaths
    }

}

open class ReuseableTableViewController<BaseCell: UITableViewCell & BaseCellProtocol, T: ReuseableTableViewModelProtocol>: BaseTableViewController<BaseCell, T> {

    override open func viewDidLoad() {
        super.viewDidLoad()
    }

}

