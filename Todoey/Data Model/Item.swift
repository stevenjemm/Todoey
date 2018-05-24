//
//  Item.swift
//  Todoey
//
//  Created by Steven Jemmott on 22/05/2018.
//  Copyright © 2018 Steven Jemmott. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    
    let parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
