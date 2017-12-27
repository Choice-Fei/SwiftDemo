//
//  LiveCollectionViewCell.swift
//  PracticeDemo
//
//  Created by admin on 2017/12/18.
//  Copyright © 2017年 admin. All rights reserved.
//

import UIKit

class LiveCollectionViewCell: UICollectionViewCell {
    
    lazy var emitterLayer:CAEmitterLayer = {
     
        let tempLayer = CAEmitterLayer.init();
        tempLayer.emitterPosition = CGPoint.init(x: 80, y:80);
        tempLayer.emitterSize = CGSize.init(width: 20, height: 20);
        tempLayer.renderMode = kCAEmitterLayerUnordered;
        tempLayer.frame = CGRect.init(x: kScreenWidth - 110, y: kScreenHeight - 160, width: 100, height: 100);
     
        return tempLayer;
    }()
    
    lazy var topView : LiveTopView = {
        let view = LiveTopView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 120));
        
        return view;
    }()
    lazy var bottomView: LiveBottomView = {
        let view = LiveBottomView.init(frame: CGRect.init(x: 0, y: kScreenHeight - 50, width: kScreenWidth, height: 40));
        
        return view;
    }()
    
    var render :BarrageRenderer?;
    
    fileprivate var player : PLPlayer? //拉流播放器使用的七牛播放器
    
    var parentVc : UIViewController?
    
    var barrageOpen : Bool = false;
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        configUI();
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    var barrageTimer : Timer?;
    
    func configUI() {
        self.contentView.backgroundColor = UIColor.white;
        self.contentView.addSubview(topView);
        self.contentView.addSubview(bottomView);
        render = BarrageRenderer.init();
        render?.canvasMargin = UIEdgeInsetsMake(kScreenHeight * 0.3, 0, 50, 0)
        self.contentView.layer.insertSublayer(emitterLayer, at: 1);
        

        self.contentView.addSubview((render?.view)!);
        weak var weakSelf = self;
        bottomView.didClick { (current) in
            if current == 3 {
               weakSelf?.player?.stop();
               weakSelf?.player = nil;
                weakSelf?.barrageTimer?.invalidate();
                weakSelf?.barrageTimer = nil;
               weakSelf?.parentVc?.dismiss(animated: true, completion: nil);
            } else if current == 0 {
                //这个是弹幕控制
                weakSelf?.barrageOpen = !self.barrageOpen;
                if (weakSelf?.barrageOpen)! {
                   weakSelf?.render?.start();
                   weakSelf?.barrageTimer =   Timer.init(timeInterval: 0.5, target: self, selector: #selector(weakSelf?.sendBarrage(timer:)), userInfo: nil, repeats: true);
                    RunLoop.main.add((weakSelf?.barrageTimer!)!, forMode:RunLoopMode.commonModes)
                } else {
                    weakSelf?.barrageTimer?.invalidate();
                    weakSelf?.barrageTimer = nil;
                    weakSelf?.render?.stop();
                }
        
            } else if current == 1 {
                weakSelf?.showGif();
            }
            
        }
    }
 
    
    func configData(model:LiveModel) {
        topView.nameLabel.text = model.myname;
        topView.avatarView.sd_setImage(with: URL.init(string: model.smallpic), completed: nil);
        topView.numLabel.text = model.allnum;
        if player?.playerView?.superview != nil  {
            player?.playerView?.removeFromSuperview();
            player = nil;
        }
        player = PLPlayer.init(liveWith:URL.init(string: model.flv), option: PLPlayerOption.default());
        player?.delegate = self;
        self.contentView.insertSubview((player?.playerView)!, at: 0);
        player?.play();
    }
   @objc  func sendBarrage(timer:Timer) {
        let number = render?.spritesNumber(withName: nil);
        if number! < 50 {
            render?.receive(walkTextSpriteDescriptorWithDirection(direction: NSInteger(BarrageWalkDirection.R2L.hashValue)))
        }
    
    }
 
    func walkTextSpriteDescriptorWithDirection(direction:NSInteger) -> BarrageDescriptor {
        let descriptor = BarrageDescriptor.init();
        descriptor.spriteName = NSStringFromClass(BarrageWalkTextSprite.classForCoder());
        let num = Int(arc4random_uniform(UInt32(barrageArray.count)));
        
        descriptor.params["text"] = barrageArray[num];    
        descriptor.params["textColor"] = UIColor.init(red: CGFloat(arc4random_uniform(255)) / 255, green: CGFloat(arc4random_uniform(255)) / 255, blue: CGFloat(arc4random_uniform(255)) / 255, alpha: 1.0);
        descriptor.params["direction"] = NSNumber.init(value: 1);
        descriptor.params["speed"] = NSNumber.init(value: arc4random_uniform(100) + 50);
        return descriptor;
        
    }
    
    lazy var barrageArray: NSArray = {
        let  temp = NSArray.init(contentsOfFile: Bundle.main.path(forResource: "danmu.plist", ofType: nil)!);
        return temp!;
    }()
    
    func showGif() {
        let array = NSMutableArray.init(capacity: 0);
        
        for i in 0...9 {
            let stepCell = CAEmitterCell.init();
            stepCell.birthRate = 1;
            // 粒子存活时间
            stepCell.lifetime = Float(arc4random_uniform(4)) + 1;
            // 粒子的生存时间容差
            stepCell.lifetimeRange = 1.5;
            
            // 颜色
            // fire.color=[[UIColor colorWithRed:0.8 green:0.4 blue:0.2 alpha:0.1]CGColor];
            
            let stepImage = UIImage.init(named: String.init(format: "good%d_30x30", i))
            // 粒子显示的内容
            stepCell.contents = stepImage?.cgImage;
            // 粒子的名字
            //            [fire setName:@"step%d", i];
            // 粒子的运动速度
            stepCell.velocity = CGFloat(arc4random_uniform(100)) + 100;
            // 粒子速度的容差
            stepCell.velocityRange = 80;
            // 粒子在xy平面的发射角度
            stepCell.emissionLongitude = CGFloat(Double.pi + Double.pi/2);
            // 粒子发射角度的容差
            stepCell.emissionRange = CGFloat(Double.pi/2) / 6;
            // 缩放比例
            stepCell.scale = 0.3;
            array.add(stepCell);
        }
        emitterLayer.emitterCells = array as? [CAEmitterCell];
    }
    
}

extension LiveCollectionViewCell : PLPlayerDelegate {
    func player(_ player: PLPlayer, statusDidChange state: PLPlayerStatus) {
      
    }
    func player(_ player: PLPlayer, willRenderFrame frame: CVPixelBuffer?, pts: Int64, sarNumerator: Int32, sarDenominator: Int32) {
        
    }

}


