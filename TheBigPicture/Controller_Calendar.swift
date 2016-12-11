//
//  ViewController.swift
//  TheBigPicture
//
//  Created by RadioactiveTEA on 2016. 11. 1..
//  Copyright © 2016년 RadioactiveTEA. All rights reserved.
//

import UIKit
import JTAppleCalendar

class Controller_Calendar: UIViewController,JTAppleCalendarViewDataSource, JTAppleCalendarViewDelegate
{
    @IBOutlet var calendarView: JTAppleCalendarView!
    @IBOutlet weak var label_month: UILabel!
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .lightContent
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
    }
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        
        let startDate = formatter.date(from: "2016 02 01")! // You can use date generated from a formatter
        let endDate = Date()                                // You can also use dates created from this function
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
        
        if cellState.dateBelongsTo == .thisMonth
        {
            myCustomCell.dayLabel.textColor = UIColor.black
        }
            /*
        else if cellState.dateBelongsTo ==
        {
            myCustomCell.dayLabel.textColor = UIColor.red
        }
 */
        else
        {
            myCustomCell.dayLabel.textColor = UIColor.gray
        }
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
}

