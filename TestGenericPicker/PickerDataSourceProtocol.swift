//
//  PickerDataSourceProtocol.swift
//  TestGenericPicker
//
//  Created by Bhupendra Yadav on 2015-05-31.
//  Copyright (c) 2015 Bhupendra Yadav. All rights reserved.
//

import Foundation

protocol PickerDataSource {
    var components:Int {get}
    func rowsInComponent(section:Int) ->Int
    func titleForRow(row:Int, inComponent:Int) -> String
}
