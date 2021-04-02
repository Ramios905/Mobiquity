//
//  HelpViewController.swift
//  MobiquityTest
//
//  Created by Ram on 01/04/21.
//

import UIKit
import WebKit

class HelpViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = Bundle.main.url(forResource: "Help", withExtension:"html")
        let request = NSURLRequest(url: url!)
        DispatchQueue.main.async {
            self.webView.load(request as URLRequest)
        }
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
