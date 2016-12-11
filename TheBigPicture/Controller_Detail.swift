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
    
    var model: Model_Node?
    
    var map_view:[View_Component]
    
    required init?(coder aDecoder: NSCoder)
    {
        self.map_view = []
        
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
        
        for comp in (model?.components)!
        {
            if let comp_name = comp as? Model_Component_Name
            {
                self.DetailTitle.title = comp_name.name
            }
            
            if let comp_text = comp as? Model_Component_Text
            {
                var new_view_comp_text = View_Component_Text(model:comp_text, ctrl_detail:self)
                
                self.map_view.append(new_view_comp_text)
                
                self.view.addSubview(new_view_comp_text.text_view)
            }
        }

        self.render()
    }
    
    override func viewDidAppear(_ animated: Bool)
    {

    }
    
    func render()
    {
        var current_y:CGFloat = 80
        
        for view_comp in self.map_view
        {
            view_comp.y = current_y
            view_comp.render()
            
            current_y += view_comp.getContentSize() + 10
        }
    }
    

}
