//
//  HomeViewController.swift
//  PracticeDemo
//
//  Created by admin on 2017/12/5.
//  Copyright © 2017年 admin. All rights reserved.
//

import UIKit
import Alamofire



class HomeViewController: BaseViewController {
    var  cellHeightCache : NSMutableDictionary!
    lazy var dataSource : Array = { () -> [BSModel] in
        let tempArr = [BSModel]();
        return tempArr;
    }()

    lazy var listTableView : UITableView = {
        
        let tempTableView = UITableView.init(frame: self.view.bounds, style: UITableViewStyle.plain)
        tempTableView.delegate = self
        tempTableView.dataSource = self
        tempTableView.estimatedRowHeight = 100
        tempTableView.rowHeight = UITableViewAutomaticDimension
        tempTableView.register(HomeTableViewCell.classForCoder(), forCellReuseIdentifier: "test")
        tempTableView.tableHeaderView = headerView;
        tempTableView.tableFooterView = UIView.init();
        tempTableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            self.loadData();
            tempTableView.mj_header.endRefreshing()
            tempTableView.reloadData()
        })
        return tempTableView
        
    }()
    lazy var headerView: HomeHeaderView = {
        let tempHeader = HomeHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 95))
        tempHeader.callBackBlock(block: { (index) in
            print(index);
        })
        return tempHeader
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "首页"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(showTag))
//        if #available(iOS 11.0, *) {
//           listTableView.contentInsetAdjustmentBehavior = .never
//        } else {
//            self.automaticallyAdjustsScrollViewInsets = false;
//        }
        let statusHeight : CGFloat = UIApplication.shared.statusBarFrame.size.height
        print("height= \(statusHeight)")
        cellHeightCache = NSMutableDictionary.init(capacity: 10)
        self.view.addSubview(listTableView)
        self.loadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            print("💦",Date())
        }
        let myQueue = DispatchQueue.main;
        let group  = DispatchGroup();
        myQueue.async(group: group, qos: .default, flags: []) {
            print("任务1  ");
        }
        myQueue.async(group: group, qos: .default, flags: []) {
          print("任务 2   ")
        };

        group.notify(queue: myQueue) {
          print("任务结束 ")
        };
      
        
    
        
        // Do any additional setup after loading the view.
    }
    fileprivate func loadData(){
        var parameter = [String: String]()
        parameter["a"] = "newlist"
        parameter["c"] = "data"
        parameter["page"] = "\(1)"
        parameter["type"] = "\(1)"
        parameter["maxtime"] = ""
        LMClientTool.shareInstance.request(requestUrl:"http://api.budejie.com/api/api_open.php", method: HTTPMethod.get, params: parameter) { (status, responseObj) in
            guard  let tempDic = responseObj as? [String : Any] else{
                return;
            };
            let tempArr = tempDic["list"] as? [Any];
            for dic in tempArr! {
                let model = BSModel.init();
                let itemDic = dic as! [String :Any];
            
                model.profile_image = itemDic["profile_image"] as! String;
                model.text = itemDic["text"] as! String;
                model.name = itemDic["name"] as! String;
                model.create_time = itemDic["create_time"] as! String;
                
                self.dataSource.append(model);
 
            };
           self.listTableView.reloadData();
        
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //[@"关注",@"推荐",@"热点",@"北京",@"视频",@"社会",@"图片",@"娱乐",@"问答",@"科技",@"汽车",@"财经",@"军事",@"体育",@"段子",@"国际",@"趣图",@"健康",@"特卖",@"房产",@"美食"]
    //[@"小说",@"时尚",@"历史",@"育儿",@"直播",@"搞笑",@"数码",@"养生",@"电影",@"手机",@"旅游",@"宠物",@"情感",@"家居",@"教育",@"三农"]
    @objc func showTag() {
        let channelVC = ChannelTagsViewController.init(myTags: ["关注","推荐","热点","北京","视频","社会","图片","娱乐","问答","科技","汽车","财经","军事","体育","段子","国际","趣图","健康","特卖","房产","美食"], recTags: ["小说","时尚","历史","育儿","直播","搞笑","数码","养生","电影","手机","旅游","宠物","情感","家居","教育","三农"]);
        channelVC.didChoose { (chooseTags) in
            print(chooseTags);
            
        }
        self.present(channelVC, animated: true, completion: nil);
        
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
extension HomeViewController :UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : HomeTableViewCell = tableView.dequeueReusableCell(withIdentifier: "test", for: indexPath) as! HomeTableViewCell;
        cell.configData(model: self.dataSource[indexPath.row]);
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let height = NSNumber.init(value: Float(cell.frame.size.height))
        cellHeightCache.setObject(height, forKey: indexPath.description as NSCopying)
        
    }

}

extension HomeViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
    }
    
}
