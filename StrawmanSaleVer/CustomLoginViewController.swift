//
//  CustomLoginViewController.swift
//  StrawmanSaleVer
//
//  Created by wusuchen on 2016/1/19.
//  Copyright © 2016年 alphacamp. All rights reserved.
//

import UIKit
import Parse

class CustomLoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    
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
    
    // MARK: Action
    
    @IBAction func loginAction(sender: AnyObject) {
        
        var username = self.usernameField.text
        var password = self.passwordField.text
        
        
        if (username?.utf16.count < 4 || password?.utf16.count < 5){
            var alert = UIAlertView(title: "Invalid", message: "Username must be greater then 4 and Password must be greater then 5.", delegate: self, cancelButtonTitle: "ok")
            alert.show()
        }else{
            self.actInt.startAnimating()
            
            PFUser.logInWithUsernameInBackground(username!, password: password!) { (user, error) -> Void in
                
                self.actInt.stopAnimating()
                
                if ((user) != nil) {
                    
                    var alert = UIAlertView(title: "Success", message: "Logged In", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                    
                }else{
                    var alert = UIAlertView(title: "Error", message: "\(error)", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                    
                }
                
            }
            
            
            
        }
        
    }
    
        
        
    @IBAction func signupAction(sender: AnyObject) {
        
        self.performSegueWithIdentifier("signup", sender: self)
        
        
    }
}
