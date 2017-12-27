//
//  LiveTableViewCell.swift
//  PracticeDemo
//
//  Created by admin on 2017/12/18.
//  Copyright © 2017年 admin. All rights reserved.
//

import UIKit

class LiveTableViewCell: UITableViewCell {

    var avatarView : UIImageView!
    var nameLabel : UILabel!
    var infoLabel : UILabel!
    var coverView : UIImageView!
    
    
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        self.selectionStyle = UITableViewCellSelectionStyle.none;
        configUI();
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    func configUI() {
        avatarView = UIImageView.init();
        nameLabel = UILabel.init();
        infoLabel = UILabel.init();
        coverView = UIImageView.init();
        self.contentView.addSubview(avatarView);
        self.contentView.addSubview(nameLabel);
        self.contentView.addSubview(infoLabel);
        self.contentView.addSubview(coverView);
        
        avatarView.layer.cornerRadius = 30;
        avatarView.layer.masksToBounds = true;
        infoLabel.textColor = UIColor.lightGray;
        infoLabel.font = UIFont.systemFont(ofSize: 14);
        
        avatarView.mas_makeConstraints { (maker) in
            maker?.size.mas_equalTo()(CGSize.init(width: 60, height: 60));
            maker?.left.mas_equalTo()(10);
            maker?.top.mas_equalTo()(10);
        }
        nameLabel.mas_makeConstraints { (maker) in
            maker?.left.equalTo()(avatarView.mas_right)?.offset()(10);
            maker?.top.mas_equalTo()(avatarView);
            maker?.size.mas_equalTo()(CGSize.init(width: kScreenWidth - 60, height: 30));
        }
        infoLabel.mas_makeConstraints { (maker) in
            maker?.left.equalTo()(avatarView.mas_right)?.offset()(10);
            maker?.top.mas_equalTo()(nameLabel.mas_bottom);
            maker?.size.equalTo()(nameLabel);
        }
        coverView.mas_makeConstraints { (maker) in
            maker?.size.mas_equalTo()(CGSize.init(width: kScreenWidth, height: kScreenWidth));
            maker?.top.mas_equalTo()(80);
            maker?.left.mas_equalTo()(0);
        }
    }
    
   public  func configData(model:LiveModel) -> () {
        avatarView.sd_setImage(with: URL.init(string: model.smallpic), completed: nil);
        nameLabel.text = model.myname;
        infoLabel.text = model.gps;
        coverView.sd_setImage(with: URL.init(string: model.bigPic), completed: nil);
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
