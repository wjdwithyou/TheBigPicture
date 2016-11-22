//
//  mode_node.swift
//  TheBigPicture
//
//  Created by mac on 2016. 11. 1..
//  Copyright © 2016년 RadioactiveTEA. All rights reserved.
//

import Foundation

class Node {
    var id:Int
    var parent_id:Int
    var components:Array<Component>
    
    init(id:Int,parent_id:Int) {
        self.id = id
        self.parent_id = parent_id
        self.components = []
    }
    
    func addComponent(element:Component) -> Void {
        components.append(element)
    }
    func removeComponent(element:Component) -> Void {
    }
}
