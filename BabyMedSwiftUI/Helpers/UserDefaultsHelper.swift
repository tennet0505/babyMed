//
//  UserDefaultsHelper.swift
//  BabyMedSwiftUI
//
//  Created by Oleg Ten on 4/12/20.
//  Copyright © 2020 Oleg Ten. All rights reserved.
//

import Foundation

public class UserDefaultsHelper{
    //    сохранение Bool
    open class var isChangeLanguage:Bool{
        get{return UserDefaults.standard.bool(forKey: "UserDefaultsHelper.isChangeLanguage")}
        set{UserDefaults.standard.set(newValue, forKey: "UserDefaultsHelper.isChangeLanguage")}
    }
    //Сохранение Int?
    open class var AccountLength: Int?{
        get{return UserDefaults.standard.integer(forKey: "UserDefaultsHelper.AccountLength")}
        set{UserDefaults.standard.set(newValue, forKey: "UserDefaultsHelper.AccountLength")}
    }
    // Сохранение String?
    open class var currentUserID: String?{
        get{return UserDefaults.standard.string(forKey: "UserDefaultsHelper.currentUserID")}
        set{UserDefaults.standard.set(newValue, forKey: "UserDefaultsHelper.currentUserID")}
    }
    
//    open class var news:[News]?{
//        get{
//            if let json = UserDefaults.standard.string(forKey: "UserDefaultsHelper.news"){
//                let news = Mapper<News>().mapArray(JSONString: json)
//                return news
//            } else {
//                return nil
//            }
//        }
//        set{
//            if let newValue = newValue{
//                UserDefaults.standard.set(newValue.toJSONString(), forKey: "UserDefaultsHelper.news")
//            } else {
//                UserDefaults.standard.set(nil, forKey: "UserDefaultsHelper.news")
//            }
//        }
//    }
    
}
