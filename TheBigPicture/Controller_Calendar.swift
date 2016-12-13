//
//  ViewController.swift
//  TheBigPicture
//
//  Created by RadioactiveTEA on 2016. 11. 1..
//  Copyright © 2016년 RadioactiveTEA. All rights reserved.
//

import UIKit
import JTAppleCalendar
import Foundation

class Controller_Calendar: UIViewController,JTAppleCalendarViewDataSource, JTAppleCalendarViewDelegate,UITableViewDataSource,UITableViewDelegate
{
    @IBOutlet var calendarView: JTAppleCalendarView!
    @IBOutlet weak var label_month: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let formatter = DateFormatter()
    
    var dummy: [String]?
    
    var map_model_node_by_date:[Date:Array<Model_Node>]
    
    required init?(coder aDecoder: NSCoder)
    {
        self.map_model_node_by_date = [:]
        
        super.init(coder: aDecoder)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .lightContent
    }
    
    // Function to handle the text color of the calendar
    func handleCellTextColor(view: JTAppleDayCellView?, cellState: CellState) {
        
        guard let myCustomCell = view as? CellView  else {
            return
        }
        
        if cellState.isSelected {
            myCustomCell.dayLabel.backgroundColor = UIColor(red:91/255, green:118/255, blue:136/255, alpha: 1)
            if(myCustomCell.dayLabel.textColor != UIColor.red )
            {
                myCustomCell.dayLabel.textColor = UIColor.white
            }
        } else {
            myCustomCell.dayLabel.backgroundColor = UIColor.white
            if cellState.dateBelongsTo == .thisMonth {
                
                if(myCustomCell.dayLabel.textColor != UIColor.red )
                {
                    myCustomCell.dayLabel.textColor = UIColor.black
                }
                
            } else {
                
                if(myCustomCell.dayLabel.textColor != UIColor.red )
                {
                    myCustomCell.dayLabel.textColor = UIColor.gray
                }

            }
        }
    }

    
    
    override func viewDidLoad()
    {
        self.view.backgroundColor = UIColor(white:0.9, alpha: 1)
        
        calendarView.dataSource = self
        calendarView.delegate = self
        calendarView.registerCellViewXib(file: "CellView")
        
        self.calendarView.frame.size.width = self.view.frame.width
        self.label_month.frame.size.width = self.view.frame.width
        
        self.setupViewsOfCalendar(from:self.calendarView.visibleDates())
        
        self.tableView.frame.size.width = self.view.frame.width
        tableView.dataSource = self
        tableView.delegate = self
        
        for node in s_node_container.map_node
        {
            for comp in node.value.components
            {
                if let comp_date = comp as? Model_Component_Date
                {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy MM dd"
                    
                    let fullNameArr = comp_date.date.components(separatedBy: " ")
                    
                    let result1   = fullNameArr[0]
                    
                    let split2 = result1.components(separatedBy: "-")
                    
                    let dateStr = split2[0] + " " + split2[1] + " " + split2[2]
                    
                    print(dateStr)
                    
                    let date = formatter.date(from:dateStr)!
                    
                    if(map_model_node_by_date[date] == nil)
                    {
                        //self.map_model_node_by_date.updateValue( [node.value], forKey: date!)
                        
                        self.map_model_node_by_date[date] = [node.value]
                    }
                    else
                    {
                        self.map_model_node_by_date[date]!.append(node.value)
                    }
                }
            }
        }
    }
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        
        let startDate = formatter.date(from: "2016 12 01")! // You can use date generated from a formatter
        let endDate = formatter.date(from: "2026 10 01")!                               // You can also use dates created from this function
        let parameters = ConfigurationParameters(startDate: startDate,
                                                 endDate: endDate,
                                                 numberOfRows: 6, // Only 1, 2, 3, & 6 are allowed
                                                calendar: Calendar.current,
                                                generateInDates: .forAllMonths,
                                                generateOutDates: .tillEndOfGrid,
                                                firstDayOfWeek: .sunday)
        
        return parameters
    }
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplayCell cell: JTAppleDayCellView, date: Date, cellState: CellState)
    {
        
        let myCustomCell = cell as! CellView
        myCustomCell.dayLabel.text = cellState.text
        
        if Calendar.current.isDateInToday(date) {
            print(date)
            myCustomCell.dayLabel.textColor = UIColor.red
        }
        else{
            handleCellTextColor(view: cell, cellState: cellState)
        }
       
    }
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleDayCellView?, cellState: CellState) {
        handleCellTextColor(view: cell, cellState: cellState)
    }
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleDayCellView?, cellState: CellState) {
        handleCellTextColor(view: cell, cellState: cellState)
        
        print(formatter.string(from: date))
        print(date)
        
        var taskDummy = map_model_node_by_date[date]
        print("fefefe")
        print(taskDummy)
        
//        if(taskDummy != nil)
//        {
//            for a in taskDummy!
//            {
//                for comp in a
//                {
//                    if let comp_name = comp as? Model_Component_Name
//                    {
//                        dummy = comp_name.name
//                    }
//                }
//            }
//        }
        
        dummy = self.taskDummyData(date: date)
        print(dummy)
        tableView.reloadData()
    }
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo)
    {
        self.setupViewsOfCalendar(from:visibleDates)
    }
    
    func setupViewsOfCalendar(from visibleDates: DateSegmentInfo)
    {
        guard let startDate = visibleDates.monthDates.first else
        {
            return
        }
        
        let month = Calendar.current.dateComponents([.month], from: startDate).month!
        let monthName = DateFormatter().monthSymbols[(month-1) % 12]
        let year = Calendar.current.component(.year, from: startDate)
        
        label_month.text = monthName + " " + String(year)
    }
/*
    func scrollDidEndDecelerating(for calendar: JTAppleCalendarView)
    {
        guard let startDate = calendar.visibleDates().monthDates.first else
        {
            return
        }
        
        let month = Calendar.current.dateComponents([.month], from: startDate).month!
        let monthName = DateFormatter().monthSymbols[(month-1) % 12]
        let year = Calendar.current.component(.year, from: startDate)
        
        label_month.text = monthName + " " + String(year)
    }
 */
    
    
    
    func taskDummyData(date:Date)->[String]
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"

        
        let task = [ formatter.date(from: "2016 12 09")! : ["swift","tableview","example"],
                     formatter.date(from: "2016 12 10")! : ["swift","tableview","example"],
                     formatter.date(from: "2016 12 11")! : ["swift","tableview","example"],
                     formatter.date(from: "2016 12 13")! : ["융합소프트웨어 발표","DDP_RENTAL",""],
        
        ]
        print(formatter.date(from: "2016 12 09"))
        print(task[formatter.date(from: "2016 12 09")!])
        if(task[date] == nil)
        {
            return []
        }
        return task[date]!
    }
    
    // table row 갯수 (menu 배열의 갯수만큼)
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        
        print (dummy)
        if dummy == nil
        {
            return 0
        }
        return (dummy?.count)!
    }
    
    // 각 row 마다 데이터 세팅.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        // 첫 번째 인자로 등록한 identifier, cell은 as 키워드로 앞서 만든 custom cell class화 해준다.
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath as IndexPath) as! CustomCell
        
        // 위 작업을 마치면 커스텀 클래스의 outlet을 사용할 수 있다.
        
        cell.taskLabel.text = dummy?[indexPath.row]
        
        print(dummy)
        
        return cell
    }
    
    
}
