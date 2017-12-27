//
//  LiveBottomView.swift
//  PracticeDemo
//
//  Created by admin on 2017/12/19.
//  Copyright © 2017年 admin. All rights reserved.
//

import UIKit

class LiveBottomView: UIView {
    
    typealias clickBlock = (_ clickIndex: Int) ->();
    
    var returnBlock : clickBlock?;
    
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        configUI();
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    func configUI() {
        let width = kScreenWidth / 4;
        let images = ["talk_public","talk_sendgift","talk_share","talk_close"];
        
        for i in 0...3 {
            
            let button = UIButton.init(frame: CGRect.init(x: width * CGFloat(i) , y: 0, width:width, height: self.frame.size.height));
            button.setImage(UIImage.init(named: images[i]), for: UIControlState.normal);
            button.tag = i;
            button.addTarget(self, action: #selector(clickBtn(sender:)), for: UIControlEvents.touchUpInside);
            self.addSubview(button);
        }
        
    }
    @objc func clickBtn(sender:UIButton) {
        returnBlock!(sender.tag);

    }
    func didClick(clickIndex: @escaping clickBlock) {
        returnBlock = clickIndex;
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
