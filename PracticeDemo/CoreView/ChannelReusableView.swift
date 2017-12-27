//
//  ChannelReusableView.swift
//  PracticeDemo
//
//  Created by admin on 2017/12/11.
//  Copyright © 2017年 admin. All rights reserved.
//

import UIKit

class ChannelReusableView: UICollectionReusableView {
    
    var sectionLabel : UILabel?
    var decriLabel : UILabel?
    var editButton : UIButton?
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        configUI();
    }
    func configUI() {
        sectionLabel = UILabel.init(frame: CGRect.init(x: 20, y: 0, width: 80, height: self.frame.size.height));
        sectionLabel?.textColor = UIColor.white;
        decriLabel = UILabel.init(frame: CGRect.init(x: (sectionLabel?.frame.maxX)!, y: 0, width: kScreenWidth - (sectionLabel?.frame.maxX)! - 56, height: (sectionLabel?.frame.size.height)!));
        decriLabel?.font = UIFont.systemFont(ofSize: 14);
        decriLabel?.textColor = UIColor.white;
        editButton = UIButton.init(frame: CGRect.init(x: (decriLabel?.frame.maxX)!, y: 5, width: 44, height: self.frame.size.height  - 10));
        editButton?.setTitle("编辑", for: UIControlState.normal);
        editButton?.setTitle("完成", for: UIControlState.selected);
        editButton?.layer.cornerRadius = (self.frame.size.height - 10) / 2;
        editButton?.layer.masksToBounds = true;
        editButton?.layer.borderColor = UIColor.red.cgColor;
        editButton?.layer.borderWidth = 1.0;
        editButton?.setTitleColor(UIColor.red, for: UIControlState.normal);
        editButton?.titleLabel?.font = UIFont.systemFont(ofSize: 14);
        
        self.addSubview(sectionLabel!);
        self.addSubview(decriLabel!);
        self.addSubview(editButton!);
        
    }
    func configData(data:Dictionary<String, String>) -> () {
        sectionLabel?.text = data["title"];
        decriLabel?.text = data["dec"];
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
}
