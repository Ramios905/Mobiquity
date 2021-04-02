//
//  LocationDetailviewModel.swift
//  Mobiquity Test
//
//  Created by Ram on 01/04/21.
//

import Foundation

struct LocationDetailViewModel {
    var locationName : String
    var humidity : String
    var temp : String
    var cloud : String
    var wind : String
    var icon : String
    var date : Int
    var des : String
    
    // Dependency Injection
    init(locData : LocationDetailModel) {
        self.locationName = locData.locationName
        self.humidity = locData.humidity
        self.temp = locData.temp
        self.cloud = locData.cloud
        self.wind = locData.wind
        self.icon = locData.icon
        self.date = locData.date
        self.des = locData.des
    }
}
