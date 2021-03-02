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
    
    
    static var latitude:Double? {
        set{
            UserDefaults.standard.set(newValue, forKey: Constants.latitude)
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.double(forKey: Constants.latitude)
        }
    }
    static var longtitude:Double? {
        set{
            UserDefaults.standard.set(newValue, forKey: Constants.longtitude)
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.double(forKey: Constants.longtitude)
        }
    }
}
