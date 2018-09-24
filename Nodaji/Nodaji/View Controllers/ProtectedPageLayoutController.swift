	//
//  ProtectedPageLayoutController.swift
//  Nodaji
//
//  Created by Jung Eek Bang on 9/23/18.
//  Copyright © 2018 Nodaji. All rights reserved.
//
//  Description: This file is about the interphase and connection controll of the login and registration page. When the user is not login, it disables the user to continue.
    

import UIKit

class ProtectedPageLayoutController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewDidAppear(_ animated: Bool) {
        self.performSegueWithIdentifier("loginPage", sender: self);
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
