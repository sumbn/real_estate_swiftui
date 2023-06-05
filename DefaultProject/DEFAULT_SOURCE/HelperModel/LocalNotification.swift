

import Foundation
import UserNotifications
import SwiftUI

//Toast Message
class LocalNotification: ObservableObject {
    static var shared = LocalNotification()
    
    func setLocalNotification(title: String, subtitle: String, body: String, when: Double, id: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.body = body
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: when, repeats: false)
        let request = UNNotificationRequest.init(identifier: id, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    func message(_ str: String){
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "PushMessage"), object: nil, userInfo: ["data": str])
        }
    }
    static func message(_ str: String){
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "PushMessage"), object: nil, userInfo: ["data": str])
        }
    }
}
