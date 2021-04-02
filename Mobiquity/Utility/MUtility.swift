//
//  MUtility.swift
//  Mobiquity Test
//
//  Created by Ram on 01/04/21.
//

import Foundation
import CoreLocation

class MUtility : NSObject{
    
    func checkLocationIsEnabled() -> Bool {
        
        let status = CLLocationManager.authorizationStatus()
        if status == .notDetermined || status == .denied{
            SystemAlert().basicNonActionAlert(withTitle: "", message: "Please enable location service from your settings.", alert: .cancelAlert)
           return false
        } else {
            return true
        }
    }
    func convertToDateWithMilliseconds(seconds:Int) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM, YYYY hh:mm a"
        let date = Date(timeIntervalSince1970: (TimeInterval(seconds)))
        let convertedDateStr = formatter.string(from: date)
        return convertedDateStr
    }
    func converTemp(value : String) -> String {
        
        let pref = CoredataLayer().getPreference()
        var temp = ""
        var suffixVal = ""
        
        
        if pref.in_cent == true &&  !pref.metric_data {
            suffixVal = "°C"
            temp = String.init(format: "%.1f", Float.init(((Double.init(value ) ?? 0) - 273.15)))
        }
        else if pref.in_cent == false &&  !pref.metric_data {
            suffixVal = "°F"
            temp = String.init(format: "%.1f", Float.init(9/5 * ((Double.init(value)!) - 273) + 32))
            
        }
        else if pref.in_cent == false && pref.metric_data {
            suffixVal = "°F"
            temp = String.init(format: "%.1f", Float.init((Float(value)! * 9.0) / 5.0 + 32.0))
            
        }else{
            suffixVal = "°C"
            temp = value
        }
        
        return temp + suffixVal
    }
    

}
