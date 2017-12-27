//
//  LiveDetailViewController.swift
//  PracticeDemo
//
//  Created by admin on 2017/12/18.
//  Copyright © 2017年 admin. All rights reserved.
//

import UIKit



class LiveDetailViewController: UIViewController {
 
    var lives = [LiveModel]();
    var currentIndex:Int = 0;
    
    lazy var liveCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout.init();
        layout.itemSize = CGSize.init(width: kScreenWidth, height: kScreenHeight);
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        let tempCollection = UICollectionView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight), collectionViewLayout: layout);
        tempCollection.delegate = self;
        tempCollection.dataSource = self;
        tempCollection.register(LiveCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "detail");
    
        tempCollection.mj_header = LFGifHeader.init(refreshingTarget: self, refreshingAction: #selector(handleRefresh));
        return tempCollection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white;
        self.view.addSubview(liveCollectionView);
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    @objc func handleRefresh() {
        currentIndex += 1;
        if currentIndex == lives.count {
            currentIndex = 0;
        }
        liveCollectionView.mj_header.endRefreshing();
        liveCollectionView.reloadData();
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
extension LiveDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}
extension LiveDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1;
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "detail", for: indexPath) as! LiveCollectionViewCell;
        let model = lives[currentIndex];
        cell.configData(model: model);
        cell.parentVc = self;
        return cell;
    }
    
}

