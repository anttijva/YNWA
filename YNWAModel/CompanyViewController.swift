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
    @IBOutlet weak var companyLogoImageView: UIImageView!
    @IBOutlet weak var openWebsiteButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set background color to back
        self.view.backgroundColor = UIColor.blackColor()
        
        if let company = company {
            descriptionTextView.text = company.companyDescription
            
            // Load image for company logo
            load_image(company.logoURL!, imageView: self.companyLogoImageView)
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
        
        if segue.identifier == "ShowCompanyWebsite" {
            let companyWebViewController = segue.destinationViewController as! CompanyWebViewController
            let company = self.company
            companyWebViewController.company = company
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
