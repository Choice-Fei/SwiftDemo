//
//  LiveUser.swift
//  PracticeDemo
//
//  Created by admin on 2017/12/18.
//  Copyright © 2017年 admin. All rights reserved.
//

import UIKit

class LiveUser: NSObject {
    var flv : String = "";
    var nickname: String = "";
    var position : String = "";
    var photo: String = "";
    
    
    init(dic:[String: Any]){
        super.init();
        flv = dic["flv"] as! String;
        nickname = dic["nickname"] as! String;
        position = dic["position"] as! String;
        photo = dic["photo"] as! String;
    }
    
}
