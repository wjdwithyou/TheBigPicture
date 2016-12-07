//
//  ViewController.swift
//  TheBigPicture
//
//  Created by RadioactiveTEA on 2016. 11. 1..
//  Copyright © 2016년 RadioactiveTEA. All rights reserved.
//

import UIKit

class Controller_Cascade: UIViewController
{
    var map_view_node:[Int:View_CascadeNode]
    
    @IBOutlet weak var scroll_view: UIScrollView!
    
    required init?(coder aDecoder: NSCoder)
    {
        self.map_view_node = [:]
        
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
        self.scroll_view.frame.size.height = self.view.frame.height
        
        self.render()
    }
    
    func render()
    {
        let content_height = self.arrange_cascade(pos: CGPoint(x:10, y:10), node: s_node_container.root_node!)
        
        self.scroll_view.contentSize.height = content_height
        
        for node in s_node_container.map_node
        {
            if self.map_view_node[node.1.id] == nil
            {
                let new_view_node = View_CascadeNode(model:node.1)
                
                self.map_view_node[node.value.id] = new_view_node
                self.scroll_view.addSubview(new_view_node.button)
            }
            else
            {
                self.map_view_node[node.1.id]?.model = node.1
            }
            
            self.map_view_node[node.1.id]?.render()
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
            
            child_y += self.arrange_cascade(child_pos, node:s_node_container.get_node(child.id))
        }
        
        node.x = pos.x
        node.y = pos.y
    
        return child_y
    }


}

