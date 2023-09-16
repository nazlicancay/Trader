//
//  PortfolioViewController.swift
//  Trader
//
//  Created by Nazlıcan Çay on 16.09.2023.
//

import UIKit

class PortfolioViewController: UIViewController {

    var defaultAccount: String?
    var userName: String?
    var userPassword: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let defaultAccount = defaultAccount {
            print("Gelen Default Account: \(defaultAccount)")
            print("Gelen username: \(userName)")
            print("Gelen password: \(userPassword)")
        }
        
        if let defaultAccount = defaultAccount,
           let username = userName,
           let password = userPassword {
            NetworkManager.shared.getPortfolio(for: defaultAccount, username: username, password: password) { result in
                switch result {
                case .success(let portfolioResponse):
                    if portfolioResponse.Result.State {
                        for item in portfolioResponse.Item {
                            print("AccountID: \(item.AccountID), Symbol: \(item.Symbol), Qty_T: \(item.Qty_T2), Qty_T1: \(item.LastPx) , Tutar:\(Int(item.LastPx*item.Qty_T2))")
                        }
                    } else {
                        print("Hata: \(portfolioResponse.Result.Description)")
                    }
                case .failure(let error):
                    print("Hata: \(error)")
                }
            }
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
