//
//  LoginResponseModel.swift
//  Trader
//
//  Created by Nazlıcan Çay on 15.09.2023.
//

import Foundation

struct LoginResponseModel: Codable {
    let Result: ResultModel
    let AccountList: [String]
    let DefaultAccount: String
    let CustomerID: String
    let UserRights: [UserRight]
    let AccountItems: [AccountItem]
    let MarketDataToken: String
    let CustomerName: String
    let ExCode: Int
   
}

struct ResultModel: Codable {
    let State: Bool
    let Code: Int
    let Description: String
    let SessionKey: String
    let Duration: Int
    let MsgType: String
   
}

struct UserRight: Codable {
    let Code: String
    let Key: String
    let Value: String
    let Timestamp: Int
    let DataType: Int
}

struct AccountItem: Codable {
    let AccountID: String
    let ExchangeAccountID: [String: String]
    let AccountRights: [AccountRight]
   
}

struct AccountRight: Codable {
    let Code: String
    let Key: String
    let Value: String
    let Timestamp: Int
    let DataType: Int
}



