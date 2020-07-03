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
        getItems()
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
            self.save()
        }
        
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK:- user defaults methods
    func save() {
        let userDefaults = UserDefaults.standard
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(self.itemArray)
            userDefaults.set(data, forKey: "ItemsArray")
            self.tableView.reloadData()
        } catch {
            print("Error while encoding items array")
        }
    }
    
    func getItems() {
        let decoder = PropertyListDecoder()
        let data = UserDefaults.standard.data(forKey: "ItemsArray")
        do {
            self.itemArray = try decoder.decode([Item].self, from: data!)
        } catch {
            print("Error while decoding")
        }
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
