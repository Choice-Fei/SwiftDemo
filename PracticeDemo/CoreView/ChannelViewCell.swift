//
//  ChannelViewCell.swift
//  PracticeDemo
//
//  Created by admin on 2017/12/8.
//  Copyright © 2017年 admin. All rights reserved.
//

import UIKit

protocol ChannelDelegate: NSObjectProtocol {
    func deleteCell(sender:UIButton);
}

class ChannelViewCell: UICollectionViewCell {
    
    var titleLabel: UILabel!
    var delButton: UIButton!
    var currentModel: ChannelModel?
    weak var delegate:ChannelDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame);
        titleLabel = UILabel.init(frame: CGRect.init(x: 5, y: 5, width: frame.size.width - 10, height: frame.size.height - 10));
        titleLabel.backgroundColor = UIColor.init(red: 0.08, green: 0.08, blue: 0.08, alpha: 1.0);
        titleLabel.layer.cornerRadius = CGFloat(Double.pi);
        titleLabel.layer.masksToBounds = true;
        titleLabel.textColor = UIColor.white;//UIColor.init(red: 0.36, green: 0.36, blue: 0.38, alpha: 1.0)
        titleLabel.textAlignment = NSTextAlignment.center;
        delButton = UIButton.init(frame: CGRect.init(x: frame.size.width - 18, y: 0, width: 18, height: 18));
        delButton.setImage(UIImage.init(named: "del"), for: UIControlState.normal);
        delButton.addTarget(self, action: #selector(handleDelete(sender:)), for: UIControlEvents.touchUpInside);
        
        self.contentView.addSubview(titleLabel);
        self.contentView.addSubview(delButton);
    }
    func configData(model:ChannelModel) -> () {
        currentModel = model;
        if model.channelType == 1 {
            if (model.title .contains("+")) {
                let index = model.title.index(model.title.startIndex, offsetBy: 1);
                let subSTring  = model.title.suffix(from: index);
                model.title  =   String.init(subSTring);
            }

            if model.resident{
                delButton.isHidden = true;
            } else {
                if model.editable {
                    delButton.isHidden = false;
                } else {
                    delButton.isHidden = true;
                }
            }
        } else {
            if !(model.title.contains("+")) {
                model.title = "+"+model.title;
            }
            if model.editable {
                model.editable = false;
            } else {}
            delButton.isHidden = true;
        }
        titleLabel.text = model.title;
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    @objc func handleDelete(sender:UIButton) {
        delegate?.deleteCell(sender: sender);
    }
    
}
