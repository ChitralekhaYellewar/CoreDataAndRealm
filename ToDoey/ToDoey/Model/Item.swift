//
//  Item.swift
//  ToDoey
//
//  Created by Chitralekha Yellewar on 08/07/20.
//  Copyright © 2020 Chitralekha Yellewar. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var check: Bool = false
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
