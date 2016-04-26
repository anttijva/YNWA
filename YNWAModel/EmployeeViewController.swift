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
    @IBOutlet weak var companyImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let beacon = beacon {
            nameLabel.text?.appendContentsOf((beacon.employee?.name)!)
            positionLabel.text?.appendContentsOf((beacon.employee?.position)!)
            companyButton.setTitle("Company: " + (beacon.company?.name)!, forState: .Normal)
            
            // Load images for profile and companylogo
            print("LOADING COMPANY LOGO")
            load_image((beacon.company?.logoURL)!, imageView: self.companyImageView)
            print("LOAD PERSON PROFILE PIC")
            load_image((beacon.employee?.profileURL)!, imageView: self.profileImageView)
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
    
    // Loading image function
    func load_image(urlString:String, imageView: UIImageView){
        print("DOWNLOAD IMAGE" )
        let imgURL: NSURL = NSURL(string: urlString)!
        let request: NSURLRequest = NSURLRequest(URL: imgURL)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request){
            (data, response, error) -> Void in
            
            
            print(response)
            
            if (error == nil && data != nil) {
                
                func display_image() {
                    print("DISPLAY IMAGE")
                    imageView.image = UIImage(data: data!)
                }
                
                dispatch_async(dispatch_get_main_queue(), display_image)
            }
        }
        task.resume()
        
    }


    
}

