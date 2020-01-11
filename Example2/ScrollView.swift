//
//  ScrollView.swift
//  Example2
//
//  Created by 内藤大輝 on 2020/01/10.
//  Copyright © 2020 Hiroki Naito. All rights reserved.
//

import UIKit

class ScrollView: UIView,UIScrollViewDelegate{

    var currentYear:Int = 0
    var currentMonth:Int = 0
    var currentDay:Int = 0
    
    var scrollView:UIScrollView!
    var prevMonthView:CollectionView!
    var currentMonthView:CollectionView!
    var nextMonthView:CollectionView!
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame:CGRect){
        
        super.init(frame: frame)
        let dateFormatter:DateFormatter = DateFormatter();
        dateFormatter.dateFormat = "yyyy/MM/dd";
        let dateString:String = dateFormatter.string(from: NSDate() as Date);
        let dates:[String] = dateString.components(separatedBy: "/")
        currentYear  = Int(dates[0])!
        currentMonth = Int(dates[1])!
       
        scrollView = UIScrollView(frame: self.bounds)
        scrollView.backgroundColor = UIColor.clear
        scrollView.contentSize   = CGSize(width: scrollView.frame.size.width * 3.0,height: scrollView.frame.size.height);
        scrollView.contentOffset = CGPoint(x: scrollView.frame.size.width , y: 0.0);
        scrollView.delegate = self;
        scrollView.isPagingEnabled = true;
        scrollView.showsHorizontalScrollIndicator = false;
        scrollView.showsVerticalScrollIndicator = false;
        scrollView.scrollsToTop = false;
        
        self.addSubview(scrollView)
        
        currentMonthView = CollectionView(frame: CGRect(x: frame.size.width, y: 0, width: frame.size.width,height: frame.size.height),yearmonth:"\(currentYear)年\(currentMonth)月")
       //翌月
        let ret1 = self.getNextYearAndMonth()
        nextMonthView =  CollectionView(frame: CGRect(x: frame.size.width * 2.0, y: 0, width: frame.size.width,height: frame.size.height),yearmonth: "\(ret1.year)年\(ret1.month)月" )
       
       //前月
        let ret2 = self.getPrevYearAndMonth()
        prevMonthView = CollectionView(frame: CGRect(x: 0.0, y: 0, width: frame.size.width,height: frame.size.height),yearmonth: "\(ret2.year)年\(ret2.month)月")
       
       scrollView.addSubview(currentMonthView);
       scrollView.addSubview(nextMonthView);
       scrollView.addSubview(prevMonthView);

    }
    
    func scrollViewDidScroll(_ scrollView:UIScrollView){
        let pos:CGFloat  = scrollView.contentOffset.x / scrollView.bounds.size.width
        let deff:CGFloat = pos - 1.0
        if abs(deff) >= 1.0 {
            if (deff > 0) {
                self.showNextView()
            } else {
                self.showPrevView()
            }
        }
    }
    
    //左スワイプ、次のVIew生成、入れ替え、年月更新
    func showNextView (){
        
        currentMonth = currentMonth + 1
        
        if( currentMonth > 12 ){
            currentMonth = 1;
            currentYear = currentYear + 1
        }
        
        let tmp1View:CollectionView = currentMonthView
        currentMonthView = nextMonthView
        nextMonthView    = prevMonthView
        prevMonthView    = tmp1View

        let ret = self.getNextYearAndMonth()
        nextMonthView.setup(yearmonth: "\(ret.year)年\(ret.month)月")
        //position調整
        self.resetContentOffSet()
    }
    //右スワイプ、次のVIew生成、入れ替え、年月更新
    func showPrevView () {
       
        currentMonth = currentMonth - 1
        
        if( currentMonth == 0 ){
            currentMonth = 12
            currentYear = currentYear - 1
        }

        let tmp2View:CollectionView = currentMonthView
        currentMonthView = prevMonthView
        prevMonthView    = nextMonthView
        nextMonthView    = tmp2View
        
        let ret = self.getPrevYearAndMonth()
        prevMonthView.setup(yearmonth:"\(ret.year)年\(ret.month)月")
        //position調整
        self.resetContentOffSet()
    }
    
    //位置調整
    func resetContentOffSet () {
        //position調整
        prevMonthView.frame = CGRect(x: 0, y: 0, width: frame.size.width,height: frame.size.height)
        currentMonthView.frame = CGRect(x: frame.size.width, y: 0, width: frame.size.width,height: frame.size.height)
        nextMonthView.frame = CGRect(x: frame.size.width * 2.0, y: 0, width: frame.size.width,height: frame.size.height)

        let scrollViewDelegate:UIScrollViewDelegate = scrollView.delegate!
        scrollView.delegate = nil
        //delegateを呼びたくないので
        scrollView.contentOffset = CGPoint(x: frame.size.width , y: 0.0);
        scrollView.delegate = scrollViewDelegate

    }

    
    //左スワイプ時
    func getNextYearAndMonth () -> (year:Int,month:Int){
        
        var next_year:Int = currentYear
        var next_month:Int = currentMonth + 1
        
        if (next_month > 12) {
            next_month = 1
            next_year = next_year + 1
        }
        
        return (next_year,next_month)
        
    }
    //右スワイプ時
    func getPrevYearAndMonth () -> (year:Int,month:Int){
        
        var prev_year:Int = currentYear
        var prev_month:Int = currentMonth - 1
        if (prev_month == 0) {
            prev_month = 12
            prev_year = prev_year - 1
        }
        return (prev_year,prev_month)
    }
}
