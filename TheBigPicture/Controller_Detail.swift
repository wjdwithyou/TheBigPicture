//
//  Controller_Detail.swift
//  TheBigPicture
//
//  Created by J.Style on 2016. 12. 8..
//  Copyright © 2016년 J.Style. All rights reserved.
//

import UIKit

class Controller_Detail: UIViewController {
    @IBOutlet weak var DetailTitle: UINavigationItem!
    
    var receivedText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.DetailTitle.title = receivedText
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
