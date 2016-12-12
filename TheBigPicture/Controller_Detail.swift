//
//  Controller_Detail.swift
//  TheBigPicture
//
//  Created by J.Style on 2016. 12. 8..
//  Copyright © 2016년 J.Style. All rights reserved.
//

import UIKit

class Controller_Detail: UIViewController
{
    @IBOutlet weak var DetailTitle: UINavigationItem!
    
    var model: Model_Node!
    var map_view: [View_Component]
    var map_view_comp_by_date_picker: [UIDatePicker: View_Component]
    
    required init?(coder aDecoder: NSCoder)
    {
        self.map_view = []
        self.map_view_comp_by_date_picker = [:]
        
        super.init(coder: aDecoder)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .lightContent
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.map_view = []
        
        for comp in model.components
        {
            if let comp_name = comp as? Model_Component_Name
            {
                self.DetailTitle.title = comp_name.name
            }
            
            if let comp_text = comp as? Model_Component_Text
            {
                self.add_view_comp_text(model: comp_text)
            }
            
            if let comp_date = comp as? Model_Component_Date
            {
                self.add_view_comp_date(model: comp_date)
            }
        }
        
        let fab = KCFloatingActionButton()
        fab.plusColor = UIColor(red: 30/255.0, green: 45/255.0, blue: 66/255.0, alpha: 1)
        fab.buttonColor = UIColor(white: 0.9, alpha: 1)
        fab.addItem(title: "Text", handler:
            {
                item in
                let model_comp_text = Model_Component_Text(id: s_generic_index, node_id: self.model.id, text: "")
                self.model.add_component(component: model_comp_text)
                self.add_view_comp_text(model:model_comp_text)
                
                s_generic_index += 1
                
                self.render()
            })
        fab.addItem(title: "Date", handler:
            {
                item in
                let model_comp_date = Model_Component_Date(id: s_generic_index, node_id: self.model.id, date_str: "2016-12-13 00:00:00")
                self.model.add_component(component: model_comp_date)
                self.add_view_comp_date(model: model_comp_date)
            
                s_generic_index += 1
            
                self.render()
            })
        
        self.view.addSubview(fab)
        self.render()
    }
    
    func add_view_comp_text(model: Model_Component_Text)
    {
        let new_view_comp_text = View_Component_Text(model: model, ctrl_detail: self)
        
        self.map_view.append(new_view_comp_text)
        self.view.addSubview(new_view_comp_text.text_view)
    }
    
    func add_view_comp_date(model: Model_Component_Date)
    {
        let new_view_comp_date = View_Component_Date(model: model, ctrl_detail: self)
        
        new_view_comp_date.date_picker.addTarget(self, action: #selector(self.datePickerChanged(sender:)), for: .valueChanged)
        
        self.map_view_comp_by_date_picker[new_view_comp_date.date_picker] = new_view_comp_date
        self.map_view.append(new_view_comp_date)
        self.view.addSubview(new_view_comp_date.date_picker)
    }
    
    func render()
    {
        let commonComponentInterval: CGFloat = 10
        var current_y: CGFloat = 80
        
        for view_comp in self.map_view
        {
            view_comp.y = current_y
            view_comp.render()
            
            current_y += view_comp.getContentSize() + commonComponentInterval
        }
    }
    
    func datePickerChanged(sender: UIDatePicker)
    {
        let view_comp_date = self.map_view_comp_by_date_picker[sender] as! View_Component_Date
        
        let strDate = view_comp_date.dateform.string(from: view_comp_date.date_picker.date)
        view_comp_date.model.date = strDate
    }
}
