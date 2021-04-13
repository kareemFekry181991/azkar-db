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
    
    static var deviceToken: String? {
        set{
            UserDefaults.standard.set(newValue, forKey: Constants.deviceToken)
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.string(forKey: Constants.deviceToken)
        }
    }
    static var firebaseToken: String? {
        set{
            UserDefaults.standard.set(newValue, forKey: Constants.firebaseToken)
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.string(forKey: Constants.firebaseToken)
        }
    }
    
    static var quranPage: Int? {
        set{
            UserDefaults.standard.set(newValue, forKey: Constants.quranPage)
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.integer(forKey: Constants.quranPage)
        }
    }

    static var markedQuranPage: Int? {
        set{
            UserDefaults.standard.set(newValue, forKey: Constants.markedQuranPage)
            UserDefaults.standard.synchronize()
        }
        get{
            return UserDefaults.standard.integer(forKey: Constants.markedQuranPage)
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
