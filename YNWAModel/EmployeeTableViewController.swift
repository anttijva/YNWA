//
//  EmployeeTableViewController.swift
//  YNWAModel
//
//  Created by iosdev on 21.4.2016.
//  Copyright © 2016 thanhbinhtran. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation

class EmployeeTableViewController: UITableViewController, NSFetchedResultsControllerDelegate, CLLocationManagerDelegate {
    
    // MARK: Properties
    let locationManager = CLLocationManager()
    let region = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")!, identifier: "ExpoEasy")
    var beaconsDetected = [CLBeacon]()
    var beacons = [Beacon]()
    var beaconsToDisplay = [Beacon]()
 

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        
        // Ask to gain access to Location Service
        if CLLocationManager.authorizationStatus() != CLAuthorizationStatus.AuthorizedWhenInUse {
            locationManager.requestWhenInUseAuthorization()
        }
        
        // Start looking for beacons
        locationManager.startRangingBeaconsInRegion(region)
        
    }
    
    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        
        // filter out the unknown beacons
        self.beaconsToDisplay.removeAll()
        let knownBeacons = beacons.filter{ $0.proximity != CLProximity.Unknown }
        self.beaconsDetected = knownBeacons
        print(beaconsDetected)
        
        for bd in beaconsDetected {
            for b in self.beacons {
                if String(bd.major) == b.major && String(bd.minor) == b.minor{
                    
                    let str = bd.accuracy.description
                    let index1 = str.startIndex.advancedBy(5)
                    let accuracyDisplay = str.substringToIndex(index1)
                    
                    b.accuracy = accuracyDisplay + " m"
                    
                    self.beaconsToDisplay.append(b)
                    
                }
            }
        }
        
        tableView.reloadData()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(animated: Bool) {
        
        // set up fetchedResultsController for the tableview
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let fetchRequest = NSFetchRequest(entityName: "Beacon")
        
        do {
            let fetchedEntities = try appDelegate.managedObjectContext.executeFetchRequest(fetchRequest) as! [Beacon]
            beacons = fetchedEntities
            
        } catch {
            // Do something in response to error condition
        }
        
        /*fetchedResultsController = NSFetchedResultsController(fetchRequest:  fetchRequest, managedObjectContext: appDelegate.managedObjectContext, sectionNameKeyPath: nil , cacheName: nil)
        fetchedResultsController!.delegate = self */

    }
    
    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return beaconsToDisplay.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "EmployeeTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! EmployeeTableViewCell

        // Configure the cell...
        
        let beacon = beaconsToDisplay[indexPath.row]
        
        cell.nameLabel.text = beacon.employee?.name
        cell.companyNameLabel.text = beacon.company?.name
        cell.employeePositionLabel.text = beacon.employee?.position
        cell.beaconAccuracyLabel.text = beacon.accuracy
        load_image((beacon.employee?.profileURL)!, imageView: cell.profileImageView)
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

 
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "ShowPersonalInformation" {
            let personalInformationViewController = segue.destinationViewController as! EmployeeViewController
            if let selectedCell = sender as? EmployeeTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedCell)
                let selectedBeacon = beaconsToDisplay[indexPath!.row]
                personalInformationViewController.beacon = selectedBeacon
                
            }
        }
    }
    
    
    func load_image(urlString:String, imageView: UIImageView){
        print("DOWNLOAD IMAGES" )
        let imgURL: NSURL = NSURL(string: urlString)!
        let request: NSURLRequest = NSURLRequest(URL: imgURL)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request){
            (data, response, error) -> Void in
            
            print(error)
            print(response)
            print(data)
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
