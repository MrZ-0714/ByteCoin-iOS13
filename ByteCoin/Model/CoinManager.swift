//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didGetPrice(price: String, currency: String, coin: String)
    func didFailWithError(error: Error)
}

struct CoinManager {
    var delegate: CoinManagerDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/"
    let apiKey = "5B21FAC2-9A14-44EB-9BE4-A5AF365A2124"
    
    let currencyArray = ["USD","CNY","CAD","EUR","GBP","HKD"]
    let coinArray = ["BTC", "DOGE"]
    
    func getCoinPrice(currency selectedCurrency: String, coin selectedCoin: String) {
        
        if let finalURL = URL(string: "\(baseURL)\(selectedCoin)/\(selectedCurrency)?apikey=\(apiKey)") {
            print("URL used to make the API request: ", finalURL)
            
            let task = URLSession.shared.dataTask(with: finalURL) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                
                guard let data = data else {
                    print("data is not available")
                    return
                }
                let parsedData = String(format: "%.4f", parseJSON(data))
                delegate?.didGetPrice(price: parsedData, currency: selectedCurrency, coin: selectedCoin)
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
            delegate?.didFailWithError(error: error)
            return 0.0
        }
    }
    
}
