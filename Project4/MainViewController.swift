//
//  MainViewController.swift
//  Project4
//
//  Created by Saurabh Agarwal on 26/09/22.
//

import UIKit

class MainViewController: UITableViewController {
    
    var websites = [
        ["name":"Apple","website":"apple.com"],
        ["name":"HackingWithSwift","website":"hackingwithswift.com"],
        ["name":"MX Player","website":"mxplayer.in"]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Web pages"
        
        navigationController?.navigationBar.prefersLargeTitles = true

        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Website", for: indexPath)
        cell.textLabel?.text = websites[indexPath.row]["name"]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "WebView") as! WebViewController
        vc.websites = websites
        vc.currentWebsite = indexPath.row
        navigationController?.pushViewController(vc, animated: true)
    }

}
