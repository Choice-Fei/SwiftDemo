//
//  Common.swift
//  PracticeDemo
//
//  Created by admin on 2017/12/18.
//  Copyright © 2017年 admin. All rights reserved.
//

import UIKit

class Common: NSObject {
  
   class func HexColor(hex: Int) -> UIColor {
        
        return UIColor(red: ((CGFloat)((hex & 0xFF0000) >> 16)) / 255.0,
                       green: ((CGFloat)((hex & 0xFF00) >> 8)) / 255.0,
                       blue: ((CGFloat)(hex & 0xFF)) / 255.0,
                       alpha: 1.0)
    }

}
