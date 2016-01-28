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
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var mobileField: UITextField!
    
    let geoCoder = CLGeocoder()
    
    
    
    var actInt: UIActivityIndicatorView = UIActivityIndicatorView (frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        
        
        self.actInt.center = self.view.center
        
        self.actInt.hidesWhenStopped = true
        
        self.actInt.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        
        view.addSubview(self.actInt)
        
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
    
    @IBAction func signUpAction(sender: AnyObject) {
        let addresstext = self.addressField.text
        
        let username = self.userNameField.text
        let password = self.passwordField.text
        let email = self.emailField.text
        let name = self.nameField.text
        let mobile_num = self.mobileField.text
        
        
        
        if (username?.utf8.count < 4 || password?.utf8.count < 6){
            
            
            let alert = UIAlertController(title: "錯誤", message: "使用者名稱大於4字 密碼填入6個.", preferredStyle: UIAlertControllerStyle.Alert )
            
            let callAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Destructive, handler: { action in })
            
            alert.addAction(callAction)
            
            self.presentViewController(alert, animated: true, completion: nil)
            
            
        }else if (email?.utf8.count < 8 ) {
            
            let alert = UIAlertController(title: "錯誤", message: "填入正確email", preferredStyle: UIAlertControllerStyle.Alert )
            
            let callAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Destructive, handler: { action in })
            
            alert.addAction(callAction)
            
            
            self.presentViewController(alert, animated: true, completion: nil)
            
        }else if ( addresstext?.utf8.count == 0 ) {
            
            let alert = UIAlertController(title: "錯誤", message: "地址錯誤", preferredStyle: UIAlertControllerStyle.Alert )
            
            let callAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Destructive, handler: { action in })
            
            alert.addAction(callAction)
            
            
        }else{
            
            self.actInt.startAnimating()
            //address 地址文字轉經緯度
            self.geoCoder.geocodeAddressString(addresstext!) { (places:[CLPlacemark]?, error:NSError?) -> Void in
                
                if places != nil && places?.count > 0 {
                    let placeMark = places?.first
                    //經緯度轉PFGeoPoint   CLLocation = placemark.location
                    // user["geo"] = PFGeoPoint(location: placemark.location)
                    
                    let geopoint = PFGeoPoint(location: placeMark!.location)
                    let newUser = PFUser()
                    newUser.username = username
                    newUser.password = password
                    newUser.email = email
                    newUser["name"] = name
                    newUser["address"] = addresstext
                    newUser["mobile_num"] = mobile_num
                    newUser["geopoint"] = geopoint
                    
                    
                    newUser.signUpInBackgroundWithBlock({ (succeed, error) -> Void in
                        self.actInt.stopAnimating()
                        
                        if ((error) != nil ) {
                            
                            let alert = UIAlertController(title: "錯誤", message: "\(error)", preferredStyle: UIAlertControllerStyle.Alert )
                            
                            let callAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Destructive, handler: { action in })
                            
                            alert.addAction(callAction)
                            
                            
                            self.presentViewController(alert, animated: true, completion: nil)
                            
                        }else{
                            let alert = UIAlertController(title: "成功", message: "註冊成功", preferredStyle: UIAlertControllerStyle.Alert )
                            
                            let callAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Destructive, handler: { action in })
                            
                            alert.addAction(callAction)
                            
                            self.presentViewController(alert, animated: true, completion: nil)
                            
                            
                            
                        }
                    })
                    
                }
                
                
                
            }
            
            
        }
    }
}