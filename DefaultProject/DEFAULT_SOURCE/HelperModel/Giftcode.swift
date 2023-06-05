
import Foundation
import FirebaseDatabase
import SwiftUI

class GiftCode{
    static var shared = GiftCode()
    @AppStorage("ACTIVE_TOOL") var ACTIVE_TOOL = false
    /// Hướng dẫn mã code
    //Type: 0 -> Dùng 1 lần
    //      1 -> Dùng vô số lần
    //      2 -> Active Download
    
    //timeExpired:  Đơn vị: timestamp. lấy ở đây https://www.epochconverter.com
    //              0 -> Giới hạn Premium
    //              1 -> Hạn sử dụng của code
    //timeDuration: Chỉ có ở loại 1 => Đơn vị là ngày
    //isPublic: Chỉ có ở loại code 2: Active Downlaod. nếu là công khai thì bất cứ ai cũng có thể dùng
    
    func check(_ code: String, completion: @escaping ((Bool, String) -> Void)){
        let database = Database.database().reference().child(CONSTANT.SHARED.URL.PATH_GIFTCODE).child(code)
        database.getData { error, data in
            guard let data = data else {return}
            if data.exists() {
                if let object = data.value as? Dictionary<String,Any>{
                    let typeCode = object["type"] as? Int
                    if typeCode == 0{
                        if (object["isActive"] as? Bool) == false{
                            let time = (object["timeExpired"] as? Int) ?? 0
                            UserDefaults.standard.setValue(time, forKey: CONSTANT.EXPIRED_PREMIUM)
                            database.setValue(
                                [
                                    "isActive": true,
                                    "timeExpired": time,
                                    "type": 0
                                ]
                            )
                            let date = Date(timeIntervalSince1970: TimeInterval(time)).toString(format: "MMM dd, YYYY (hh:mm a)")
                            completion(true, "Successfull!\nTime: \(date)")
                        }
                        else{
                            completion(false, "Code is used!")
                        }
                    }else if typeCode == 1{
                        let timeExpired = (object["timeExpired"] as? Int) ?? 0
                        let timeDuration = (object["timeDuration"] as? Int) ?? 0
                        
                        if TimeInterval(timeExpired) < Date().timeIntervalSince1970{
                            completion(false, "The code has expired!")
                        }else{
                            let time = Int(Date().timeIntervalSince1970) + timeDuration * 86400
                            UserDefaults.standard.setValue(time, forKey: CONSTANT.EXPIRED_PREMIUM)
                            let date = Date(timeIntervalSince1970: TimeInterval(time)).toString(format: "MMM dd, YYYY (hh:mm a)")
                            completion(true, "Successfull!\nTime: \(date)")
                        }
                    }else if typeCode == 2{
                        if let isActiveTool = object["isActive"] as? Bool, isActiveTool == false{
                            GiftCode.shared.ACTIVE_TOOL = true
                            if let isPublicCode = object["isPublic"] as? Bool, isPublicCode == false{
                                database.setValue(
                                    [
                                        "isActive": true,
                                        "isPublic": false,
                                        "type": 2
                                    ]
                                )
                            }
                            completion(true, "ACTIVE DOWNLOAD SUCCESSFULL!")
                        }
                        else{
                            completion(false, "Code is used!")
                        }
                    }
                }
            }
            else{
                completion(false, "Code not found!")
            }
        }
    }
    
    func show(){
        let alert = MyAlert(title: "Input your GiftCode", message: nil, preferredStyle: .alert)
        alert.addTextField() { textField in
            textField.placeholder = "Code"
        }
        let ok = UIAlertAction(title: "OK", style: .cancel) { _ in
            guard let code = alert.textFields?.first?.text else {return}
            if code == "" {
                return
            }
            GiftCode.shared.check(code) { bool, status in
                LocalNotification.shared.message(status)
                User.shared.getUser()
            }
        }
        alert.addAction(ok)
        ok.setValue(UIColor(Color.accentColor), forKey: "titleTextColor")
        MyAlert().showAlert(alert: alert)
    }
}
