//
//  ViewController.swift
//  TestGenericPicker
//
//  Created by Bhupendra Yadav on 2015-05-31.
//  Copyright (c) 2015 Bhupendra Yadav. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    let numberOfSections = 1
    let numberOfRows = 3
    var rowCount = 0
    
    var intComponentCount = 5
    var intRowCount = 10
    var doubleComponentCount = 3
    var doubleRowCount = 10
    var stringComponentCount = 2
    var stringRowCount = 10
    
    enum ValueTypes{
        case IntegerValues
        case DoubleValues
        case StringValues
    }
    
    var cellOrder = [ValueTypes]()
    
    var pickerIndexPath:NSIndexPath?
    var pickerPurpose:ValueTypes?

    override func viewDidLoad() {
        super.viewDidLoad()

        rowCount = numberOfRows
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 44
        cellOrder = [.IntegerValues, .DoubleValues, .StringValues]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Picker data generation
    func generateIntegarData(row:Int, component:Int) -> PickerInput<Int> {
        var data = PickerInput<Int>()
        
        for index in 0..<component {
            var intArray = [Int]()
            for i in 0..<row {
                intArray.append(i)
            }
            data.insertComponent(index, items: intArray)
        }
        
        return data
    }
    
    func generateDoubleData(row:Int, component:Int) -> PickerInput<Double> {
        var data = PickerInput<Double>()
        
        for index in 0..<component {
            var intArray = [Double]()
            for i in 0..<row {
                intArray.append(Double(i)*0.99)
            }
            data.insertComponent(index, items: intArray)
        }
        
        return data
    }

    func generateStringData(row:Int, component:Int) -> PickerInput<String> {
        var data = PickerInput<String>()
        
        for index in 0..<component {
            var intArray = [String]()
            for i in 0..<row {
                intArray.append("Comp \(index) Row \(i)")
            }
            data.insertComponent(index, items: intArray)
        }
        
        return data
    }

    
    // MARK: - Picker addition and removal
    func insertPickerViewAtIndexPath(indexPath:NSIndexPath) {
        tableView.beginUpdates()
        pickerPurpose = cellOrder[indexPath.row]
        pickerIndexPath = NSIndexPath(forRow: indexPath.row+1, inSection: 0)
        tableView.insertRowsAtIndexPaths([pickerIndexPath!], withRowAnimation: .Automatic)
        rowCount++
        tableView.endUpdates()
    }
    
    func removePickerViewFromIndexPath() {
        tableView.beginUpdates()
        tableView.deleteRowsAtIndexPaths([pickerIndexPath!], withRowAnimation: .Automatic)
        pickerIndexPath = nil
        pickerPurpose = nil
        rowCount = numberOfRows
        tableView.endUpdates()
    }

    
    // MARK: - TableView datasource
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return numberOfSections
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowCount
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {


        if (indexPath == pickerIndexPath) {
            var cell = tableView.dequeueReusableCellWithIdentifier("GenericPickerViewCell") as! GenericPickerTableViewCell
            switch pickerPurpose! {
            case .IntegerValues:
                cell.dataSource = generateIntegarData(intRowCount, component: intComponentCount)
            case .DoubleValues:
                cell.dataSource = generateDoubleData(doubleRowCount, component: doubleComponentCount)
            case .StringValues:
                cell.dataSource = generateStringData(stringRowCount, component: stringComponentCount)
            }
            return cell
        }
        
        var cell = tableView.dequeueReusableCellWithIdentifier("BasicCell") as! UITableViewCell
        switch cellOrder[indexPath.row] {
        case .IntegerValues:
            cell.textLabel!.text = "Integer"
            cell.detailTextLabel!.text = "\(intComponentCount) components \(intRowCount) rows"
        case .DoubleValues:
            cell.textLabel!.text = "Double"
            cell.detailTextLabel!.text = "\(doubleComponentCount) components \(doubleRowCount) rows"
        case .StringValues:
            cell.textLabel!.text = "String"
            cell.detailTextLabel!.text = "\(stringComponentCount) components \(stringRowCount) rows"
        }

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: false)

        tableView.beginUpdates()
        if pickerIndexPath != nil {
            removePickerViewFromIndexPath()
        } else {
            insertPickerViewAtIndexPath(indexPath)
        }
        tableView.endUpdates()
    }
}

