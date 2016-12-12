//
//  View_Component.swift
//  TheBigPicture
//
//  Created by J.Style on 2016. 11. 22..
//  Copyright © 2016년 J.Style. All rights reserved.
//

import Foundation
import UIKit

class View_Component : NSObject
{
    let commonComponentWidth: CGFloat = 390
    let commonComponentOriginX: CGFloat = 10
    
    var ctrl_detail:Controller_Detail
    
    var y: CGFloat = 0.0
    
    init(ctrl_detail:Controller_Detail)
    {
        self.ctrl_detail = ctrl_detail
    }
    
    func render(){
        
    }
    
    func resize(){
        
    }
    
    func getContentSize() -> CGFloat{
        return 0
    }
}

class View_Component_Text : View_Component, UITextViewDelegate
{
    let textViewHeight: CGFloat = 50    // default
    
    var model: Model_Component_Text
    var text_view: UITextView
    
    init(model: Model_Component_Text, ctrl_detail: Controller_Detail)
    {
        self.model = model
        self.text_view = UITextView()
        
        super.init(ctrl_detail: ctrl_detail)
        
        self.text_view.frame.size.width = self.commonComponentWidth
        self.text_view.frame.size.height = self.textViewHeight
        self.text_view.layer.cornerRadius = 5
        
        self.text_view.frame.origin.x = self.commonComponentOriginX
        
        self.text_view.backgroundColor = UIColor.white
        self.text_view.tintColor = UIColor.blue
        
        self.text_view.delegate = self
        self.text_view.text = self.model.text
        
        self.render()
    }
    
    override func render(){
        self.text_view.frame.origin.y = CGFloat(self.y)
        self.resize()
    }
    
    override func resize(){
        let contentSize = self.text_view.sizeThatFits(self.text_view.bounds.size)
        var frame = self.text_view.frame
        frame.size.height = contentSize.height
        self.text_view.frame = frame
    }
    
    override func getContentSize() -> CGFloat{
        let contentSize = self.text_view.sizeThatFits(self.text_view.bounds.size)
        
        return contentSize.height
    }
    
    func textViewDidChange(_ textView: UITextView)
    {
        self.ctrl_detail.render()
        self.model.text = textView.text
    }
}

class View_Component_Date: View_Component
{
    let datePickerHeight: CGFloat = 100
    let dateform = DateFormatter()
    
    var model: Model_Component_Date
    var date_picker: UIDatePicker
    
    init(model: Model_Component_Date, ctrl_detail: Controller_Detail)
    {
        self.dateform.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        self.model = model
        self.date_picker = UIDatePicker()
        
        super.init(ctrl_detail: ctrl_detail)
        
        self.date_picker.frame.size.width = self.commonComponentWidth
        self.date_picker.frame.size.height = self.datePickerHeight
        self.date_picker.layer.cornerRadius = 5
        
        self.date_picker.frame.origin.x = self.commonComponentOriginX
        
        self.date_picker.backgroundColor = UIColor.white
        self.date_picker.tintColor = UIColor.blue
        
        self.date_picker.datePickerMode = UIDatePickerMode.dateAndTime
        
        let datetime = self.dateform.date(from: self.model.date)
        
        if let unwrappedDate = datetime{
            self.date_picker.setDate(unwrappedDate, animated: true)
        }
    }
    
    override func render(){
        self.date_picker.frame.origin.y = CGFloat(self.y)
    }
    
    override func getContentSize() -> CGFloat{
        return self.datePickerHeight
    }
}
