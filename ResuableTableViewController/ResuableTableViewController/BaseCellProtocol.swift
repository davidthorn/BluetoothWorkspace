//
//  BaseCellProtocol.swift
//  ResuableTableViewController
//
//  Created by Thorn, David on 28.03.20.
//  Copyright © 2020 Thorn, David. All rights reserved.
//

import Foundation

public protocol BaseCellProtocol {
    static var cellIdentifer: String { get }
    var identifier: String? { get set }
}
