//
//  LMTabBarViewController.swift
//  PracticeDemo
//
//  Created by admin on 2017/12/5.
//  Copyright © 2017年 admin. All rights reserved.
//

import UIKit

class LMTabBarViewController: UITabBarController {
    var mineNA:UINavigationController!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        // Do any additional setup after loading the view.
    }
    func setUp() -> () {
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().barTintColor = Common.HexColor(hex: 0x0099FF);
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
       
        
        let homeNA = childVivwController(viewController:HomeViewController(), normarlImage: UIImage.init(named: "common_iv_src_home_normal")!, selectImgage: UIImage.init(named: "common_iv_src_home_pressed")!)
        homeNA.title = "首页"
        homeNA.navigationBar.backItem?.title = ""
        let loanNA = childVivwController(viewController: LoanViewController(), normarlImage: UIImage.init(named: "common_iv_src_loan_normal")!, selectImgage: UIImage.init(named: "common_iv_src_loan_pressed")!)
        loanNA.title = "推流"
        let newsNA = childVivwController(viewController: NewsViewController(), normarlImage: UIImage.init(named: "common_iv_src_active_normal")!, selectImgage: UIImage.init(named: "common_iv_src_active_pressed")!)
        newsNA.title = "拉流"
        mineNA = childVivwController(viewController: MineViewController(), normarlImage: UIImage.init(named: "common_iv_src_mine_normal")!, selectImgage: UIImage.init(named: "common_iv_src_mine_pressed")!)
        mineNA.title = "我的"
      
        self.viewControllers = [homeNA,loanNA,newsNA,mineNA];
        
  
       
        
    }
   
    func childVivwController(viewController :UIViewController,normarlImage normalImage:UIImage, selectImgage selectImage:UIImage ) -> UINavigationController {
        let childNA = UINavigationController.init(rootViewController: viewController)
        childNA.tabBarItem.image = normalImage
        childNA.tabBarItem.selectedImage = selectImage.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
     
        return childNA;
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
