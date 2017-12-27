//
//  LMClientTool.swift
//  PracticeDemo
//
//  Created by admin on 2017/12/5.
//  Copyright © 2017年 admin. All rights reserved.
//

import UIKit
import Alamofire

class LMClientTool: NSObject {
    
    static let shareInstance = LMClientTool.init()
    private override init() {}
   
    func request(requestUrl:String, method methord:HTTPMethod, params param:[String:Any]?, complete:@escaping (_ success:Bool,_ responseObj:Any)  -> ()) {
     
        Alamofire.request(requestUrl, method: methord, parameters: param, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                print(error.localizedDescription)
                break
            case let .success( data):
                complete(true, data)
                break;
            }
        }
    }
}
