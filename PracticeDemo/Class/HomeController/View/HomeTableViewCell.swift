//
//  HomeTableViewCell.swift
//  PracticeDemo
//
//  Created by admin on 2017/12/6.
//  Copyright © 2017年 admin. All rights reserved.
//

import UIKit
let kScreenWidth = UIScreen.main.bounds.size.width
class HomeTableViewCell: UITableViewCell {
   
    var  iconView : UIImageView!
    var  nameLabel : UILabel!
    var  infoLabel : UILabel!
    var  detaLabel : UILabel!
    var  arrowView : UIImageView!
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configUI()
        selectionStyle = UITableViewCellSelectionStyle.none
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    fileprivate func configUI() -> () {
        iconView = UIImageView.init();
        nameLabel = UILabel.init();
        infoLabel = UILabel.init();
        infoLabel.textColor = UIColor.lightGray;
        infoLabel.numberOfLines = 0;
        infoLabel.font = UIFont.systemFont(ofSize: 14);
        detaLabel = UILabel.init();
        detaLabel.textColor = UIColor.lightGray
        detaLabel.font = UIFont.systemFont(ofSize: 12);
        arrowView = UIImageView.init();
        arrowView.image = UIImage.init(named: "icon_arrow")
        self.contentView.addSubview(iconView)
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(infoLabel)
        self.contentView.addSubview(detaLabel)
        self.contentView.addSubview(arrowView)
        let array = NSMutableArray.init(capacity: 1)
        array.add(nameLabel)
        array.add(infoLabel)
        array.add(detaLabel)
        
        iconView.mas_makeConstraints { (maker) in
            maker?.left.mas_equalTo()(6);
            maker?.top.mas_equalTo()(6);
            maker?.size.mas_equalTo()(CGSize.init(width: 68, height: 68));
            //rmaker?.bottom.mas_equalTo()(-6);
        }
        nameLabel.mas_makeConstraints { (maker) in
            maker?.left.mas_equalTo()(iconView.mas_right)?.offset()(10);
            maker?.top.mas_equalTo()(6);
            maker?.size.mas_equalTo()(CGSize.init(width: kScreenWidth - 113, height: 20));
        }
        infoLabel.mas_makeConstraints { (maker) in
            maker?.left.mas_equalTo()(nameLabel.mas_left);
            maker?.top.mas_equalTo()(nameLabel.mas_bottom)?.offset()(5);
            maker?.width.mas_equalTo()(nameLabel.mas_width);
            maker?.bottom.mas_equalTo()(-30);
        }
        detaLabel.mas_makeConstraints { (maker) in
            maker?.left.equalTo()(infoLabel.mas_left);
            maker?.top.equalTo()(infoLabel.mas_bottom)?.offset()(5);
            maker?.width.equalTo()(infoLabel.mas_width);
            maker?.height.equalTo()(infoLabel.mas_height);
        }
//        array.mas_distributeViews(along: MASAxisType.vertical, withFixedItemLength: 20, leadSpacing: 6, tailSpacing: 4)
//        array.mas_makeConstraints { (maker) in
//            maker?.width.mas_equalTo()(kScreenWidth - 113);
//            maker?.left.equalTo()(iconView.mas_right)?.offset()(10)
//        }
        arrowView.mas_makeConstraints { (maker) in
            maker?.centerY.mas_equalTo()(self.contentView.mas_centerY)
            maker?.right.mas_equalTo()(-12)
            maker?.size.mas_equalTo()(CGSize.init(width: 17, height: 17))
        }
 
    
        
        
    }
    func configData(model:BSModel) -> () {
        
        iconView.sd_setImage(with: URL.init(string:model.profile_image), completed: nil);
        nameLabel.text = model.name;
        infoLabel.text = model.text;
        detaLabel.text = model.create_time;
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
