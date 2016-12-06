//
//  Model_Component.swift
//  TheBigPicture
//
//  Created by J.Style on 2016. 11. 1..
//  Copyright © 2016년 RadioactiveTEA. All rights reserved.
//

import Foundation

enum COMP_TYPE
{
    case NAME
    case TEXT
    case DATE
}

class Model_Component
{
    let id: Int
    let node_id: Int
    let type: COMP_TYPE
    
    init(id: Int, node_id: Int, type: COMP_TYPE)
    {
        self.id = id
        self.node_id = node_id
        self.type = type
    }
}

class Model_Component_Name : Model_Component
{
    var name: String
    
    init(id: Int, node_id: Int, name: String)
    {
        self.name = name
        
        super.init(id:id, node_id:node_id, type:COMP_TYPE.NAME)
    }
}

class Model_Component_Text : Model_Component
{
    var text: String
    
    init(id: Int, node_id: Int, text: String)
    {
        self.text = text
        
        super.init(id:id, node_id:node_id, type:COMP_TYPE.TEXT)
    }
}

class Model_Component_Date : Model_Component
{
    var date: NSDate
    
    init(id: Int, node_id: Int, date: NSDate)
    {
        self.date = date
        
        super.init(id:id, node_id:node_id, type:COMP_TYPE.DATE)
    }
}
