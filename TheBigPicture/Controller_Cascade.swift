//
//  ViewController.swift
//  TheBigPicture
//
//  Created by RadioactiveTEA on 2016. 11. 1..
//  Copyright © 2016년 RadioactiveTEA. All rights reserved.
//

import UIKit

enum EDIT_MODE
{
    case NORMAL
    case ADD
    case DELETE
}

class Controller_Cascade: UIViewController
{
    var edit_mode:EDIT_MODE
    var map_view_node:[Int:View_CascadeNode]
    var map_view_node_by_button:[UIButton:View_CascadeNode]
    
    @IBOutlet weak var scroll_view: UIScrollView!
    
    required init?(coder aDecoder: NSCoder)
    {
        self.map_view_node = [:]
        self.map_view_node_by_button = [:]
        self.edit_mode = EDIT_MODE.NORMAL
        
        super.init(coder: aDecoder)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .lightContent
    }
    
    override func viewDidLoad()
    {
        self.view.backgroundColor = UIColor(white:0.9, alpha: 1)
        
        self.scroll_view.frame.size.width = self.view.frame.width
        self.scroll_view.frame.size.height = self.view.frame.height - 40 - 74
        self.scroll_view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.transit_normal_mode)))
        
        let fab = KCFloatingActionButton()
        fab.addItem(title: "Delete", handler:
        {
            item in
            self.transit_delete_mode()
        })
        fab.addItem(title: "New", handler:
        {
            item in
            self.transit_add_mode()
        })
        self.view.addSubview(fab)
        
        self.render()
    }
    
    func transit_add_mode()
    {
        for view_node in self.map_view_node
        {
            view_node.value.button.layer.borderWidth = 4
            view_node.value.button.layer.borderColor = UIColor(red:1, green:1, blue:0.0, alpha: 1.0).cgColor
        }
        
        self.edit_mode = EDIT_MODE.ADD
    }
    
    func transit_delete_mode()
    {
        for view_node in self.map_view_node
        {
            view_node.value.button.layer.borderWidth = 4
            view_node.value.button.layer.borderColor = UIColor(red:1, green:0.0, blue:0.0, alpha: 1.0).cgColor
        }
        
        self.edit_mode = EDIT_MODE.DELETE
    }
    
    func transit_normal_mode()
    {
        for view_node in self.map_view_node
        {
            view_node.value.button.layer.borderWidth = 0
        }
        
        self.edit_mode = EDIT_MODE.NORMAL
    }
    
    func create_view_node(model:Model_Node)
    {
        var new_view_node = View_CascadeNode(model:model)
        
        new_view_node.button.addTarget(self, action: #selector(self.pressed(sender:)), for: .touchUpInside)
        
        self.map_view_node[model.id] = new_view_node
        self.map_view_node_by_button[new_view_node.button] = new_view_node
        self.scroll_view.addSubview(new_view_node.button)
    }
    
    func render()
    {
        let content_height = self.arrange_cascade(pos: CGPoint(x:10, y:10), node: s_node_container.root_node!)
        
        self.scroll_view.contentSize.height = content_height + 10
        
        for node in s_node_container.map_node
        {
            if self.map_view_node[node.value.id] == nil
            {
                self.create_view_node(model:node.value)
            }
            else
            {
                self.map_view_node[node.value.id]?.model = node.value
            }
            
            self.map_view_node[node.value.id]?.render()
        }
    }
    
    func arrange_cascade(pos:CGPoint, node:Model_Node) -> CGFloat
    {
        let stride_x:CGFloat = 50
        let node_height:CGFloat = 40
        var child_y:CGFloat = node_height + 10
        
        for child in node.children
        {
            var child_pos = CGPoint(x:0, y:0)
            
            child_pos.x = pos.x + stride_x
            child_pos.y = pos.y + child_y
            
            child_y += self.arrange_cascade(pos: child_pos, node:s_node_container.get_node(node_id: child.id))
        }
        
        node.x = pos.x
        node.y = pos.y
        
        return child_y
    }
    
    func pressed(sender: UIButton!)
    {
        let view_node = self.map_view_node_by_button[sender]!
        
        if self.edit_mode == EDIT_MODE.ADD
        {
            let model_node = s_node_container.create_node(node_id:s_node_index, parent_id:view_node.model.id)
            
            s_node_index = s_node_index + 1
            s_node_container.attach_child(parent_id:model_node.parent_id, child_id:model_node.id)
            
            self.render()
        }
        
        if self.edit_mode == EDIT_MODE.DELETE
        {
            s_node_container.delete_node(node_id:view_node.model.id)
            view_node.button.removeFromSuperview()
            
            self.map_view_node[view_node.model.id] = nil
            self.map_view_node_by_button[view_node.button] = nil
            
            self.render()
        }
        
        if self.edit_mode == EDIT_MODE.NORMAL
        {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            let vc = storyboard.instantiateViewController(withIdentifier: "DetailVC") as! Controller_Detail
            
            vc.receivedText = String(describing: sender.titleLabel!.text!)
            
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func unwindToPrev(segue:UIStoryboardSegue)
    {

    }
}

