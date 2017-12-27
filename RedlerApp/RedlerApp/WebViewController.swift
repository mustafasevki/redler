//
//  WebViewController.swift
//  RedlerApp
//
//  Created by Mustafa Sevki Cosar on 25.12.2017.
//  Copyright © 2017 Mustafa Sevki Cosar. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, UIWebViewDelegate{
    
    @IBOutlet weak var webView: WKWebView!
    
    var url:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.load(URLRequest(url: URL(string: url!)!))
        let addQuizItem = UIMenuItem(title: "Add", action: #selector(addItem))
        UIMenuController.shared.menuItems = [addQuizItem]
    }
    
    var selectedItem: String?
    
    @objc func addItem(_ sender: Any?){
        selectedItem = UIPasteboard.general.string
        creatAlert(inputText: selectedItem!)
        print(selectedItem!)
        
    }
   
    
    func creatAlert(inputText:String){
        let alertC = UIAlertController(title: "Bilgi!", message: "Seçtiğiniz Kelimee \(inputText) Quize Ekleniyor.", preferredStyle: UIAlertControllerStyle.alert)
        alertC.addAction(UIAlertAction(title: "Tamam", style: UIAlertActionStyle.default, handler: { (action) in
            alertC.dismiss(animated: true, completion: nil)
        }))
        self.present(alertC, animated: true, completion: nil)
        
    }

    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(addItem(_:)){
            return true
            
        }
        return false
    }
    
    
}
