//
//  Company.swift
//  CompanyDetails
//
//  Created by Artyom Kudryashov on 14.03.2020.
//

import Foundation

public struct Company: Decodable {
    public let ticker: String
    public let address: String
    public let city: String
    public let country: String
    public let currency: String
    public let cusip: String
    public let description: String
    public let employeeTotal: String
    public let exchange: String
    public let ggroup: String
    public let gind: String
    public let gsector: String
    public let gsubind: String
    public let ipo: String
    public let isin: String
    public let marketCapitalization: Double
    public let naics: String
    public let naicsNationalIndustry: String
    public let naicsSector: String
    public let naicsSubsector: String
    public let name: String
    public let phone: String
    public let sedol: String
    public let shareOutstanding: Double
    public let state: String
    public let weburl: String
}


//{
//    "address": "1 Apple Park Way",
//    "city": "CUPERTINO",
//    "country": "US",
//    "currency": "USD",
//    "cusip": "037833100",
//    "description": "...",
//    "employeeTotal": "137000",
//    "exchange": "NASDAQ NMS - GLOBAL MARKET",
//    "ggroup": "Technology Hardware & Equipment",
//    "gind": "Technology Hardware, Storage & Peripherals",
//    "gsector": "Information Technology",
//    "gsubind": "Technology Hardware, Storage & Peripherals",
//    "ipo": "1980-12-12",
//    "isin": "US0378331005",
//    "marketCapitalization": 1205139,
//    "naics": "Communications Equipment Manufacturing",
//    "naicsNationalIndustry": "Radio ...ng",
//    "naicsSector": "Manufacturing",
//    "naicsSubsector": "Computer and Electronic Product Manufacturing",
//    "name": "Apple Inc",
//    "phone": "14089961010",
//    "sedol": "2046251",
//    "shareOutstanding": 4375.48,
//    "state": "CALIFORNIA",
//    "ticker": "AAPL",
//    "weburl": "https://www.apple.com/"
//}
