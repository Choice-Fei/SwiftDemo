//
//  HomeHeaderView.swift
//  PracticeDemo
//
//  Created by admin on 2017/12/6.
//  Copyright © 2017年 admin. All rights reserved.
//

import UIKit



class HomeHeaderView: UIView {
    typealias  didClick = (_ index:Int) -> Void
    
    var  callBack: didClick?
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    fileprivate func configUI(){
        for i in 0...2 {
            let leftMargin = kScreenWidth * CGFloat(i)
            let sender = LMLayoutButton.init(frame: CGRect.init(x: leftMargin / 3, y: 10, width: kScreenWidth / 3, height: 70))
            sender.setTitle(["下载快","平台多","利息低"][i], for: UIControlState.normal)
            sender.setTitleColor(UIColor.black, for: UIControlState.normal)
            sender.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            sender.setImage(UIImage.init(named: ["home_iv_src_xiazaizuikuai","home_iv_src_quanpintgai","home_iv_src_tongguolvgao"][i]), for: UIControlState.normal)
            sender.addTarget(self, action: #selector(click(sender:)), for: UIControlEvents.touchUpInside)
            sender.tag = i
            self.addSubview(sender)
        }
        let sepView = UIView.init(frame: CGRect.init(x: 0, y: 90, width: kScreenWidth, height: 5))
        sepView.backgroundColor = UIColor.init(red: 220/255.0, green: 220/255.0, blue: 220/255.0, alpha: 1.0)
        self.addSubview(sepView);

    }
    @objc func click(sender:UIButton) -> () {
        callBack!(sender.tag)
    }
    
   public func callBackBlock(block:@escaping (_ index :Int) -> Void) {
        callBack = block
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

 class LMLayoutButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        var center = self.imageView?.center
        center?.x = self.frame.size.width / 2
        center?.y = (self.imageView?.frame.size.height)!/2
        self.imageView?.center = center!
        
        var labelFrame = self.titleLabel?.frame;
        labelFrame?.origin.x = 0;
        labelFrame?.origin.y = (self.imageView?.frame.size.height)! + 5
        labelFrame?.size.width = self.frame.size.width
        self.titleLabel?.textAlignment = NSTextAlignment.center
        self.titleLabel?.frame = labelFrame!
    }
}
