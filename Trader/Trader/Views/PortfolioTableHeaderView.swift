//
//  PortfolioTableHeaderView.swift
//  Trader
//
//  Created by Nazlıcan Çay on 16.09.2023.
//

import UIKit

import UIKit

import UIKit

class PortfolioTableHeaderView: UITableViewHeaderFooterView {

    let symbolLabel = UILabel()
    let qtyLabel = UILabel()
    let priceLabel = UILabel()
    let totalLabel = UILabel()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        symbolLabel.text = "Menkul"
        symbolLabel.textAlignment = .center  // Center align text
        symbolLabel.textColor = .white

        qtyLabel.text = "Miktar T2"
        qtyLabel.textAlignment = .center  // Center align text
        qtyLabel.textColor = .white

        priceLabel.text = "Fiyat"
        priceLabel.textAlignment = .center  // Center align text
        priceLabel.textColor = .white

        totalLabel.text = "Tutar"
        totalLabel.textAlignment = .center  // Center align text
        totalLabel.textColor = .white

        self.contentView.backgroundColor = .blue  // Set background color to blue

        let stackView = UIStackView(arrangedSubviews: [symbolLabel, qtyLabel, priceLabel, totalLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually

        addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: self.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: self.rightAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    


    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
