//
//  PickerInput.swift
//  TestGenericPicker
//
//  Created by Bhupendra Yadav on 2015-05-31.
//  Copyright (c) 2015 Bhupendra Yadav. All rights reserved.
//

import Foundation


struct PickerInput<T>: PickerDataSource {
    typealias ItemType = T
    var data = [[ItemType]]()
    
    // MARK: - PickerDataSource protocol implementation
    var components:Int {
        return data.count
    }
    
    func rowsInComponent(component:Int) -> Int {
        precondition(component < self.components, "Out of bounds component")
        return data[component].count
    }
    
    func titleForRow(row:Int, inComponent:Int) -> String {
        precondition(inComponent < components, "Out of bounds component")
        precondition(rowsInComponent(inComponent) > row, "Out of bounds row \(row) for component \(inComponent)")
        return ("\(data[inComponent][row])")
    }
    
    // MARK: - Mutating/creation interface
    /**
    Internal function to add components to the data
    
    :param: component Index of component to add
    */
    mutating func createComponents(component:Int) {
        // If component does not exist then add components till that point
        if (component >= components) {
            for index in components...component {
                data.append([ItemType]())
            }
        }
    }
    
    /**
    Insert one row for a component
    
    :param: component Component index
    :param: item      Item to insert, should be of type ItemType/T
    */
    mutating func insertItemForComponent(component:Int, item:ItemType) {
        createComponents(component)
        data[component].append(item)
    }
    
    /**
    Add an array of rows to a component
    
    :param: component Component index
    :param: items     An array of items of type ItemType/T
    */
    mutating func insertComponent(component:Int, items:[ItemType]) {
        createComponents(component)
        data[component] += items
    }
}
