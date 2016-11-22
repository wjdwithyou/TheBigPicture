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
        let btn = UIButton()
        let width:CGFloat = self.view.frame.width
        let height:CGFloat = self.view.frame.height
    
/*
        btn.frame = CGRect(x: width/2-btn.frame.size.width/2, y: height/2 - btn.frame.size.height/2, width: btn.frame.size.width, height: btn.frame.size.height)
  */
        
        btn.frame.origin.x = 10
        btn.frame.origin.y = 10
        btn.frame.size.width = 100
        btn.frame.size.height = 50
        btn.layer.cornerRadius = 10
        
        btn.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
        
        btn.setTitle("Click", for: UIControlState.normal)
        self.view.addSubview(btn)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

