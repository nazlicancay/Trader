//
//  PortfolioViewController.swift
//  Trader
//
//  Created by Nazlıcan Çay on 16.09.2023.
//

import UIKit

class PortfolioViewController: UIViewController {

    var defaultAccount: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let defaultAccount = defaultAccount {
            print("Gelen Default Account: \(defaultAccount)")
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
