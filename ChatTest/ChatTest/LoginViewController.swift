//
//  LoginViewController.swift
//  ChatTest
//
//  Created by MC-MG57035 on 4/28/2560 BE.
//  Copyright © 2560 Dol2oMo. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var  addview = RegisterView()
//    var  addview = Any()
    
    var addddd  = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        NotificationCenter.default .addObserver(self, selector: #selector(refresh(notification:)), name: NSNotification.Name(rawValue: "refresh"), object: nil)
        
//        addddd = addview.ViewRegister(regisview: self.view as UIView)
        
       _ = addview.ViewRegister(regisview: self.view as UIView)

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print(";;;;;;;;;;;;;;;;;;;;;;;;;")
    }
    
    func refresh(notification: NSNotification){
        print("iiiiiiiiiiiiiiiiiiiiiii")
        
        
        for v in view.subviews{
            
            if v is RegisterView {
                v.removeFromSuperview()
            }
        }
        
        
//        self.addview.perform(#selector(addview.removeview), with: nil, afterDelay: 0.5)

        
//        _ = addview.removeview()
        

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
