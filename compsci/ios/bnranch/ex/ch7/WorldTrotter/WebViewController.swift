//
//  WebViewController.swift
//  WorldTrotter
//
//  Created by Sviatoslav Zimine on 3/30/17.
//  Copyright © 2017 szimine. All rights reserved.
//



import UIKit
import WebKit

class WebViewController : UIViewController, WKUIDelegate{

    var webView: WKWebView!
    
    
    override func loadView(){
        webView = WKWebView() //view is created in the code
        
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string: "https://www.bignerdranch.com")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
    
}

