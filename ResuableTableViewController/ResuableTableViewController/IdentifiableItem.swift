//
//  IdentifiableItem.swift
//  ResuableTableViewController
//
//  Created by Thorn, David on 28.03.20.
//  Copyright © 2020 Thorn, David. All rights reserved.
//

import UIKit

public protocol IdentifiableItem {
    var identifier: String { get }
    func setup(cell: UITableViewCell)
}
