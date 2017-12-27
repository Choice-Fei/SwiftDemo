//
//  LiveModel.swift
//  PracticeDemo
//
//  Created by admin on 2017/12/18.
//  Copyright © 2017年 admin. All rights reserved.
//

import UIKit

class LiveModel: NSObject,NSCoding {
    var allnum : String = ""
    var bigPic : String = ""
    var flv : String = ""
    var myname: String = ""
    var smallpic : String = ""
    var gps : String = ""
    
    override init() {
        super.init();
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        allnum = aDecoder.decodeObject(forKey: "allnum") as! String;
        bigPic = aDecoder.decodeObject(forKey: "bigPic") as! String;
        flv = aDecoder.decodeObject(forKey: "flv") as! String;
        myname = aDecoder.decodeObject(forKey: "myname") as! String;
        smallpic = aDecoder.decodeObject(forKey: "smallpic") as! String;
        gps = aDecoder.decodeObject(forKey: "gps") as! String;
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(allnum, forKey: "allnum");
        aCoder.encode(bigPic, forKey: "bigPic");
        aCoder.encode(flv, forKey: "flv");
        aCoder.encode(myname, forKey: "myname");
        aCoder.encode(smallpic, forKey: "smallpic");
        aCoder.encode(gps, forKey: "gps");
    }
    
}





/*
 allnum = 7059;
 anchorlevel = 0;
 bigpic = "http://liveimg.9158.com/pic/avator/2017-12/15/15/20171215151151_67010126_640.png";
 distance = 0;
 familyName = "\U5149\U8f69";
 flv = "http://hdl.9158.com/live/3949645a9d23a15d3ccc3888e0f311f9.flv";
 gameid = 0;
 gender = 0;
 gps = "\U6210\U90fd\U5e02";
 isSign = 0;
 myname = "\U5149\U8f69\U5c0f\U827e";
 nType = 0;
 nation = "";
 nationFlag = "";
 pos = 20;
 roomid = 63440986;
 serverid = 18;
 smallpic = "http://liveimg.9158.com/pic/avator/2017-12/15/15/20171215151151_67010126_250.png";
 starlevel = 1;
 userId = WeiXin27844742;
 useridx = 67010126;
 */
