//
//  DetailViewController.swift
//  Project7
//
//  Created by Nathan Segura on 3/11/22.
//  Copyright © 2022 Nathan Segura. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    var webView: WKWebView!
    var detailItem: Petition?
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let detailItem = detailItem else { return }
        
        title = detailItem.title
        navigationItem.largeTitleDisplayMode = .never
        
        let html = """
        <html>
        <head>
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <style> body {
                font-size: 150%;
                font-family: Helvetica;
            }
            </style>
        </head>
        <body>
            \(detailItem.body)
        </body>
        </html>
        """
        
        webView.loadHTMLString(html, baseURL: nil)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
