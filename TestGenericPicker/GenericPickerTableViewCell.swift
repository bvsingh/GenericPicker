//
//  GenericPickerTableViewCell.swift
//  TestGenericPicker
//
//  Created by Bhupendra Yadav on 2015-05-31.
//  Copyright (c) 2015 Bhupendra Yadav. All rights reserved.
//

import UIKit

class GenericPickerTableViewCell: UITableViewCell, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var dataSource:PickerDataSource? {
        didSet {
            pickerView.reloadAllComponents()
            resetRowSelectionForAllComponents()
        }
    }

    @IBOutlet weak var pickerView: UIPickerView!
    
    private func resetRowSelectionForAllComponents() {
        if (dataSource != nil) {
            for index in 0..<dataSource!.components {
                pickerView.selectRow(0, inComponent: index, animated: false)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        pickerView.delegate = self
        pickerView.dataSource = self
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - UIPickerViewDataSource implementation
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        if let data = dataSource {
            return data.components
        }
        return 0
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if let data = dataSource {
            return data.rowsInComponent(component)
        }
        return 0
    }
    
    // MARK: - UIPickerViewDelegate implementation
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        if let data = dataSource {
            return data.titleForRow(row, inComponent: component)
        }
        return nil
    }
}
