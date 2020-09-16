//
//  MovementTableViewCell.swift
//  FinerioAppTest
//
//  Created by René Sandoval on 15/09/20.
//  Copyright © 2020 Finerio. All rights reserved.
//

import UIKit

class MovementTableViewCell: UITableViewCell {

    static let id = "MovementCollectionViewCell"

    let container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 5
        return view
    }()

    var moneyImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "dinerio_shield")
        image.contentMode = .scaleAspectFit
        return image
    }()

    var movementLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .mainColor
        return label
    }()

    var categoryLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textColor = .mainColor
        label.layer.backgroundColor = UIColor.red.cgColor
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        return label
    }()


    var amountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.textColor = .mainColor
        return label
    }()

    override func layoutSubviews() {
        super.layoutSubviews()

        self.addSubview(container)

        container.topAnchor(equalTo: self.topAnchor)
        container.bottomAnchor(equalTo: self.bottomAnchor)
        container.leadingAnchor(equalTo: self.leadingAnchor)
        container.trailingAnchor(equalTo: self.trailingAnchor)

        [moneyImage, movementLabel, categoryLabel, amountLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            container.addSubview($0)
        }

        moneyImage.leadingAnchor(equalTo: container.leadingAnchor, constant: 7.5)
        moneyImage.centerYAnchor(equalTo: container.centerYAnchor)
        moneyImage.widthAnchor(equalTo: 50)
        moneyImage.heightAnchor(equalTo: 50)

        movementLabel.topAnchor(equalTo: container.topAnchor, constant: 10)
        movementLabel.leadingAnchor(equalTo: moneyImage.trailingAnchor, constant: 10)
        movementLabel.widthAnchor(equalTo: self.frame.size.width - 170)

        categoryLabel.topAnchor(equalTo: movementLabel.bottomAnchor, constant: 5)
        categoryLabel.leadingAnchor(equalTo: moneyImage.trailingAnchor, constant: 10)
        categoryLabel.widthAnchor(equalTo: self.frame.size.width - 170)
        categoryLabel.heightAnchor(equalTo: 25)

        amountLabel.trailingAnchor(equalTo: container.trailingAnchor, constant: -7.5)
        amountLabel.centerYAnchor(equalTo: container.centerYAnchor)
    }

    func setup(with movement: Movement) {
        movementLabel.text = movement.description?.uppercased()
        categoryLabel.text = movement.concepts?.first?.category?.name
        categoryLabel.layer.backgroundColor = UIColor(hex: movement.concepts?.first?.category?.color ?? "").cgColor
        categoryLabel.textColor = UIColor(hex: movement.concepts?.first?.category?.textColor ?? "")
        categoryLabel.setMargins()
        amountLabel.text = Utils.formatAmount(movement.amount ?? 0.0)
        amountLabel.textColor = UIColor(hex: movement.type == "CHARGE" ? "#C62828" : "#2e7d32")
    }
}
