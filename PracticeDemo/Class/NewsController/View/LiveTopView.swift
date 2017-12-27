//
//  LiveTopView.swift
//  PracticeDemo
//
//  Created by admin on 2017/12/18.
//  Copyright © 2017年 admin. All rights reserved.
//

import UIKit

class LiveTopView: UIView {

    var UserBackView : UIView!;
    var avatarView : UIImageView!;
    var nameLabel : UILabel!;
    var numLabel : UILabel!;
    var switchBtn : UIButton!;
    var otherView : UIScrollView!;
    
    
    
    
    lazy var otherUsers : NSMutableArray = {
        
        let tempUser =  NSArray.init(contentsOfFile: Bundle.main.path(forResource: "user.plist", ofType: nil)!);
        
        let tempArr = NSMutableArray.init(capacity: 0);
        for dic in tempUser! {
            let  user = LiveUser.init(dic: dic as! [String: Any]);
            tempArr.add(user);
        }
        
        return tempArr;
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        configUI();
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    func configUI() {
        UserBackView = UIView.init(frame: CGRect.init(x: 10, y: 20, width: 220, height: 60));
        UserBackView.backgroundColor = UIColor.init(white: 0, alpha: 0.3);
     
        avatarView = UIImageView.init(frame: CGRect.init(x: 10, y: 5, width: 50, height: 50));
        nameLabel = UILabel.init(frame: CGRect.init(x: avatarView.frame.maxX + 10, y: avatarView.frame.minY, width: 80, height: 20));
        numLabel = UILabel.init(frame: CGRect.init(x: avatarView.frame.maxX + 10, y: nameLabel.frame.maxY + 10, width: nameLabel.frame.width, height: nameLabel.frame.height));
        nameLabel.textColor = UIColor.white;
        numLabel.textColor = UIColor.white;
        switchBtn = UIButton.init(frame: CGRect.init(x: 160, y: avatarView.frame.minY, width: avatarView.frame.width, height: avatarView.frame.height));
        switchBtn.setTitle("展开", for: UIControlState.normal);
        switchBtn.setTitle("收起", for: UIControlState.selected);
        UserBackView.addSubview(avatarView);
        UserBackView.addSubview(nameLabel);
        UserBackView.addSubview(numLabel);
        UserBackView.addSubview(switchBtn);
        layerMask(view: UserBackView);
        layerMask(view: avatarView);
        layerMask(view: switchBtn);
        self.addSubview(UserBackView);
        
        otherView = UIScrollView.init(frame: CGRect.init(x: UserBackView.frame.maxX + 10, y: 25, width: kScreenWidth - 250, height: 50));
        otherView.showsHorizontalScrollIndicator = false;
        otherView.contentSize = CGSize.init(width: 50 * otherUsers.count, height: 0);
        for i in 0...otherUsers.count-1 {
            let user = otherUsers[i] as! LiveUser;
            
            let userView = UIImageView.init(frame: CGRect.init(x: i*50, y: 5, width: 40, height: 40));
            userView.layer.cornerRadius = 20;
            userView.layer.masksToBounds = true;
            userView.sd_setImage(with: URL.init(string: user.photo), completed: nil);
            otherView.addSubview(userView);
        
        }
        self.addSubview(otherView);
    }
    
    func layerMask(view:UIView) {
        view.layer.cornerRadius = view.frame.size.height / 2;
        view.layer.masksToBounds = true;
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
