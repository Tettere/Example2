//
//  CollectionView.swift
//  Example2
//
//  Created by 内藤大輝 on 2020/01/10.
//  Copyright © 2020 Hiroki Naito. All rights reserved.
//

import UIKit
import RealmSwift

class CollectionView: UIView,UICollectionViewDataSource,UICollectionViewDelegate{
    
    
    private let itemsPerRow: CGFloat = 2
    private let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    
    var date:String = ""
    var name:String = ""
    var filter:String = ""
    
    var Month:String = ""
    
    var collectionView:UICollectionView!
    
    var Array:Results<Data>!
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    override init(frame: CGRect) {
        super.init(frame: frame)
        /*
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.register(UINib(nibName: "CustomCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
   */
 }*/
    
    init(frame:CGRect,yearmonth:String) {
        super.init(frame:frame)
        let realm = try! Realm()
        do{
        Array = realm.objects(Data.self).filter("OK  CONTAINS '\(yearmonth)'")
        }catch{
        }
        collectionView?.delegate = self;
        collectionView?.dataSource = self;
        collectionView?.register(UINib(nibName: "CustomCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        collectionView?.reloadData()
    }
    
    /*
    init(frame: CGRect,yearmonth:String) {
        super.init(frame: frame)
        let realm = try! Realm()
         do{
            Array = realm.objects(Data.self).filter("OK  == '\(yearmonth)'")
            
        }catch{
        }
        print(Array!)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.register(UINib(nibName: "CustomCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
    }
    */
    
    func setup(yearmonth:String){
        
        let realm = try! Realm()
        do{
        Array = realm.objects(Data.self).filter("OK  CONTAINS '\(yearmonth)'")
        }catch{
        }
        /*
        print(Array!)
        print(yearmonth)*/
        collectionView?.reloadData()
    }
    
    
    
    //メンバーの名前受け取り
    /*
    func sendText1(text1: String, text2: String, text3:String) {
             
             date = text1
             name = text2
             filter = text3
             
         }
      
      func GetData(){
             
            let names = name
            let dates = date
            let filters = filter
            let data = Data()
        
            data.Date = dates
            data.Title = names
            data.OK = filters
        
            print(data)
             //self.memberArray.append(memberdata)
            
            self.collectionView?.reloadData()
             
             do{
                 let realm = try Realm()
                 try realm.write({ () -> Void in
                 realm.add(data)
             })
             }catch{
             }
             
         }
*/
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(Array.count)
       return Array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CustomCell
        cell.Label1.text = Array[indexPath.row].Date
        cell.Label1.textAlignment = .center
        cell.Label2.text = Array[indexPath.row].Title
        cell.Label2.textAlignment = .center
        cell.backgroundColor = .red
        return cell
    }
    
    //セルのLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = self.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem , height: widthPerItem)
           
    }
    
       
       //セルのLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           
        return sectionInsets
           
    }
       
       //セルの行間の設定
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
           
        return 10.0
           
    }
   /*
       //cellが押された時の処理
       func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           
        let next2VC = storyboard?.instantiateViewController(withIdentifier: "collectphotosegue") as! CollectPhotoViewController
        next2VC.name = collectionlist[indexPath.row].Title
        next2VC.number = indexPath.row
        next2VC.count = collectionlist[indexPath.row].CutCount
        navigationController?.pushViewController(next2VC, animated: true)
           
    }
   */


}
