
//
//  ViewController.swift
//  Project4
//
//  Created by Saurabh Agarwal on 26/09/22.
//

import UIKit
import WebKit

//for classes the first Class after the : is the class it extends from and the subsequent classes are those whose protocols the current class conforms to, i.e, it takes care of the methods in those class, this helps in delegation

class ViewController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!
    
    override func loadView() {
         webView = WKWebView()
        webView.navigationDelegate = self
        //this above line is type of programming pattern and is called "delegation", a delegate is one thing acting in place of another
        //this above means that whenever any webpage navigation happens in our app it should notify the current view controller
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://www.hackingwithswift.com")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }


}

