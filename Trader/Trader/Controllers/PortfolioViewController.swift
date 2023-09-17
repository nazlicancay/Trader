//
//  PortfolioViewController.swift
//  Trader
//
//  Created by Nazlıcan Çay on 16.09.2023.
//

import UIKit

class PortfolioViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
  
    
    @IBOutlet weak var PortfoliosTableView: UITableView!
    var defaultAccount: String?
    var userName: String?
    var userPassword: String?
    var portfolioItems: [PortfolioItem] = []
    
    let pickerData = ["Alfabetik Sırala", "Artan Fiyat", "Azalan Fiyat"]
    let pickerView = UIPickerView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Theme.backgroundColor
        
        PortfoliosTableView.backgroundColor = Theme.backgroundColor
        PortfoliosTableView.dataSource = self
        PortfoliosTableView.delegate = self
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        pickerView.selectRow(0, inComponent: 0, animated: true)
        
        PortfoliosTableView.register(PortfolioTableHeaderView.self, forHeaderFooterViewReuseIdentifier: "PortfolioHeader")

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
                            self.showAlert(title: "Hata", message: portfolioResponse.Result.Description)
                        }
                    case .failure(let error):
                        print("Hata: \(error)")
                        self.showAlert(title: "Hata", message: error.localizedDescription)
                    }
                }
            }

        }
        
        
       
        
    }
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Tamam", style: .default, handler: nil)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
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
        
        if let formattedTotalCost = formatNumber(portfolioItem.Qty_T2 * portfolioItem.LastPx) {
            cell.CostLabel.text = formattedTotalCost
        }

        
        
        return cell
           
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
           let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "PortfolioHeader") as! PortfolioTableHeaderView
           return headerView
       }
       
       func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
           return 100.0
       }
    
    //MARK: - dip Toplamı bulma fonksiyonu

    func hesaplaToplamTutar() -> Double {
        var toplam: Double = 0.0
        for item in portfolioItems {
            toplam += item.LastPx * Double(item.Qty_T2)
        }
        return toplam
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 40))
        footerView.backgroundColor = .gray

        let label = UILabel(frame: CGRect(x: 10, y: 5, width: tableView.frame.size.width - 20, height: 30))
        label.textColor = .white
        if let formattedTotal = formatNumber(hesaplaToplamTutar()) {
            label.text = "Toplam Tutar: \(formattedTotal)"
        }
        footerView.addSubview(label)

        return footerView
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 40
    }
    
    // MARK: - UIPickerViewDelegate & UIPickerViewDataSource Methods

        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }

        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return pickerData.count
        }

        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return pickerData[row]
        }

        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            switch row {
            case 0:
                self.portfolioItems.sort { $0.Symbol < $1.Symbol }
            case 1:
                self.portfolioItems.sort { $0.Qty_T2 * $0.LastPx < $1.Qty_T2 * $1.LastPx }
            case 2:
                self.portfolioItems.sort { $0.Qty_T2 * $0.LastPx > $1.Qty_T2 * $1.LastPx}
            default:
                break
            }
            self.PortfoliosTableView.reloadData()
            self.dismiss(animated: true, completion: nil)
        }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50.0
    }


    //MARK: - tableview SortByBtn function
    @IBAction func SortByBtn(_ sender: UIButton) {
            self.view.endEditing(true)

            let alert = UIAlertController(title: "\n\n\n\n\n\n", message: nil, preferredStyle: .actionSheet)
            alert.view.addSubview(pickerView)

            let cancel = UIAlertAction(title: "İptal", style: .cancel, handler: nil)
            alert.addAction(cancel)

            present(alert, animated: true, completion: { [unowned self] in
                self.pickerView.frame = CGRect(x: 17, y: 10, width: alert.view.frame.width - 50 , height: 120)
            })
        }
    
    //MARK: - function to diplay numeric datas more easy to read
    func formatNumber(_ number: Double) -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        formatter.groupingSeparator = "."
        return formatter.string(from: NSNumber(value: number))
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
