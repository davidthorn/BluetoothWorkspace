//
//  PeripheralCell.swift
//  DataSenderApp
//
//  Created by Thorn, David on 28.03.20.
//  Copyright © 2020 Thorn, David. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell, BaseCellProtocol {

    var identifier: String?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: Self.cellIdentifer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static var cellIdentifer: String {
        String(describing: Self.self)
    }

}

final class PeripheralCell: BaseTableViewCell {

    override func prepareForReuse() {
        super.prepareForReuse()
        identifier = nil
        textLabel?.text = nil
        imageView?.image = nil
    }

}
