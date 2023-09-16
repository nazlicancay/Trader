//
//  PortfolioResponseModel.swift
//  Trader
//
//  Created by Nazlıcan Çay on 16.09.2023.
//

struct PortfolioResponse: Codable {
    let Result: PortfolioResult
    let Item: [PortfolioItem]
}

struct PortfolioResult: Codable {
    let State: Bool
    let Code: Int
    let Description: String
    let SessionKey: String
}

struct PortfolioItem: Codable {
    let ProtectionOrderID: String
    let AccountID: String
    let Symbol: String
   // let `Type`: String
    let Qty_T: Double
    let Qty_T1: Double
    let Qty_T2: Double
    let LastPx: Double
}
