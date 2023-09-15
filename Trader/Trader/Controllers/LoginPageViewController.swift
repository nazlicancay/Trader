//
//  LoginPageViewController.swift
//  Trader
//
//  Created by Nazlıcan Çay on 15.09.2023.
//

import UIKit

class LoginPageViewController: UIViewController {
    
    
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Theme.backgroundColor
        
    }
    
    
    
    
    
    @IBAction func LoginBtn(_ sender: Any) {
        
        guard let username = usernameTextField.text,
              let password = passwordTextField.text else { return }
        
        NetworkManager.shared.login(username: username, password: password) { (responseModel, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error: \(error)")
                    self.showAlert(title: "Hata", message: "Bir hata oluştu: \(error.localizedDescription)")
                    return
                }
                
                if let response = responseModel {
                    if response.Result.State {
                        // Gelen veriyle ilgili işlemler
                        // Yönlendirme yapılacak kod burada olacak
                        self.performSegue(withIdentifier: "GoToPortfolioPage", sender: response.DefaultAccount)
                    } else {
                        // Hata mesajını göster
                        self.showAlert(title: "Hata", message: response.Result.Description)
                    }
                }
            }
        }
    }
    
    
    // MARK: -  Popup göstermek için bir helper fonksiyon
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Tamam", style: .default, handler: nil)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToPortfolioPage" {
            if let navController = segue.destination as? UINavigationController,
               let portfolioVC = navController.viewControllers.first as? PortfolioViewController,
               let defaultAccount = sender as? String {
                portfolioVC.defaultAccount = defaultAccount
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
