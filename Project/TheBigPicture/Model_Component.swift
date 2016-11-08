//
//  Model_Component.swift
//  TheBigPicture
//
//  Created by J.Style on 2016. 11. 1..
//  Copyright © 2016년 RadioactiveTEA. All rights reserved.
//

import Foundation

class Component{
    let id: Int
    let node_id: Int
    
    init(id: Int, node_id: Int){
        self.id = id
        self.node_id = node_id
    }
}

class Component_Text : Component{
    var text: String
    
    init(id: Int, node_id: Int, text: String){
        self.text = text
        
        super.init(id: id, node_id: node_id)
    }
}

class Component_Date : Component{
    var date: NSDate
    
    init(id: Int, node_id: Int, date: NSDate){
        self.date = date
        
        super.init(id: id, node_id: node_id)
    }
}