import UIKit

class LoginPageViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Theme.backgroundColor
        
        // UserDefaults'tan bilgileri yükle
        usernameTextField.text = UserDefaults.standard.string(forKey: "username")
        passwordTextField.text = UserDefaults.standard.string(forKey: "password")
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
                        let userInfo: [String: String] = [
                            "defaultAccount": response.DefaultAccount,
                            "username": username,
                            "password": password
                        ]
                        
                        // Eğer bilgiler daha önce kaydedilmediyse, popup göster
                        if UserDefaults.standard.bool(forKey: "isUserCredentialsSaved") == false {
                            self.askToSaveCredentials(userInfo: userInfo)
                        } else {
                            self.performSegue(withIdentifier: "GoToPortfolioPage", sender: userInfo)
                        }
                    } else {
                        self.showAlert(title: "Hata", message: response.Result.Description)
                    }
                }
            }
        }
    }
    
    func askToSaveCredentials(userInfo: [String: String]) {
        let alertController = UIAlertController(title: "Bilgiler Kaydedilsin Mi?", message: nil, preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Evet", style: .default) { (_) in
            // User Defaults'a bilgileri kaydet
            UserDefaults.standard.set(userInfo["username"], forKey: "username")
            UserDefaults.standard.set(userInfo["password"], forKey: "password")
            UserDefaults.standard.set(true, forKey: "isUserCredentialsSaved")
            
            self.performSegue(withIdentifier: "GoToPortfolioPage", sender: userInfo)
        }
        
        let cancelAction = UIAlertAction(title: "Hayır", style: .cancel) { (_) in
            self.performSegue(withIdentifier: "GoToPortfolioPage", sender: userInfo)
        }
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Tamam", style: .default, handler: nil)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToPortfolioPage" {
            if let portfolioVC = segue.destination as? PortfolioViewController,
               let userInfo = sender as? [String: String] {
                portfolioVC.defaultAccount = userInfo["defaultAccount"]
                portfolioVC.userName = userInfo["username"]
                portfolioVC.userPassword = userInfo["password"]
            }
        }
    }
}
