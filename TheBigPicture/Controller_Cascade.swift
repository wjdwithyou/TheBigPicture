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
        self.scroll_view.frame.size.height = self.view.frame.height - 40 - 74
        
        let fab = KCFloatingActionButton()
        fab.addItem(title: "Edit")
        fab.addItem(title: "Delete")
        fab.addItem(title: "New")
        self.view.addSubview(fab)
        
        self.render()
    }
    
    func render()
    {
        let content_height = self.arrange_cascade(pos: CGPoint(x:10, y:10), node: s_node_container.root_node!)
        
        self.scroll_view.contentSize.height = content_height + 10
        
        for node in s_node_container.map_node
        {
            if self.map_view_node[node.value.id] == nil
            {
                let new_view_node = View_CascadeNode(model:node.value)
                
                new_view_node.button.addTarget(self, action: #selector(self.pressed(sender:)), for: .touchUpInside)
                
                self.map_view_node[node.value.id] = new_view_node
                self.scroll_view.addSubview(new_view_node.button)
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
    
    func pressed(sender: UIButton!){
        //print("\(sender.titleLabel!.text!)")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailVC") as! Controller_Detail
        
        vc.receivedText = String(describing: sender.titleLabel!.text!)
        
        self.present(vc, animated: true, completion: nil)
    }
    
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CascadeSegue" {
            if let destination = segue.destination as? Controller_Detail {
                destination.receivedText = "seguePassTest";
            }
        }
    }
    */
    
    @IBAction func unwindToPrev(segue:UIStoryboardSegue){
        //print("unwindToCascade")
    }
}

