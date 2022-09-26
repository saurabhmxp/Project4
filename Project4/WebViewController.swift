
//
//  ViewController.swift
//  Project4
//
//  Created by Saurabh Agarwal on 26/09/22.
//

import UIKit
import WebKit

//for classes the first Class after the : is the class it extends from and the subsequent classes are those whose protocols the current class conforms to, i.e, it takes care of the methods in those class, this helps in delegation

class WebViewController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!
    var progressView: UIProgressView!
    var websites: [[String:String]]!
    var currentWebsite: Int!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        //this above line is type of programming pattern and is called "delegation", a delegate is one thing acting in place of another
        //this above means that whenever any webpage navigation happens in our app it should notify the current view controller
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        let goBack = UIBarButtonItem(title: "Back", style: .plain, target: webView, action: #selector(webView.goBack))
        let goForward = UIBarButtonItem(title: "Forward", style: .plain, target: webView, action: #selector(webView.goForward))
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        
        toolbarItems = [progressButton, spacer, goBack, goForward, refresh]
        navigationController?.isToolbarHidden = false
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
        let url = URL(string: "https://"+websites[currentWebsite]["website"]!)!
        print(url)
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    @objc func openTapped(){
        let ac = UIAlertController(title: "Open Page", message: nil, preferredStyle: .actionSheet)
        for (website) in websites {
            ac.addAction(UIAlertAction(title: website["website"], style: .default, handler: openPage))
        }
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }
    
    func openPage(action:UIAlertAction){
        guard let actionTitle = action.title else {return}
        
        guard let url = URL(string: "https://"+actionTitle) else{return }
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress"{
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        
        if let host = url?.host{
            for (website) in websites {
                if host.contains(website["website"]!){
                    decisionHandler(.allow)
                    return
                }else{
                    
                }
            }
        }
        
        let urlString = url?.absoluteString ?? "Unknown"
        
        if urlString != "about:blank" {
            // to test this alert: go to hackingwithswift.com, then under the book "swift in sixty seconds" click "buy download"
            let ac = UIAlertController(title: "Unauthorized", message: "Website \"\(urlString)\" is not part of authorized websites", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(ac, animated: true)
        }
        
        decisionHandler(.cancel)
    }

}

