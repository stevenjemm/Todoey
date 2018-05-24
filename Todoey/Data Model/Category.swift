//
//  Category.swift
//  Todoey
//
//  Created by Steven Jemmott on 22/05/2018.
//  Copyright © 2018 Steven Jemmott. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
