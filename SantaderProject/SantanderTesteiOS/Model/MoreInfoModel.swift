//
//  MoreInfoModel.swift
//  SantanderTesteiOS
//
//  Created by Vitor Neves on 12/07/2018.
//  Copyright © 2018 Vitor Neves. All rights reserved.
//

import Foundation

struct MoreInfoModel : Codable {
    var month : MonthModel?
    var year : YearModel?
    var the12Months : TheMonthsModel?
    
    enum CodingKeys: String, CodingKey {
        case the12Months = "12months"
    }
}

//struct DateModel : Codable {
//    var fund : Double?
//    var CDI : Double?
//}

struct MonthModel : Codable {
    var fund : Double?
    var CDI : Double?
}

struct YearModel : Codable {
    var fund : Double?
    var CDI : Double?
}

struct TheMonthsModel : Codable {
    var fund : Double?
    var CDI : Double?
}
