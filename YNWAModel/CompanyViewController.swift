//
//  CompanyViewController.swift
//  ExpoEasy
//
//  Created by iosdev on 25.4.2016.
//  Copyright © 2016 thanhbinhtran. All rights reserved.
//

import UIKit

class CompanyViewController: UIViewController {
    
    // MARK: Properties
    var company: Company?
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        if let company = company {
            descriptionTextView.text = company.conpanyDescription
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
