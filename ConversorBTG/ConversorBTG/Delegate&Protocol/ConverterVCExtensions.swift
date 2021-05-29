//
//  ConverterVCExtensions.swift
//  ConversorBTG
//
//  Created by Filipe Lopes on 21/11/20.
//

import UIKit
//Extensão da ConverterViewController para configurar os dados das pickerViews
extension ConverterViewController: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.myViewModel.getAllCurerncies().count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.myViewModel.setupPickerViewItems(firstPV: self.firstCurrencyPickerView, pickerView: pickerView, row: row)
    }
}
//Extensão da ConverterViewController para definir ação caso uma pickerview mude o seu valor selecionado
extension ConverterViewController: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == self.firstCurrencyPickerView{
            self.myViewModel.changePickerView(firstPv: true, row: row, imageView: firstCurrencyImageView)
        }else{
            self.myViewModel.changePickerView(firstPv: false, row: row, imageView: secondCurrencyImageView)
        }
        self.myViewModel.valueEditingChanged(label: self.resultlabel, value: self.currencyValueTextField.text ?? "0.00")
    }
}
