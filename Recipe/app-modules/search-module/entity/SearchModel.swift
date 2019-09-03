//
//  SearchModel.swift
//  Recipe
//
//  Created by Soft Xpert on 9/2/19.
//  Copyright © 2019 Soft Xpert. All rights reserved.
//

import Foundation
import RealmSwift
class SearchModel:Object{
    @objc dynamic var search:String = ""
    @objc dynamic var date:Date = Date()
}
