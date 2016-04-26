//
//  EmployeeViewController.swift
//  ExpoEasy
//
//  Created by thanhbinhtra on 7.4.2016.
//  Copyright © 2016 thanhbinhtran. All rights reserved.
//

import UIKit
import CoreData

class EmployeeViewController: UIViewController {
    
    // MARK: Properties
    var beacon: Beacon?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var companyButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let beacon = beacon {
            nameLabel.text?.appendContentsOf((beacon.employee?.name)!)
            positionLabel.text?.appendContentsOf((beacon.employee?.position)!)
            companyButton.setTitle("Company: " + (beacon.company?.name)!, forState: .Normal)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
        if segue.identifier == "ShowCompanyDescription" {
            let companyViewController = segue.destinationViewController as! CompanyViewController
            let company = beacon?.company
            companyViewController.company = company
        }
        
     }
     

    
}

