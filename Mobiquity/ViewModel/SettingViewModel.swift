//
//  SettingViewModel.swift
//  Mobiquity Test
//
//  Created by Ram on 01/04/21.
//

import Foundation
struct SettingViewModel {
    var tempIn : String
    var weatherInfo : String
    
    init(data : SettingModel) {
        self.tempIn = data.tempIn
        self.weatherInfo = data.weatherInfo
    }
    
}
