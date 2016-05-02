//
//  CompanyWebViewController.swift
//  ExpoEasy
//
//  Created by iosdev on 26.4.2016.
//  Copyright © 2016 thanhbinhtran. All rights reserved.
//

import UIKit

class CompanyWebViewController: UIViewController {

    // MARK: Properties
    var company: Company?
    @IBOutlet weak var companyWebView: UIWebView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Set background color to back
        self.view.backgroundColor = UIColor.blackColor()
        
        loadAddress()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func loadAddress() {
        print("Load Address")
        let requestURL = NSURL(string: (self.company?.companyURL)!)
        print(requestURL)
        let request = NSURLRequest(URL: requestURL!)
        self.companyWebView.loadRequest(request)
    }

}
