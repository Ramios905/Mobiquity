//
//  SystemAlert.swift
//  Mobiquity Test
//
//  Created by Ram on 01/04/21.
//

import Foundation
import UIKit
enum SystemAlertType : String {
    case okAlert = "Ok"
    case cancelAlert = "Cancel"
}

var alertController : UIAlertController?
public class SystemAlert {
    func basicNonActionAlert(withTitle title: String, message : String, alert:SystemAlertType){
        
        DispatchQueue.main.async {
            alertController?.dismiss(animated: true, completion: nil)
            alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let OKAction = UIAlertAction(title: alert.rawValue, style: .default) { action in
            }
            OKAction.setValue(UIColor.systemGreen, forKey: "titleTextColor")
            alertController!.addAction(OKAction)
           
            if var topController = UIApplication.shared.keyWindow?.rootViewController {
                while let presentedViewController = topController.presentedViewController {
                    topController = presentedViewController
                }
                topController.present(alertController!, animated: true, completion: nil)
            }
            
        }
        
    }
    
    
    func removeAlert(){
        alertController?.dismiss(animated: true, completion: nil)
    }
    
    

    
}


