//
//  ViewController.swift
//  TheBigPicture
//
//  Created by RadioactiveTEA on 2016. 11. 1..
//  Copyright © 2016년 RadioactiveTEA. All rights reserved.
//

import UIKit

class Controller_MindMap: UIViewController
{
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .lightContent
    }
    
    override func viewDidLoad()
    {
        self.view.backgroundColor = UIColor(white:0.9, alpha: 1)

        self.add_button(x:10, y:320,  text:"한양대학교")
        
        self.add_button(x:120, y:240, text:"데이터베이스")
        self.add_button(x:120, y:340, text:"인공지능")
        self.add_button(x:120, y:410, text:"융합소프트웨어프로젝트")
        
        self.add_button(x:230, y:240,  text:"과제")
        self.add_button(x:340, y:220, text:"데이터베이스 생성")
        self.add_button(x:340, y:260, text:"쿼리문 작성")
        
        self.add_button(x:230, y:340, text:"시험")
        
        self.add_button(x:230, y:410, text:"과제")
        self.add_button(x:340, y:410, text:"동영상촬영")
    }
    
    func add_button(x:CGFloat, y:CGFloat, text:String)
    {
        let btn = UIButton()
        
        btn.frame.origin.x = x
        btn.frame.origin.y = y
        btn.frame.size.width = 100
        btn.frame.size.height = 20
        btn.layer.cornerRadius = 5
        
        btn.backgroundColor = UIColor(red: 0.21, green: 0.37, blue: 0.45, alpha: 1)
        
        btn.setTitle(text, for: UIControlState.normal)
        self.view.addSubview(btn)
    }
    
    func arrange_cascade(pos:CGPoint, node:Model_Node) -> CGFloat
    {
        let stride_x:CGFloat = 100
        let node_height:CGFloat = 20
        var child_y:CGFloat = node_height + 5
        
        for child in node.children
        {
            var child_pos = CGPoint(x:0, y:0)
            
            child_pos.x = pos.x + stride_x
            child_pos.y = pos.y + child_y
            
            child_y += self.arrange_cascade(pos:child_pos, node:child)
        }
        
        node.x = pos.x
        node.y = pos.y
        
        return child_y
    }
    
    
}

