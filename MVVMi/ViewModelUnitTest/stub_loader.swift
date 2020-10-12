//
//  stub_loader.swift
//  ViewModelUnitTests
//
//  Created by jinwoo.park on 2020/04/22.
//  Copyright © 2020 How To Marry. All rights reserved.
//

import Foundation

class stub_loader {
    class func gwt(key: String) -> Dictionary<String, String> {
        var resultDict = [String : String]()
        guard let path = Bundle.main.path(forResource: "viewmodel_stub", ofType: "plist") else {
            return resultDict
        }
        
        guard let dict = NSDictionary(contentsOfFile: path) as? [String : [String : Any]] else {
            return resultDict
        }
        
        guard let testDict = dict[key] else {
            return resultDict
        }

        if let given = testDict["given"] as? String {
            resultDict["given"] = given
        }
        
        if let when = testDict["when"] as? String {
            resultDict["when"] = when
        }
        
        if let youtubeThen = testDict["youtubeThen"] as? String {
            resultDict["youtubeThen"] = youtubeThen
        }
        
        if let tvThen = testDict["tvThen"] as? String {
            resultDict["tvThen"] = tvThen
        }

        if let then = testDict["then"] as? String {
            resultDict["then"] = then
        }

        if let messageKey = testDict["messageKey"] as? String {
            resultDict["messageKey"] = messageKey
        }

        return resultDict
    }
}
