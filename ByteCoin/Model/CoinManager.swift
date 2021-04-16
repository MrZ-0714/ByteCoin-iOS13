//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC/"
    let apiKey = "5B21FAC2-9A14-44EB-9BE4-A5AF365A2124"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getCoinPrice(for selectedCurrency: String) {
        
        if let finalURL = URL(string: "\(baseURL)\(selectedCurrency)?apikey=\(apiKey)") {
            
            let task = URLSession.shared.dataTask(with: finalURL) { (data, response, error) in
                if error != nil {
                    print(error!)
                }
                
                guard let data = data else { return }
                print(String(data: data, encoding: .utf8)!)
                return
            }
            
            task.resume()
        }

    }
    
}
