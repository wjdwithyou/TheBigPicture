//
//  View_Node.swift
//  TheBigPicture
//
//  Created by RadioactiveTEA on 2016. 11. 22..
//  Copyright © 2016년 RadioactiveTEA. All rights reserved.
//

import Foundation
import UIKit

class View_Component_Text
{
    var model:Model_Component_Text
    var text_view:UITextView
    
    let textViewWidth: CGFloat = 390
    let textViewHeight: CGFloat = 50    // default
    let textViewInterval: CGFloat = 15
    let textViewOriginX: CGFloat = 10
    let textViewOriginY: CGFloat = 75
    
    init(model:Model_Component_Text)
    {
        self.model = model
        
        self.text_view = UITextView()
        
        self.text_view.frame.size.width = self.textViewWidth
        self.text_view.frame.size.height = self.textViewHeight
        self.text_view.layer.cornerRadius = 5
        
        self.text_view.frame.origin.x = self.textViewOriginX
        self.text_view.frame.origin.y = textViewY
        
        self.text_view.backgroundColor = UIColor.white
        self.text_view.tintColor = UIColor.blue
        self.text_view.text = comp_text.text
        
        resizeTextView(sub: self.text_view)
        
        textViewY += (textView.frame.size.height + self.textViewInterval)
        
        self.render()
    }
    
    func render()
    {

    }
    
    func resizeTextView(sub: UITextView){
        let contentSize = sub.sizeThatFits(sub.bounds.size)
        var frame = sub.frame
        frame.size.height = contentSize.height
        sub.frame = frame
    }
    
    func resizeTextView_After(){
        var textViewY: CGFloat = self.textViewOriginY
        
        for sub in self.view.subviews{
            if let subTextView = sub as? UITextView{
                var frame = sub.frame
                frame.origin.y = textViewY
                sub.frame = frame
                
                textViewY += frame.size.height + self.textViewInterval
            }
        }
    }
    
    func handleViewTap(recognizer: UIGestureRecognizer) {
        var cnt = 0
        let index: Int = receivedModel!.id
        let first: Model_Component = (receivedModel!.components.first)!
        
        s_node_container.map_node[index]?.clear_component()
        s_node_container.map_node[index]?.add_component(component: first)
        
        for sub in self.view.subviews{
            if let subTextView = sub as? UITextView{
                cnt += 1
                
                let t_id: Int = index * 100 + cnt
                let comp: Model_Component = Model_Component_Text(id: t_id, node_id: index, text: subTextView.text)
                
                s_node_container.map_node[index]?.add_component(component: comp)
                
                resizeTextView(sub: subTextView)
                subTextView.resignFirstResponder()
            }
        }
        
        resizeTextView_After()
    }
}
