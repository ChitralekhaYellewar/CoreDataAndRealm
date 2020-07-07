//
//  ViewController.swift
//  ToDoey
//
//  Created by Chitralekha Yellewar on 03/07/20.
//  Copyright © 2020 Chitralekha Yellewar. All rights reserved.
//

import UIKit
import CoreData

class ToDoListViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    var itemArray: [Item] = []
    
    var selectedCategory : ItemCategory? {
        didSet {
            tableView.reloadData()
        }
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

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
            let newItem = Item(context: self.context)
            newItem.name = itemTextField.text
            newItem.check = false
            newItem.isCategory = self.selectedCategory
            self.itemArray.append(newItem)
            self.save()
        }
        
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK:- core data methods
    func save() {
        do {
            try context.save()
        } catch {
            print("Error while saving data.")
        }
        self.tableView.reloadData()
    }
    
    func getItems(with request:NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil) {
        
        let categoryPredicate = NSPredicate(format: "isCategory.title MATCHES %@", selectedCategory!.title!)
        
        if let predicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, predicate])
        } else {
            request.predicate = categoryPredicate
        }
        
        do {
            try itemArray = context.fetch(request)
        } catch {
            print("Error while fetching data")
        }
        self.tableView.reloadData()
    }
}

extension ToDoListViewController {
    
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
        
        //Delete
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
//        save()
    }
    
}

//MARK:- Search bar
extension ToDoListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let fetchRequest : NSFetchRequest<Item> = Item.fetchRequest()
        
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        getItems(with: fetchRequest, predicate: NSPredicate(format: "name CONTAINS[cd] %@",searchBar.text!))
        
    }
    
}
