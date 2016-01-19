//
//  CustomSignUpViewController.swift
//  StrawmanSaleVer
//
//  Created by wusuchen on 2016/1/19.
//  Copyright © 2016年 alphacamp. All rights reserved.
//

import UIKit
import Parse
import CoreLocation
import MapKit

class CustomSignUpViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var userNameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var addressField: UITextField!
    
    @IBOutlet weak var mobileField: UITextField!
    
    let geoCoder = CLGeocoder()

    
    
    var actInt: UIActivityIndicatorView = UIActivityIndicatorView (frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.actInt.center = self.view.center
        
        self.actInt.hidesWhenStopped = true
        
        self.actInt.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        
        view.addSubview(self.actInt)
        // Do any additional setup after loading the view.
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
    func addressToGeopoint(addresstext:String){
        
        self.geoCoder.geocodeAddressString(addresstext) { (places:[CLPlacemark]?, err:NSError?) -> Void in
            if places?.count > 0 {
                let placeMark = places?.first
              
//                self.sign
//                return placeMark!.location?.coordinate
                self.doSignUp((placeMark!.location?.coordinate)!)
            }
            
        }
        
    }

    @IBAction func signUpAction(sender: AnyObject) {
        let addresstext = self.addressField.text
        addressToGeopoint(addresstext!)
        
    }
    
    func doSignUp(coord:CLLocationCoordinate2D) {
    
        let geoPoint = PFGeoPoint(latitude: coord.latitude, longitude: coord.longitude)
        let username = self.userNameField.text
        let password = self.passwordField.text
        let email = self.emailField.text
        let addresstext = self.addressField.text
        let mobile_num = mobileField.text
        
        
        
        //        func geocodeAddressString(address: String){
        //            let geoCoder = CLGeocoder()
        //            geoCoder.geocodeAddressString(address) { (places: [CLPlacemark]?, error: NSError?) -> Void in
        //                if places?.count > 0{
        //                    let placeMark = places?.first
        //                    let viewCenterLocation = placeMark!.location
        //                }
        //            }
        //        }
        
        
        
        if (username?.utf16.count < 4 || password?.utf16.count < 5){
            
            
            let alert = UIAlertController(title: "Invalid", message: "Username must be greater then 4 and Password must be greater then 5.", preferredStyle: UIAlertControllerStyle.Alert )
            
            let callAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Destructive, handler: { action in })
            
            alert.addAction(callAction)
            
            self.presentViewController(alert, animated: true, completion: nil)
            
            
        }else if (email?.utf16.count < 8 ) {
            
            let alert = UIAlertController(title: "Invalid", message: "填入正確email", preferredStyle: UIAlertControllerStyle.Alert )
            
            let callAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Destructive, handler: { action in })
            
            alert.addAction(callAction)
            
            
            self.presentViewController(alert, animated: true, completion: nil)
            
        }else{
            self.actInt.startAnimating()
            
            let newUser = PFUser()

            newUser.username = username
            newUser.password = password
            newUser.email = email
            newUser["address"] = addresstext
            newUser["mobile_num"] = mobile_num
            newUser["geopoint"] = geoPoint
            
            
            newUser.signUpInBackgroundWithBlock({ (succeed, error) -> Void in
                self.actInt.stopAnimating()
                
                if ((error) != nil ) {
                    
                    let alert = UIAlertController(title: "Invalid", message: "\(error)", preferredStyle: UIAlertControllerStyle.Alert )
                    
                    let callAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Destructive, handler: { action in })
                    
                    alert.addAction(callAction)
                    
                    
                    self.presentViewController(alert, animated: true, completion: nil)
                    
                }else{
                    let alert = UIAlertController(title: "Invalid", message: "\(error)", preferredStyle: UIAlertControllerStyle.Alert )
                    
                    let callAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Destructive, handler: { action in })
                    
                    alert.addAction(callAction)
                    
                    self.presentViewController(alert, animated: true, completion: nil)
                    
                    
                    
                }
            })

    
    }
        
        
}
        
    
    
}