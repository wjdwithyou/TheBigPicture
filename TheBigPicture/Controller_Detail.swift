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
    
    let textViewWidth: CGFloat = 350
    let textViewHeight: CGFloat = 50    // default
    let textViewInterval: CGFloat = 25
    let textViewOriginX: CGFloat = 25
    let textViewOriginY: CGFloat = 85
    
    var receivedModel: Model_Node?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let viewTapGestureRec = UITapGestureRecognizer(target: self, action: #selector(self.handleViewTap(recognizer:)))
        viewTapGestureRec.cancelsTouchesInView = false
        self.view.addGestureRecognizer(viewTapGestureRec)

        self.render()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .lightContent
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func render()
    {
        var textViewY: CGFloat = self.textViewOriginY
        
        for comp in (receivedModel?.components)!
        {
            if let comp_name = comp as? Model_Component_Name
            {
                self.DetailTitle.title = comp_name.name
            }
            
            if let comp_text = comp as? Model_Component_Text
            {
                let textView = UITextView()
                
                textView.frame.size.width = self.textViewWidth
                textView.frame.size.height = self.textViewHeight
                textView.layer.cornerRadius = 10
                
                textView.frame.origin.x = self.textViewOriginX
                textView.frame.origin.y = textViewY
                
                textView.backgroundColor = UIColor.white
                textView.text = comp_text.text
                
                resizeTextView(sub: textView)
                
                textViewY += (textView.frame.size.height + self.textViewInterval)
                
                self.view.addSubview(textView)
            }
        }
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
