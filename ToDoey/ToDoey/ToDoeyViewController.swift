//
//  ViewController.swift
//  ToDoey
//
//  Created by Chitralekha Yellewar on 03/07/20.
//  Copyright © 2020 Chitralekha Yellewar. All rights reserved.
//

import UIKit

class ToDoeyViewController: UITableViewController {
    
    var itemArray = ["tea", "coffee", "breakfast", "lunch"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}

extension ToDoeyViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let itemCell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath)
        itemCell.textLabel?.text = itemArray[indexPath.row]
        return itemCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let itemCell = tableView.cellForRow(at: indexPath)
        itemCell?.accessoryType = .checkmark
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
