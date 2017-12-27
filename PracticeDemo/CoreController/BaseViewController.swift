//
//  BaseViewController.swift
//  PracticeDemo
//
//  Created by admin on 2017/12/5.
//  Copyright © 2017年 admin. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self .isKind(of: HomeViewController.classForCoder()) {
            
        } else {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "navigationBar_popBack"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(popBack));
        }
 
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func popBack (){
        self.navigationController?.popViewController(animated: true)
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
