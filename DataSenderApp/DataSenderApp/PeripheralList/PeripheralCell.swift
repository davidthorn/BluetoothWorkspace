//
//  PeripheralCell.swift
//  DataSenderApp
//
//  Created by Thorn, David on 28.03.20.
//  Copyright © 2020 Thorn, David. All rights reserved.
//

import UIKit
import ResuableTableViewController

final class PeripheralCell: BaseTableViewCell {

    override func prepareForReuse() {
        super.prepareForReuse()
        identifier = nil
        textLabel?.text = nil
        imageView?.image = nil
    }

}
