
//
//  ChannelTagsViewController.swift
//  PracticeDemo
//
//  Created by admin on 2017/12/8.
//  Copyright © 2017年 admin. All rights reserved.
//

import UIKit
let kScreenHeight = UIScreen.main.bounds.size.height
class ChannelTagsViewController: UIViewController {
    var tagCollectionView : UICollectionView?
    var mineTags: NSMutableArray?
    var recommendTags : NSMutableArray?
    var mineChannels : NSMutableArray?
    var recChannels : NSMutableArray?
    var isEdited : Bool = false
    
    
    typealias ChooseBlock = (_ selectTags: NSMutableArray) ->Void
    
    var backBlock : ChooseBlock?
    
     init(myTags: NSArray, recTags: NSArray) {
        super.init(nibName: nil, bundle: nil);
        mineChannels = myTags.mutableCopy() as? NSMutableArray;
        recChannels = recTags.mutableCopy() as? NSMutableArray;
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(red: 0.11, green: 0.11, blue: 0.11, alpha: 1.0);
        loadData();
        configUI();
    
        
        // Do any additional setup after loading the view.
    }
    func loadData() {
        mineTags = NSMutableArray.init(capacity: 0);
        recommendTags = NSMutableArray.init(capacity: 0);
        for title in mineChannels! {
            let model = ChannelModel.init();
            model.title = title as! String;
            if (title as! String == "关注" || title as! String == "推荐") {
                model.resident = true;//常驻
            }
            model.editable = false;
            model.selected = false;
            model.channelType = 1;
            //demo默认选择第一个
            if (title as! String == "关注") {
                model.selected = true;
            }
            mineTags?.add(model);
        };
        
        for title in recChannels! {
            let model = ChannelModel.init();
            model.title = title as! String;
            if (title as! String == "关注" || title as! String == "推荐") {
                model.resident = true;//常驻
            }
            model.editable = false;
            model.channelType = 2;
            //demo默认选择第一个
         
            recommendTags?.add(model);
        }
    }
    func configUI() {
        let exitBtn = UIButton.init(frame: CGRect.init(x: 15, y: 34, width: 60, height: 30));
        exitBtn.setTitle("EXIT", for: UIControlState.normal);
        exitBtn.addTarget(self, action: #selector(handleExit), for: UIControlEvents.touchUpInside);
        let layout = UICollectionViewFlowLayout.init();
        layout.itemSize = CGSize.init(width: kScreenWidth/4-10, height: 53);
        layout.minimumLineSpacing = 4;
        layout.minimumInteritemSpacing = 5;
        layout.sectionInset = UIEdgeInsetsMake(0, 10, 4, 10);
        layout.headerReferenceSize = CGSize.init(width: kScreenWidth, height: 40);
        
        tagCollectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: exitBtn.frame.maxY, width: kScreenWidth, height: kScreenHeight - 64), collectionViewLayout: layout);
        tagCollectionView?.delegate = self;
        tagCollectionView?.dataSource = self;
        tagCollectionView?.backgroundColor = UIColor.init(red: 0.11, green: 0.11, blue: 0.11, alpha: 1.0);
        tagCollectionView?.register(ChannelViewCell.classForCoder(), forCellWithReuseIdentifier: "channel");
        tagCollectionView?.register(ChannelReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header");
        self.view.addSubview(exitBtn);
        self.view.addSubview(tagCollectionView!);
        tagCollectionView?.addGestureRecognizer(UILongPressGestureRecognizer.init(target: self, action: #selector(longPress(gesture:))));
    }
    @objc func longPress(gesture:UILongPressGestureRecognizer){
        let point = gesture.location(in: tagCollectionView);
        let indexPath = tagCollectionView?.indexPathForItem(at: point);
        if gesture.state == UIGestureRecognizerState.began {
            tagCollectionView?.beginInteractiveMovementForItem(at: indexPath!);
        } else if gesture.state == UIGestureRecognizerState.changed {
            tagCollectionView?.updateInteractiveMovementTargetPosition(point);
        } else if gesture.state == UIGestureRecognizerState.ended {
            tagCollectionView?.endInteractiveMovement()
        } else {
            tagCollectionView?.cancelInteractiveMovement();
        }
    }
    @objc func handleExit(){
        self.dismiss(animated: true) {

        }
        self.dismiss(animated: true, completion: nil);
        backBlock!(mineTags!);
    }
   public func didChoose(tags:@escaping ChooseBlock) {
        backBlock = tags;
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

extension ChannelTagsViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        if indexPath.section == 0 {
            let model = mineTags![indexPath.item] as! ChannelModel;
            if model.resident {
                return false;
            } else {
                return true;
            }
        }
        return false;
    }
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let model = mineTags![sourceIndexPath.item] as! ChannelModel;
        mineTags?.remove(model);
        if destinationIndexPath.section == 0 {
            mineTags?.insert(model, at: destinationIndexPath.item);
        } else {
            model.channelType = 2;
            model.editable = false;
            model.selected = false;
            recommendTags?.insert(model, at: destinationIndexPath.item);
            collectionView.reloadItems(at: [destinationIndexPath]);
        }

    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            
        } else {
            let model = recommendTags![indexPath.item] as! ChannelModel;
            model.channelType = 1;
            recommendTags?.removeObject(at: indexPath.item);
            mineTags?.add(model);
            collectionView.reloadData();
        }
    }
    
}



extension ChannelTagsViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2;
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return (mineTags?.count)!;
        } else {
            return (recommendTags?.count)!;
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let _cell : ChannelViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "channel", for: indexPath) as! ChannelViewCell;
        if indexPath.section == 0 {
            let model = mineTags![indexPath.item] as! ChannelModel
            if (mineTags?.count)! > indexPath.item {
                _cell.configData(model:model)
                _cell.delButton.tag = indexPath.item;
                _cell.delegate = self;
                
            }
        } else {
            let model = recommendTags![indexPath.item] as! ChannelModel
            _cell.configData(model: model);
        }
        return _cell;
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! ChannelReusableView;
        if indexPath.section == 0 {
            headerView.configData(data: ["title":"我的频道","dec":"点击进入频道"])
            headerView.editButton?.isHidden = false;
            headerView.editButton?.isSelected = isEdited;
            headerView.editButton?.addTarget(self, action: #selector(handleEdit(sender:)), for: UIControlEvents.touchUpInside);

        } else {
            headerView.configData(data: ["title":"频道推荐","dec":"点击添加频道"])
            headerView.editButton?.isHidden = true;
        }
        
        return headerView;
        
    }
    @objc func handleEdit(sender:UIButton) {
        isEdited = !isEdited;
        for item in mineTags! {
            let model = item as! ChannelModel;
            model.editable = isEdited;
        }
        tagCollectionView?.reloadSections(IndexSet.init(integer: 0));
    }
    
}
extension ChannelTagsViewController : ChannelDelegate {
    
    func deleteCell(sender: UIButton) {
        let model = mineTags![sender.tag] as! ChannelModel;
        model.channelType = 2;
        mineTags?.removeObject(at: sender.tag);
        recommendTags?.insert(model, at: 0);
        tagCollectionView?.reloadData();
    }
}



