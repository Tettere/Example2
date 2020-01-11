//
//  ViewController.swift
//  Example2
//
//  Created by 内藤大輝 on 2020/01/10.
//  Copyright © 2020 Hiroki Naito. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var date:String = ""
    var name:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //iPhone11proMaxの大きさに仮想想定
        let Example:ScrollView = ScrollView(frame: CGRect(x: 0, y: 88,width:
            UIScreen.main.bounds.size.width, height: 725));
        self.view.addSubview(Example)
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           
           if(segue.identifier == "inputsegue"){
               
             //  let nextVC = segue.destination as? inputViewController
               // nextVC!.delegate = self as? GetDataprotocol
               
           }else if(segue.identifier == "collectphotosegue"){
           }
       }
    
    @IBAction func Toinput(_ sender: Any) {
          performSegue(withIdentifier: "inputsegue", sender: nil)
    }
    
    
  
    

}

