//
//  BaseTableViewCell.swift
//  ResuableTableViewController
//
//  Created by Thorn, David on 28.03.20.
//  Copyright © 2020 Thorn, David. All rights reserved.
//

import UIKit

open class BaseTableViewCell: UITableViewCell, BaseCellProtocol {

    public var identifier: String?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: Self.cellIdentifer)
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public static var cellIdentifer: String {
        String(describing: Self.self)
    }

}
