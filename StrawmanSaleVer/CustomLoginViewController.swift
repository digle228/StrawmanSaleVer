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
        
        let username = self.usernameField.text
        let password = self.passwordField.text
        
        
        if (username?.utf16.count < 4 || password?.utf16.count < 5){
            
            let alert = UIAlertController(title: "Invalid", message: "Username must be greater then 4 and Password must be greater then 5.", preferredStyle: UIAlertControllerStyle.Alert )
            let callAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Destructive, handler: { action in })
            
            alert.addAction(callAction)

            
            self.presentViewController(alert, animated: true, completion: nil)
            /*
            // 1.建立控制器
            // UIAlertControllerStyle.Alert 為警告， UIAlertControllerStyle.ActionSheet 為提示
            var alertController = UIAlertController(title: "提示訊息", message: "這是一個Alert視窗", preferredStyle: UIAlertControllerStyle.Alert)
            
            // 2. 建立按鈕
            // 刪除按鈕建議自行放在第一個，而且是紅色
            var callAction = UIAlertAction(title: "刪除", style: UIAlertActionStyle.Destructive, handler: {
            action in
            println("刪除")
            })
            alertController.addAction(callAction)
            
            // 3. 將控制器顯示在螢幕上
            // 顯⽰畫⾯
            self.presentViewController(alertController, animated: true, completion: nil)
            */
            
        }else{
            self.actInt.startAnimating()
            
            PFUser.logInWithUsernameInBackground(username!, password: password!) { (user, error) -> Void in
                
                self.actInt.stopAnimating()
                
                if ((user) != nil) {
                    
                    let alert = UIAlertController(title: "Success", message: "Logged In", preferredStyle: UIAlertControllerStyle.Alert )
                    
                    let callAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Destructive, handler: { action in })
                    alert.addAction(callAction)

                    
                    self.presentViewController(alert, animated: true, completion: nil)
                    
                    
                    
                }else{
                    
                    let alert = UIAlertController(title: "Error", message: "\(error)", preferredStyle: UIAlertControllerStyle.Alert )
                    
                    let callAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Destructive, handler: { action in })
                    
                    alert.addAction(callAction)

                    self.presentViewController(alert, animated: true, completion: nil)
                    
                    
                }
                
            }
            
            
            
        }
        
    }
    
    
    
    @IBAction func signupAction(sender: AnyObject) {
        
        self.performSegueWithIdentifier("signup", sender: self)
        
        
    }
}
