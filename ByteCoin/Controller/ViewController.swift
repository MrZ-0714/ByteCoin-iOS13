//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var coinLabel: UILabel!
    
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //currencyPicker.dataSource = self
        coinManager.delegate = self
        currencyPicker.delegate = self
        // Do any additional setup after loading the view.
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return coinManager.currencyArray.count
        } else {
            return coinManager.coinArray.count
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return coinManager.currencyArray[row]
        } else {
            return coinManager.coinArray[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            let selectedCurrency = coinManager.currencyArray[row]
            let selectedRowInComponent_1 = currencyPicker.selectedRow(inComponent: 1)
            let selectedCoin = coinManager.coinArray[selectedRowInComponent_1]
            coinManager.getCoinPrice(currency: selectedCurrency, coin: selectedCoin)
        } else {
            let selectedCoin = coinManager.coinArray[row]
            let selectedRowInComponent_0 = currencyPicker.selectedRow(inComponent: 0)
            let selectedCurrency = coinManager.currencyArray[selectedRowInComponent_0]
            coinManager.getCoinPrice(currency: selectedCurrency, coin: selectedCoin)
        }
        
    }
    
}

//MARK: - CoinManagerDelegate

extension ViewController: CoinManagerDelegate {
    func didFailWithError(error: Error) {
        print(error)
    }
    
    func didGetPrice(price: String, currency: String, coin: String) {
        DispatchQueue.main.async {
            self.bitcoinLabel.text = price
            self.currencyLabel.text = currency
            self.coinLabel.text = coin
        }
    }
}
