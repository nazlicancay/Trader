//
//  NetworkManager.swift
//  Trader
//
//  Created by Nazlıcan Çay on 15.09.2023.
//

// NetworkManager.swift

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func login(username: String, password: String, completion: @escaping (LoginResponseModel?, Error?) -> Void) {
        let urlString = "https://tbpilot.matriksdata.com/9999/Integration.aspx?MsgType=A&CustomerNo=0&Username=\(username)&Password=\(password)&AccountID=0&ExchangeID=4&OutputType=2"
        
        guard let url = URL(string: urlString) else {
            completion(nil, NSError(domain: "Invalid URL", code: 0, userInfo: nil))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            print(data)
            guard let data = data, error == nil else {
                completion(nil, error)
                return
            }
            
            do {
                let responseModel = try JSONDecoder().decode(LoginResponseModel.self, from: data)
                print(responseModel.Result.State)
                DispatchQueue.main.async {
                    completion(responseModel, nil)
                }
            } catch let jsonError {
                DispatchQueue.main.async {
                    completion(nil, jsonError)
                }
            }
        }.resume()
    }

}

