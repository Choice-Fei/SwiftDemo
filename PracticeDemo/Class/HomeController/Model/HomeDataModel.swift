//
//  HomeDataModel.swift
//  PracticeDemo
//
//  Created by admin on 2017/12/6.
//  Copyright © 2017年 admin. All rights reserved.
//

import UIKit

class HomeDataModel: NSObject  {
    
    var index_images : Array = [Any]()
    var user_loan_log_list : Array = [Any]()
    var platformInfoList : Array = [Any]()
    
}
class LoanPlatformModel: NSObject {
    var applyCondition : String = ""
    var appname : String = ""
    var img : String = ""
    var mainId : String = ""
    var rate : String = ""
    var name : String = ""
    var successTotal: String = ""
    var title : String = ""
    
}
class BannerModel: NSObject  {
    var imgLink : String = ""
    var link : String = ""
    var bannerId : String = ""
}

extension LoanPlatformModel :YYModel {
    static func modelCustomPropertyMapper() -> [String : Any]? {
        return ["mainId":"id"]
    }
}

extension BannerModel : YYModel {
    static func modelCustomPropertyMapper() -> [String : Any]? {
        return["bannerId":"id"]
    }
}
extension HomeDataModel : YYModel {
    static func modelCustomPropertyMapper() -> [String : Any]? {
        return ["index_images":BannerModel.classForCoder(),"platformInfoList":LoanPlatformModel.classForCoder()]
    }
}
