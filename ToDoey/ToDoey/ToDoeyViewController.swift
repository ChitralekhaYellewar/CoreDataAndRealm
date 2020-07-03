//
//  ViewController.swift
//  ToDoey
//
//  Created by Chitralekha Yellewar on 03/07/20.
//  Copyright © 2020 Chitralekha Yellewar. All rights reserved.
//

import UIKit

class ToDoeyViewController: UITableViewController {
    
    var itemArray: [Item] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tea = Item()
        tea.name = "tea"
        tea.check = false
        itemArray.append(tea)
        itemArray.append(tea)
        itemArray.append(tea)
        itemArray.append(tea)
        itemArray.append(tea)
        itemArray.append(tea)
        itemArray.append(tea)
    }

    @IBAction func addItem(_ sender: UIBarButtonItem) {
        var itemTextField = UITextField()
        
        let alert = UIAlertController(title: "Add Item", message: "", preferredStyle: .alert)
        alert.addTextField { (textField) in
            itemTextField = textField
        }
        
        let alertAction = UIAlertAction(title: "Add", style: .default) { addItem in
            let newItem = Item()
            newItem.name = itemTextField.text
            self.itemArray.append(newItem)
            self.tableView.reloadData()
        }
        
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
}

extension ToDoeyViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let itemCell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath)
        itemCell.textLabel?.text = itemArray[indexPath.row].name
        itemCell.accessoryType = itemArray[indexPath.row].check ? .checkmark : .none
        return itemCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let itemCell = tableView.cellForRow(at: indexPath)
        itemArray[indexPath.row].check = !itemArray[indexPath.row].check

        itemCell?.accessoryType = itemArray[indexPath.row].check ? .none : .checkmark
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
