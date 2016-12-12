//
//  mode_node.swift
//  TheBigPicture
//
//  Created by mac on 2016. 11. 1..
//  Copyright © 2016년 RadioactiveTEA. All rights reserved.
//

import Foundation
import UIKit

class Model_Node
{
    var id:Int
    var parent_id:Int
    var parent:Model_Node?
    var components:Array<Model_Component>
    var children:Array<Model_Node>
    var x:CGFloat
    var y:CGFloat
    
    init(id:Int,parent_id:Int)
    {
        self.id = id
        self.parent_id = parent_id
        self.parent = nil
        self.components = []
        self.children = []
        self.x = 0
        self.y = 0
    }
    
    func add_child(child:Model_Node) -> Void
    {
        children.append(child)
    }
    
    func delete_child(child:Model_Node)
    {
        children = children.filter() { $0 !== child }
    }
    
    func get_all_children_id() -> Array<Int>
    {
        var children_id:Array<Int> = [id]
        
        for child in children
        {
            children_id += child.get_all_children_id()
        }
        
        return children_id
    }
    
    func add_component(component:Model_Component) -> Void
    {
        components.append(component)
    }
    
    func remove_component(component:Model_Component) -> Void
    {
        
    }
    
    func clear_component() -> Void
    {
        components.removeAll()
    }
}

class Model_NodeContainer
{
    var map_node:[Int:Model_Node]
    var root_node:Model_Node?
    
    init()
    {
        self.map_node = [:]
        self.root_node = nil
    }
    
    func create_node(node_id:Int, parent_id:Int) -> Model_Node
    {
        let node = Model_Node(id:node_id, parent_id:parent_id)
    
        if parent_id == -1
        {
            self.root_node = node
        }
    
        self.map_node[node_id] = node
        
        return node
    }
    
    func delete_node(node_id:Int)
    {
        let node = self.get_node(node_id:node_id)
        
        if node.parent != nil
        {
            node.parent!.delete_child(child:node)
        }
        
        self.map_node[node.id] = nil
    }
    
    func attach_child(parent_id:Int, child_id:Int)
    {
        var parent_node = s_node_container.get_node(node_id:parent_id)
        var child_node = s_node_container.get_node(node_id:child_id)
        
        child_node.parent = parent_node
        
        parent_node.add_child(child: child_node)
    }
    
    func get_node(node_id:Int) -> Model_Node
    {
        return self.map_node[node_id]!
    }
}

var s_node_container = Model_NodeContainer()
var s_generic_index = 10000

var test_nodes = [
    Model_Node(id:1,    parent_id:-1),
    Model_Node(id:2,    parent_id:1),
    Model_Node(id:21,   parent_id:2),
    Model_Node(id:22,   parent_id:2),
    Model_Node(id:23,   parent_id:2),
    Model_Node(id:3,    parent_id:1),
    Model_Node(id:31,   parent_id:3),
    Model_Node(id:4,    parent_id:1),
    Model_Node(id:41,   parent_id:4),
    Model_Node(id:42,   parent_id:4),
    Model_Node(id:5,    parent_id:1),
    Model_Node(id:6,    parent_id:1),
    Model_Node(id:7,    parent_id:1)
]

var test_components_name = [
    Model_Component_Name(id:1, node_id:1, name:"한양대학교"),
    Model_Component_Name(id:2, node_id:2, name:"데이터베이스"),
    Model_Component_Name(id:3, node_id:21, name:"과제"),
    Model_Component_Name(id:4, node_id:22, name:"데이터베이스 생성"),
    Model_Component_Name(id:5, node_id:23, name:"쿼리문 작성"),
    Model_Component_Name(id:6, node_id:3, name:"인공지능"),
    Model_Component_Name(id:7, node_id:31, name:"시험"),
    Model_Component_Name(id:8, node_id:4, name:"융합소프트웨어프로젝트"),
    Model_Component_Name(id:9, node_id:41, name:"과제"),
    Model_Component_Name(id:10, node_id:42, name:"동영상촬영"),
    Model_Component_Name(id:11, node_id:5, name:"테스트"),
    Model_Component_Name(id:12, node_id:6, name:"테스트"),
    Model_Component_Name(id:13, node_id:7, name:"테스트")
]

var test_components_text = [
    Model_Component_Text(id: 401, node_id: 4, text: "융소프 내용..."),
    Model_Component_Text(id: 402, node_id: 4, text: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
]

var test_components_date = [
    Model_Component_Date(id: 411, node_id: 41, date: NSDate.init())
]

func initialize_test_data()
{
    for node in test_nodes
    {
        s_node_container.create_node(node_id: node.id, parent_id:node.parent_id)
    }
    
    for var node in test_nodes
    {
        if node.parent_id != -1
        {
            s_node_container.attach_child(parent_id:node.parent_id, child_id:node.id)
        }
    }
    
    for comp in test_components_name
    {
        s_node_container.get_node(node_id: comp.node_id).add_component(component: comp)
    }
    
    for comp in test_components_text
    {
        s_node_container.get_node(node_id: comp.node_id).add_component(component: comp)
    }
    
    for comp in test_components_date
    {
        s_node_container.get_node(node_id: comp.node_id).add_component(component: comp)
    }
}
