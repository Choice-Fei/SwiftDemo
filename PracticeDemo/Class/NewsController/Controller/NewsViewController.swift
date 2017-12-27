//
//  NewsViewController.swift
//  PracticeDemo
//
//  Created by admin on 2017/12/5.
//  Copyright © 2017年 admin. All rights reserved.
//

import UIKit
import Alamofire



class NewsViewController: BaseViewController {
  
    lazy var listTableView : UITableView = {
        let tempView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight), style: UITableViewStyle.plain);
        tempView.delegate = self;
        tempView.dataSource = self;
        tempView.tableFooterView = UIView.init();
        tempView.rowHeight = kScreenWidth + 80;
        tempView.mj_header = LFGifHeader.init(refreshingBlock: {
           self.loadData();
        })
        tempView.register(LiveTableViewCell.classForCoder(), forCellReuseIdentifier: "live");
        return tempView;
    }()
    lazy var dataSource: NSMutableArray = {
        let temp = NSMutableArray.init(capacity: 0);
        return temp;
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = nil;
        
        self.view.addSubview(listTableView);
        loadData();
        
      
        // Do any additional setup after loading the view.
    }
    func loadData() {
        LMClientTool.shareInstance.request(requestUrl: "http://live.9158.com/Fans/GetHotLive?page=1", method: HTTPMethod.get, params: nil) { (success, responseObj) in
            print(responseObj);
            guard  let tempDic = responseObj as? [String : Any] else{
                return;
            };
            let tempObj = tempDic["data"] as? [String : Any];
            let tempArr = tempObj!["list"] as? [Any];
            self.dataSource.removeAllObjects();
            for dic in tempArr! {
                let model = LiveModel.init();
                let itemDic = dic as! NSDictionary;
                let num = itemDic["allnum"] as? NSNumber;
                
                model.gps = itemDic["gps"] as! String;
                model.allnum = (num?.stringValue)!;
                model.bigPic = itemDic["bigpic"] as! String;
                model.flv = itemDic["flv"] as! String;
                model.myname = itemDic["myname"] as! String;
                model.smallpic = itemDic["smallpic"] as! String;
                self.dataSource.add(model);
                
            }
            
            //这里利用归档反归档存取数据，
            //NSKeyedArchiver.archiveRootObject(self.dataSource, toFile: self.filePath);
            //let value = NSKeyedUnarchiver.unarchiveObject(withFile: self.filePath);
            
            
            self.listTableView.mj_header.endRefreshing();
            self.listTableView.reloadData();
            
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var filePath : String = {
        
        let mananger = FileManager.default;
        let url = mananger.urls(for: .documentDirectory, in: .userDomainMask).first! as NSURL;
        
        return (url.appendingPathComponent("livemodel")?.path)!;
    }()
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "live", for: indexPath) as! LiveTableViewCell;
        let model = dataSource.object(at: indexPath.row) as! LiveModel;
        cell.configData(model: model);
        
        return cell;
    }
    
    
    
}
extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = LiveDetailViewController();
        detailVC.lives = dataSource as! [LiveModel];
        detailVC.currentIndex = indexPath.row
        self.present(detailVC, animated: true, completion: nil);
    }
}
