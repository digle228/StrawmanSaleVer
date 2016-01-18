//
//  CustomSignUpViewController.swift
//  StrawmanSaleVer
//
//  Created by wusuchen on 2016/1/19.
//  Copyright © 2016年 alphacamp. All rights reserved.
//

import UIKit
import Parse
class CustomSignUpViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var userNameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    
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
    @IBAction func signUpAction(sender: AnyObject) {
        
        var username = self.userNameField.text
        var password = self.passwordField.text
        var email = self.emailField.text
        
        if (username?.utf16.count < 4 || password?.utf16.count < 5){
            var alert = UIAlertView(title: "Invalid", message: "Username must be greater then 4 and Password must be greater then 5.", delegate: self, cancelButtonTitle: "ok")
            alert.show()
            
        }else if (email?.utf16.count < 8 ) {
            var alert = UIAlertView(title: "Invalid", message: "填入正確email", delegate: self, cancelButtonTitle: "ok")
            alert.show()
        }else{
            self.actInt.startAnimating()
            
            
            var newUser = PFUser()
            newUser.username = username
            newUser.password = password
            newUser.email = email
            
            newUser.signUpInBackgroundWithBlock({ (succeed, error) -> Void in
                self.actInt.stopAnimating()
                
                if ((error) != nil ) {
                    
                    var alert = UIAlertView(title: "Invalid", message: "\(error)", delegate: self, cancelButtonTitle: "ok")
                    alert.show()
                    
                }else{
                    var alert = UIAlertView(title: "Invalid", message: "\(error)", delegate: self, cancelButtonTitle: "ok")
                    alert.show()
                    
                }
            })
        }
        
        
    }
    
    
}