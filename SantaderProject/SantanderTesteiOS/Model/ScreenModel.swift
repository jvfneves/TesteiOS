//
//  ScreenModel.swift
//  SantanderTesteiOS
//
//  Created by Vitor Neves on 12/07/2018.
//  Copyright © 2018 Vitor Neves. All rights reserved.
//

import Foundation

struct ScreenModel : Codable {
    var screen : ScreenDetailModel?
}

struct ScreenDetailModel : Codable{
    var title : String?
    var fundName : String?
    var whatIs : String?
    var definition : String?
    var riskTitle : String?
    var risk : Int64?
    var infoTitle : String?
    var moreInfo : MoreInfoModel?
    var info : [InfoModel]?
    var downInfo : [InfoModel]?
}
