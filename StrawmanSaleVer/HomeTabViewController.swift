//
//  HomeTabViewController.swift
//  StrawmanSaleVer
//
//  Created by wusuchen on 2016/1/28.
//  Copyright © 2016年 alphacamp. All rights reserved.
//

import UIKit

class HomeTabViewController: UITabBarController {

    override func viewWillAppear(animated: Bool) {
        super.viewDidAppear(animated)
        checkUser()
    }
       
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func checkUser(){
        
        let LoginPage = self.storyboard?.instantiateViewControllerWithIdentifier("CustomLogin")
        if auth_token == "" {
            self.presentViewController(LoginPage!, animated: true, completion: nil)
            print(auth_token)
        }else{
            
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
