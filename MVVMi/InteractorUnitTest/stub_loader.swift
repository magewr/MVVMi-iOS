import Foundation

class stub_loader {
    class func gwt(key: String) -> (String?, String?, String?, String?) {
        guard let path = Bundle.main.path(forResource: "interactor_stub", ofType: "plist") else {
            return (nil, nil, nil, nil)
        }
        
        guard let dict = NSDictionary(contentsOfFile: path) as? [String : [String : Any]] else {
            return (nil, nil, nil, nil)
        }
        
        guard let testDict = dict[key] else {
            return (nil, nil, nil, nil)
        }

        guard let given = testDict["given"] as? String else {
            return (nil, nil, nil, nil)
        }
        
        guard let when = testDict["when"] as? String else {
            return (nil, nil, nil, nil)
        }

        guard let then = testDict["then"] as? String else {
            return (nil, nil, nil, nil)
        }

        guard let messageKey = testDict["messageKey"] as? String else {
            return (nil, nil, nil, nil)
        }

        return (given, when, then, messageKey)
    }
}
