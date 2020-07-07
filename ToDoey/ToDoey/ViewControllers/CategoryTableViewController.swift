//
//  CategoryTableViewController.swift
//  ToDoey
//
//  Created by Chitralekha Yellewar on 06/07/20.
//  Copyright © 2020 Chitralekha Yellewar. All rights reserved.
//

import UIKit
import CoreData

class CategoryTableViewController: UITableViewController {
    var categoryArray = [ItemCategory]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
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
            let newCategory = ItemCategory(context: self.context)
            newCategory.title = categoryTextField.text
            self.categoryArray.append(newCategory)
            self.saveCategory()
        }
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
    
    func saveCategory() {
        do {
            try context.save()
        } catch {
            print("Error while saving category")
        }
        self.tableView.reloadData()
    }
    
    func getCategories() {
        let fetchRequest : NSFetchRequest<ItemCategory> = ItemCategory.fetchRequest()
        do {
            categoryArray = try context.fetch(fetchRequest)
        } catch {
            print("Error while fetching Categories")
        }
    }
}

extension CategoryTableViewController {
    //MARK:- table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let categoryCell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        categoryCell.textLabel?.text = categoryArray[indexPath.row].title
        return categoryCell
    }
}
