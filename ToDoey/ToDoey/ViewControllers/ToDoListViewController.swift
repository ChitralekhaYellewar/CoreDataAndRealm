//
//  ViewController.swift
//  ToDoey
//
//  Created by Chitralekha Yellewar on 03/07/20.
//  Copyright © 2020 Chitralekha Yellewar. All rights reserved.
//

import UIKit
import RealmSwift

class ToDoListViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var itemArray: Results<Item>?
    let realm = try! Realm()
    
    var selectedCategory : Category? {
        didSet {
            tableView.reloadData()
        }
    }
    
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
            
            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write {
                        let newItem = Item()
                        newItem.name = itemTextField.text!
                        currentCategory.items.append(newItem)
                    }
                } catch  {
                    print("Error saving new Items")
                }
                
            }
            self.tableView.reloadData()
            
        }

        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
    
    
    func getItems() {
        itemArray = selectedCategory?.items.sorted(byKeyPath: "name", ascending: true)
        self.tableView.reloadData()
    }
}

extension ToDoListViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let itemCell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath)
        if let item = itemArray?[indexPath.row] {
            itemCell.textLabel?.text = item.name
            itemCell.accessoryType = item.check ? .checkmark : .none
        }
        return itemCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = itemArray?[indexPath.row] {
            do {
                try realm.write{
                    item.check = !item.check
                }
            } catch  {
                print("Error while updating item")
            }
        }
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}

//MARK:- Search bar
extension ToDoListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        itemArray = itemArray?.filter("name CONTAINS[cd] %@",searchBar.text!).sorted(byKeyPath: "name", ascending: true)
        self.tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            getItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}
