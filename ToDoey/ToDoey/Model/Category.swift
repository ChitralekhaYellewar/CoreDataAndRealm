//
//  ItemCategory.swift
//  ToDoey
//
//  Created by Chitralekha Yellewar on 08/07/20.
//  Copyright © 2020 Chitralekha Yellewar. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var title: String = ""
    
    var items = List<Item>()
}
