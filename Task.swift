import RealmSwift

class Task: Object {
    
    @objc dynamic var category: String = "none"
    
    @objc dynamic var id = 0
    
    @objc dynamic var title = ""
    
    @objc dynamic var contents = ""
    
    @objc dynamic var date = Date()
    
    override static func primaryKey() -> String? {
        return "id"
        
    }
}

//
//  Task.swift
//  taskapp
//
//  Created by 吉谷拓海 on 2020/06/15.
//  Copyright © 2020 takumi.yoshiya. All rights reserved.
//
