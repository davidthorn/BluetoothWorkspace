//
//  PeripheralDetailViewController.swift
//  DataSenderApp
//
//  Created by Thorn, David on 28.03.20.
//  Copyright © 2020 Thorn, David. All rights reserved.
//

import UIKit
import CoreBluetooth

class PeripheralDetailViewController<T: PeripheralItemProtocol & Hashable>: UIViewController {

    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    private let item: T

    init(item: T) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 0

        view.addSubview(scrollView)
        scrollView.addSubview(stackView)

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])

        addTitle(text: "Main title")
        addLine()
        addSpacer()
        addTitle(text: "Periphal Name")
        add(text: item.name ?? "Unknown")
        addLine()
        addSpacer()
        addTitle(text: "Peripheral Name")
        add(text: item.identifier)

        addTitle(text: "Connection")
        switch item.peripheral.state {
        case .connected:
            add(text: "Connected")
        case .connecting:
            add(text: "Connecting")
        case .disconnected:
            add(text: "Disconected")
        case .disconnecting:
            add(text: "Disconnecting")
        @unknown default:
            fatalError()
        }

        addLine()
        addSpacer()
    }

    func addLine() {
        let lineView = UIView()
        lineView.backgroundColor = .clear
        stackView.addArrangedSubview(lineView)
        lineView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lineView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }

    func addTitle(text: String) {
        add(text: text, attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .bold)
        ])
    }

    func add(text: String, attributes: [NSAttributedString.Key: Any] = [:]) {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: text, attributes: attributes)
        label.numberOfLines = 0
        stackView.addArrangedSubview(label)
    }

    func addSpacer() {
        let spacerView = UIView()
        spacerView.backgroundColor = .clear
        stackView.addArrangedSubview(spacerView)
        spacerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            spacerView.heightAnchor.constraint(equalToConstant: 15)
        ])
    }

}
