//
//  AzkarModel.swift
//  Azkar
//
//  Created by Kareem on 12/27/20.
//  Copyright © 2020 Kareem. All rights reserved.
//

import Foundation

class AzkarModel: Codable {
    var data : [Azkar]?
}
class Azkar: Codable {
    var category: String?
    var data: [AzkarData]?
}
class AzkarData: Codable {
    var category: String?
    var count: String?
    var description: String?
    var reference: String?
    var zekr: String?
}


