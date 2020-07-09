//
//  CategoryTableViewController.swift
//  ToDoey
//
//  Created by Chitralekha Yellewar on 06/07/20.
//  Copyright © 2020 Chitralekha Yellewar. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryTableViewController: UITableViewController {
    var categoryArray: Results<Category>?
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCategories()
    }
    
    @IBAction func addItem(sender: UIBarButtonItem) {
        var categoryTextField = UITextField()
        let alert = UIAlertController(title: "Add Category", message: "", preferredStyle: .alert)
        alert.addTextField { (textField) in
            categoryTextField = textField
        }
        
        let alertAction = UIAlertAction(title: "ok", style: .default) { addCategory in
            let newCategory = Category()
            newCategory.title = categoryTextField.text!
            
            self.save(category: newCategory)
        }
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
    
    func save(category: Category) {
        do {
            try realm.write{
                realm.add(category)
            }
        } catch {
            print("Error while saving category")
        }
        self.tableView.reloadData()
    }
    
    func getCategories() {
        categoryArray = realm.objects(Category.self)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController

        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray?[indexPath.row]
        }
    }
}

extension CategoryTableViewController {
    //MARK:- table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let categoryCell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        if let category = categoryArray?[indexPath.row] {
            categoryCell.textLabel?.text = category.title
        } else {
            categoryCell.textLabel?.text = "No Category added"
        }
        
        return categoryCell
    }
    
    //MARK:- table view delegates
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showItems", sender: self)
    }
}
