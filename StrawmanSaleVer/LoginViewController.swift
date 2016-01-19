//
//  LoginViewController.swift
//  StrawmanSaleVer
//
//  Created by wusuchen on 2016/1/18.
//  Copyright © 2016年 alphacamp. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class LoginViewController: UIViewController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate {
    
    var LoginViewController : PFLogInViewController! = PFLogInViewController()
    var signUpViewCOntroller: PFSignUpViewController! = PFSignUpViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.presentViewController(LoginViewController, animated:true, completion: nil)
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
        if (PFUser.currentUser() == nil ){
            self.LoginViewController.fields =
                PFLogInFields.UsernameAndPassword
            PFLogInFields.LogInButton
            PFLogInFields.SignUpButton
            PFLogInFields.PasswordForgotten
            PFLogInFields.DismissButton
            
            let logInLogoTitle = UILabel()
            
            logInLogoTitle.text = "Strawman"
            
            self.LoginViewController.logInView?.logo = logInLogoTitle
            
            self.LoginViewController.delegate = self
            
            let signUpLogoTitle = UILabel()
            
            signUpLogoTitle.text = "Strawamn"
            
            self.signUpViewCOntroller.signUpView?.logo = signUpLogoTitle
            
            self.signUpViewCOntroller.delegate = self
            
            self.LoginViewController.signUpController = self.signUpViewCOntroller
        }
        
    }
        
        
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
        
        // Dispose of any resources that can be recreated.
    }
    // MARK : Parse Login
    
    
    func logInViewController(logInController: PFLogInViewController, shouldBeginLogInWithUsername username: String, password: String) -> Bool {
        if (!username.isEmpty || !password.isEmpty ){
            return true
        }else{
            return false
        }
        
    }
    
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func logInViewController(logInController: PFLogInViewController, didFailToLogInWithError error: NSError?) {
        print("Failed to login")
    }



    // MARK : Parse SignUp
    
    
    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    func signUpViewController(signUpController: PFSignUpViewController, didFailToSignUpWithError error: NSError?) {
        print("failed to sign up")
    }
    func signUpViewControllerDidCancelSignUp(signUpController: PFSignUpViewController) {
        print("user dismiss sign up")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //Mark :Action
    
    @IBAction func simpleAction(sender: AnyObject) {
        self.presentViewController(self.LoginViewController, animated: true, completion: nil )
    }
    
    
    @IBAction func customAction(sender: AnyObject) {
        self.performSegueWithIdentifier("custom", sender: self)
    }
    
    
    @IBAction func logoutAction(sender: AnyObject) {
        PFUser.logOut()
    }
    
    
    
    
    
    
    
    
    
    
    
    

}
