//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didGetPrice(price: String, currency: String)
    func didFailWithError(error: Error)
}

struct CoinManager {
    var delegate: CoinManagerDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC/"
    let apiKey = "5B21FAC2-9A14-44EB-9BE4-A5AF365A2124"
    
    let currencyArray = ["AUD","BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getCoinPrice(for selectedCurrency: String) {
        
        if let finalURL = URL(string: "\(baseURL)\(selectedCurrency)?apikey=\(apiKey)") {
            print("URL used to make the API request: ", finalURL)
            
            let task = URLSession.shared.dataTask(with: finalURL) { (data, response, error) in
                if error != nil {
                    print(error!)
                }
                
                guard let data = data else {
                    print("data is not available")
                    return
                }
                
                print("JSON data back from API", String(data: data, encoding: .utf8)!)
                
                let parsedData = String(format: "%.4f", parseJSON(data))
                
                print("parsedData: ", parsedData)
                
                delegate?.didGetPrice(price: parsedData, currency: selectedCurrency)
                
                return
            }
            
            task.resume()
        }
        
    }
    
    func parseJSON(_ data: Data) -> Double {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: data)
            let lastPrice = decodedData.rate
            return lastPrice
            
        } catch {
            print(error)
            return 0.0
        }
    }
    
}
