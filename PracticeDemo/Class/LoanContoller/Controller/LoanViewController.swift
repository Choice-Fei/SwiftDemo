//
//  LoanViewController.swift
//  PracticeDemo
//
//  Created by admin on 2017/12/5.
//  Copyright © 2017年 admin. All rights reserved.
//

import UIKit

class LoanViewController: BaseViewController {
    //推流使用了LFKit框架
    lazy var session : LFLiveSession = {
        let audioConfiguration = LFLiveAudioConfiguration.defaultConfiguration(for: LFLiveAudioQuality.medium);
        let videoConfiguration = LFLiveVideoConfiguration.defaultConfiguration(for: LFLiveVideoQuality.medium3, outputImageOrientation: UIInterfaceOrientation.portrait);
        let session = LFLiveSession.init(audioConfiguration: audioConfiguration, videoConfiguration: videoConfiguration)
        session?.delegate = self;
        session?.preView = liveView;
        session?.beautyFace = true;
        session?.running = true;
        return session!;
    }()
    lazy var stream : LFLiveStreamInfo = {
        let stream = LFLiveStreamInfo.init();
        stream.url = "rtmp://192.168.16.30:1935/rtmplive/room";
       //这里换成你本地推流的地址，本地流媒体服务器搭建参考http://www.jianshu.com/p/8ea016b2720e
        return stream;
    }()
    lazy var liveView : UIView = {
        let tempView = UIView.init(frame: self.view.bounds);
        self.view.insertSubview(tempView, at: 0);
        return tempView;
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true;
        self.title = "直播";
        self.configUI();
        // Do any additional setup after loading the view.
    }
    func configUI() {
        let captureBtn = UIButton.init(frame: CGRect.init(x: kScreenWidth - 120, y: 20, width: 40, height: 40));
        captureBtn.setImage(UIImage.init(named: "camera_change"), for: UIControlState.normal);
        captureBtn.addTarget(self, action: #selector(switchCamera(sender:)), for: UIControlEvents.touchUpInside);
        
        let beautyBtn = UIButton.init(frame: CGRect.init(x: 20, y: 25, width: 100, height: 30));
        beautyBtn.setImage(UIImage.init(named: "icon_beautifulface"), for: UIControlState.normal);
        beautyBtn.setTitle("美颜已关闭", for: UIControlState.normal);
        beautyBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14);
        beautyBtn.setTitle("美颜已开启", for: UIControlState.selected);
        beautyBtn.isSelected = true;
        beautyBtn.layer.cornerRadius = 15;
        beautyBtn.layer.masksToBounds = true;
        beautyBtn.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.2);
        beautyBtn.addTarget(self, action: #selector(switchBeauty(sender:)), for: UIControlEvents.touchUpInside);
        
        let closeBtn = UIButton.init(frame: CGRect.init(x: kScreenWidth - 60, y: 20, width: 40, height: 40));
        closeBtn.setImage(UIImage.init(named: "talk_close"), for: UIControlState.normal);
        closeBtn.addTarget(self, action: #selector(closeLive), for: UIControlEvents.touchUpInside);
        
        self.view.addSubview(captureBtn);
        self.view.addSubview(beautyBtn);
        self.view.addSubview(closeBtn);
        
    }
    //切换前后摄像头
    @objc func switchCamera(sender :UIButton) {
        let devicePosition = session.captureDevicePosition;
        session.captureDevicePosition = devicePosition == AVCaptureDevice.Position.back ? AVCaptureDevice.Position.front : AVCaptureDevice.Position.back;
        
    
    }
    @objc func switchBeauty(sender :UIButton) {
        sender.isSelected = !sender.isSelected;
        session.beautyFace = sender.isSelected;
        
    }
    @objc func closeLive() {
        session.stopLive();
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        //session.startLive(stream);
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
extension LoanViewController: LFLiveSessionDelegate {
    func liveSession(_ session: LFLiveSession?, debugInfo: LFLiveDebug?) {
        print("debug===\(debugInfo)");
    }
    func liveSession(_ session: LFLiveSession?, errorCode: LFLiveSocketErrorCode) {
        print("error==\(errorCode)");
    }
    func liveSession(_ session: LFLiveSession?, liveStateDidChange state: LFLiveState) {
        print("state===",state.hashValue);
    }

}
