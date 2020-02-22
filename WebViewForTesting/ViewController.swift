//
//  ViewController.swift
//  WebViewForTesting
//
//  Created by Naruth Kongurai on 2/22/20.
//  Copyright © 2020 Naruth Kongurai. All rights reserved.

//  This webview application sends a POST request to the specified
//  URL with an access token field as a body parameter. This app is
//  developed solely for the purpose of helping testers ensure the
//  webview works accordingly.

//  For development purposes and not for production use.
//

import UIKit
import WebKit

class ViewController: UIViewController, UISearchBarDelegate {
    
    let ENTRY_POINT_URL = "https://p2dev.trueyou.co.th"
    let PLACEHOLDER_URL = "https://p2dev.trueyou.co.th/happinessupgrade/webview?lang=en"
    
    @IBOutlet weak var searchBar: UISearchBar!

    @IBOutlet weak var accessTokenInput: UITextField!

    @IBOutlet weak var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self;
        
        searchBar.placeholder = PLACEHOLDER_URL
        searchBar.text = ENTRY_POINT_URL

        let url = URL(string: ENTRY_POINT_URL)
        let request = URLRequest(url: url!)
        
        webView.load(request)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        searchBar.resignFirstResponder()

        let url = URL(string: "https://\(self.searchBar.text!)")

        var request = URLRequest(url: url!)
        
        // Setting necessary parameters to make POST requests work!
        // Reference: https://developer.apple.com/documentation/webkit/wkwebview
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        let bodyParameters: [String: Any] = [
            "access_token": accessTokenInput.text != nil ? accessTokenInput.text! : ""
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: bodyParameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }

        webView.load(request)
    }
}

