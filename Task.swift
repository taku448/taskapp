import RealmSwift

class Task: Object {
    
    @obj dynamic var id = 0
    
    @pbj dynamic var titme = ""
    
    @obj dynamic var contents = ""
    
    @obj dynamic var date = Date()
    
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
