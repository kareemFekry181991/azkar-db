//
//  UserStatus.swift
//  AlNawares
//
//  Created by Kareem on 3/11/20.
//  Copyright © 2020 Kareem. All rights reserved.
//


import Foundation
struct UserStatus {

    static var azkaryArr: [String]? {
        set{
            UserDefaults.standard.set(newValue, forKey: Constants.azkaryArr)
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.stringArray(forKey: Constants.azkaryArr)
        }
    }
}
