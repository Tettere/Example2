//
//  inputViewController.swift
//  Example2
//
//  Created by 内藤大輝 on 2020/01/11.
//  Copyright © 2020 Hiroki Naito. All rights reserved.
//

import UIKit
import RealmSwift
/*
protocol GetDataprotocol {
    
    func GetData()
    func sendText1(text1: String,text2: String,text3: String)
   
    
}
*/
class inputViewController: UIViewController,UITextFieldDelegate {
    //日付
    @IBOutlet weak var datefield: UITextField!
    //ファイル名
    @IBOutlet weak var TextField: UITextField!
    
    //検索用
    var a:String = ""
    //種類用picker
  
    //日付用picker
    var datePicker: UIDatePicker = UIDatePicker()
    
//    var delegate: GetDataprotocol?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
      
        //種類の入力を強制させないようにする
       
        
        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.timeZone = NSTimeZone.local
        datePicker.locale = Locale.current

        
        TextField.delegate = self
        datefield.delegate = self
        
        //cutpickerView.showsSelectionIndicator = true
        //日付Picker
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        toolbar.setItems([spacelItem, doneItem], animated: true)

        // インプットビュー設定(紐づいているUITextfieldへ代入)
        datefield.inputView = datePicker
        datefield.inputAccessoryView = toolbar
        datefield.tag = 1
       
       
        
        
    }
//TextFieldに触れるとtagを取得
 
    
    @objc func done() {
        self.datefield.endEditing(true)
            // 日付のフォーマット
        let formatter = DateFormatter()
            //出力の仕方
        formatter.dateFormat = "MM月dd日"
            //formatter.dateFormat = "YYYYMMdd"
            //(from: datePicker.date))を指定してあげることで
            //datePickerで指定した日付が表示される
            datefield.text = "\(formatter.string(from: datePicker.date))"
        
        formatter.dateFormat = "YYYY年MM月dd日"
        a = "\(formatter.string(from: datePicker.date))"
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }
//完了ボタンを押すと元の画面に戻る（セルが構築される）
    @IBAction func OKButton(_ sender: Any) {
        
        /*
        delegate?.sendText1(text1:datefield.text!, text2:TextField.text!, text3:a)
        delegate?.GetData()
        */
      //  print(n)
        
        let data = Data()
        data.Date = datefield.text!
        data.Title = TextField.text!
        data.OK = a
        print(data)
        do{
            let realm = try Realm()
            try realm.write({ () -> Void in
                realm.add(data)
            })
        }catch{
        }
      //  let abcView:CollectionView!
       // abcView.collectionView.reloadData()
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    
//Cancelボタンを押すと前の画面に戻るだけ。セルは構築されない
    @IBAction func Cancel(_ sender: Any) {
        
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    
//キーボードを閉じる
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        TextField.resignFirstResponder()

        return true
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
           return 1
       }
       
    

}


