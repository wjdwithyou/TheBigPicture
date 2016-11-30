//
//  ViewController.swift
//  TheBigPicture
//
//  Created by RadioactiveTEA on 2016. 11. 1..
//  Copyright © 2016년 RadioactiveTEA. All rights reserved.
//

import UIKit

class View_Cascade: UIView {
    var node_container:Model_NodeContainer

    override init(frame: CGRect) {
        self.node_container = Model_NodeContainer()
        super.init(frame:frame)
        self.initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.node_container = Model_NodeContainer()
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    func initialize()
    {
        self.backgroundColor = UIColor(white:0.9, alpha: 1)
        
        self.add_button(x:20, y:30,  text:"한양대학교")
        self.add_button(x:60, y:80,  text:"데이터베이스")
        self.add_button(x:100, y:130,  text:"과제")
        self.add_button(x:140, y:180, text:"데이터베이스 생성")
        self.add_button(x:140, y:230, text:"쿼리문 작성")
        self.add_button(x:60, y:280, text:"인공지능")
        self.add_button(x:100, y:330, text:"시험")
        self.add_button(x:60, y:380, text:"융합소프트웨어프로젝트")
        self.add_button(x:100, y:430, text:"과제")
        self.add_button(x:140, y:480, text:"동영상촬영")
    }
    
    func add_button(x:CGFloat, y:CGFloat, text:String)
    {
        let btn = UIButton()
        
        btn.frame.origin.x = x
        btn.frame.origin.y = y
        btn.frame.size.width = 200
        btn.frame.size.height = 40
        btn.layer.cornerRadius = 10
        
        btn.backgroundColor = UIColor(red: 0.21, green: 0.37, blue: 0.45, alpha: 1)
        
        btn.setTitle(text, for: UIControlState.normal)
        self.addSubview(btn)
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

