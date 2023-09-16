//
//  PortfolioViewController.swift
//  Trader
//
//  Created by Nazlıcan Çay on 16.09.2023.
//

import UIKit

class PortfolioViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var PortfoliosTableView: UITableView!
    var defaultAccount: String?
    var userName: String?
    var userPassword: String?
    var portfolioItems: [PortfolioItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PortfoliosTableView.dataSource = self
        PortfoliosTableView.delegate = self
        
        
        if let defaultAccount = defaultAccount,
           let username = userName,
           let password = userPassword {
            NetworkManager.shared.getPortfolio(for: defaultAccount, username: username, password: password) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let portfolioResponse):
                        if portfolioResponse.Result.State {
                            self.portfolioItems = portfolioResponse.Item
                            self.PortfoliosTableView.reloadData()
                            for item in portfolioResponse.Item {
                                print("lastPx: \(item.LastPx), Symbol: \(item.Symbol), Qty_T2: \(item.Qty_T2), Tutar: \(Int(item.Qty_T2 * item.LastPx))")

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
        
       
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return portfolioItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("cellForRowAt is being called")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PortfolioCellIdentifier", for: indexPath) as! PortfolioTableViewCell
        let portfolioItem = portfolioItems[indexPath.row]
        cell.CostLabel.textColor = .black
        cell.LastPxLabel.textColor = .black
        cell.Qty_T2Label.textColor = .black
        
        cell.SymbolLabel.text = String(portfolioItem.Symbol)
        cell.Qty_T2Label.text = String(portfolioItem.Qty_T2)
        cell.LastPxLabel.text = String(portfolioItem.LastPx)
        cell.CostLabel.text   = String (Int(portfolioItem.Qty_T2 * portfolioItem.LastPx))
        
        
        return cell
           
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
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
