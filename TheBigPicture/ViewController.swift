//
//  ViewController.swift
//  TheBigPicture
//
//  Created by RadioactiveTEA on 2016. 11. 1..
//  Copyright © 2016년 RadioactiveTEA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func arrange_cascade(pos:CGPoint, node:Node)
    {
        var stride_x:CGFloat = 100;
        var node_height:CGFloat = 20;
        var child_y:CGFloat = node_height + 5;
        
        for child in node.children
        {
            var child_pos:CGPoint;
            
            child_pos.x = pos.x + stride_x
            child_pos.y = pos.y + child_y
            
            child_y += arrange_cascade(pos:child_pos, node:child);
        }
        
        node.x = pos.x;
        node.y = pos.y;
    
        return child_y;
    }


}

