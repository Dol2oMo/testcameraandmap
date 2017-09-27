//
//  ViewController.swift
//  ChatTest
//
//  Created by MC-MG57035 on 4/28/2560 BE.
//  Copyright © 2560 Dol2oMo. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! testTableViewCell
        
        cell.layer.masksToBounds = true
        cell.layer.borderWidth = 1.5
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.shadowOffset = CGSize.zero
        cell.layer.shadowOpacity = 0.2
        
        if indexPath.row == 0 {
            cell.Profilelabel.text = "COROPORATE SERVICED OFFICES"
            cell.ProfileImage.image = UIImage(named: "pi.png")
        }
        else if indexPath.row == 1{
            cell.Profilelabel.text = "CPSEE ADVERTISE CO., LTD"
            cell.ProfileImage.image = UIImage(named: "cp.png")
        }
        else if indexPath.row == 2{
            cell.Profilelabel.text = "COFFEE BACKEND CO., LTD"
            cell.ProfileImage.image = UIImage(named: "co.jpg")
        }
        
        
        return cell
    }

}

