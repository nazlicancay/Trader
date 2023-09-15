//
//  Theme.swift
//  Trader
//
//  Created by Nazlıcan Çay on 15.09.2023.
//

import UIKit

struct Theme {
    
    // MARK: - Colors
    
    static let backgroundColor: UIColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0) //  bir gri tonu
    static let textColor: UIColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0) // Karanlık gri
    static let buttonColor: UIColor = UIColor(red: 0.1, green: 0.6, blue: 0.9, alpha: 1.0) // Mavi

    // MARK: - Fonts
    
    static let primaryFont: UIFont = UIFont(name: "Helvetica", size: 18)!
    
    // MARK: - Apply Theme
    
    static func apply() {
        let sharedApplication = UIApplication.shared
        sharedApplication.delegate?.window??.tintColor = buttonColor
        sharedApplication.delegate?.window??.backgroundColor = backgroundColor
        
    }
}
