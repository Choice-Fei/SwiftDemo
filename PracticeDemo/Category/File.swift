//
//  File.swift
//  PracticeDemo
//
//  Created by admin on 2017/12/21.
//  Copyright © 2017年 admin. All rights reserved.
//

import Foundation

extension UIView {
    public var LF_left : CGFloat {
        get {
            return self.frame.origin.x;
        }
        set {
            var frame = self.frame;
            frame.origin.x = newValue;
            self.frame = frame;
        }
    }
    public var LF_top : CGFloat {
        get {
            return self.frame.origin.y;
        }
        set {
            var frame = self.frame;
            frame.origin.y = newValue;
            self.frame = frame;
        }
    }
    public var LF_right: CGFloat {
        get {
            return self.frame.origin.x + self.frame.size.width;
        }
        set {
            var frame = self.frame;
            frame.origin.x = newValue - self.frame.size.width;
            self.frame = frame;
        }
    }
    public var LF_bottom: CGFloat {
        get {
            return self.frame.origin.y + self.frame.size.height;
        }
        set {
            var frame = self.frame;
            frame.origin.y = newValue - self.frame.size.height;
            self.frame = frame;
        }
    }
    public var LF_width : CGFloat {
        get {
            return self.frame.size.width;
        }
        set {
            var frame = self.frame;
            frame.size.width = newValue;
            self.frame = frame;
        }
    }
    public var LF_height : CGFloat {
        get {
            return self.frame.size.height;
        }
        set {
            var frame = self.frame;
            frame.size.height = newValue;
            self.frame = frame;
        }
    }
}
