//
//  View_Node.swift
//  TheBigPicture
//
//  Created by RadioactiveTEA on 2016. 11. 22..
//  Copyright © 2016년 RadioactiveTEA. All rights reserved.
//

import Foundation
import UIKit

class View_Component : NSObject
{
    var y: CGFloat = 0.0
    var ctrl_detail:Controller_Detail
    
    init(ctrl_detail:Controller_Detail)
    {
        self.ctrl_detail = ctrl_detail
    }
    
    func getContentSize() -> CGFloat{ return 0 }
    func render() {}
}

class View_Component_Text : View_Component, UITextViewDelegate
{
    var model:Model_Component_Text
    
    var text_view:UITextView
    
    let textViewWidth: CGFloat = 390
    let textViewHeight: CGFloat = 50
    let textViewInterval: CGFloat = 15
    let textViewOriginX: CGFloat = 10
    let textViewOriginY: CGFloat = 75
    
    init(model:Model_Component_Text, ctrl_detail:Controller_Detail)
    {
        self.model = model
        
        self.text_view = UITextView()
        
        self.text_view.frame.size.width = self.textViewWidth
        self.text_view.frame.size.height = self.textViewHeight
        self.text_view.layer.cornerRadius = 5
        
        self.text_view.frame.origin.x = self.textViewOriginX
        
        self.text_view.backgroundColor = UIColor.white
        self.text_view.tintColor = UIColor.blue
        
        super.init(ctrl_detail:ctrl_detail)
        
        self.text_view.delegate = self
        self.text_view.text = self.model.text
        
        self.render()
    }
    
    override func render()
    {
        self.text_view.frame.origin.y = CGFloat(self.y)
        
        self.resize()
    }
    
    func resize()
    {
        let contentSize = self.text_view.sizeThatFits(self.text_view.bounds.size)
        var frame = self.text_view.frame
        frame.size.height = contentSize.height
        self.text_view.frame = frame
    }
    
    override func getContentSize() -> CGFloat
    {
        let contentSize = self.text_view.sizeThatFits(self.text_view.bounds.size)
        
        return contentSize.height
    }
    
    func textViewDidChange(_ textView: UITextView)
    {
        self.ctrl_detail.render()
        self.model.text = textView.text
    }
}
