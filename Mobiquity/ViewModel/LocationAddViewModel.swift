//
//  LocationAddViewModel.swift
//  Mobiquity Test
//
//  Created by Ram on 01/04/21.
//

import Foundation
import CoreLocation
struct LocationAddViewModel {
    var locationName : String
    var fav : Bool
    var lat : Float
    var lon : Float
    var loc_id : String
    
    // Dependency Injection
    init(locData : LocationAddModel) {
        self.locationName = locData.locationName
        self.fav = locData.fav
        self.lat = locData.lat
        self.lon = locData.lon
        self.loc_id = locData.loc_id
    }
}
class LocationDataClass {
    
    func getSingleLocationData(name : String,lat : Float, lon : Float ,completion : @escaping(Int,LocationDetailViewModel?)->()) {
    
        let cordinates : CLLocation = .init(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(lon))
        APIManager.sharedManager().getWeatherData(type: EndPointItem.getCurrentWeather, loc: cordinates, decodingType: SingleWether.self) { (result) in
            
            switch result{
            case .success(let resObj):
                
                completion(1,.init(locData: .init(locationName: name, humidity: "\(resObj.main?.humidity ?? 0)", temp: "\(resObj.main?.temp ?? 0)", cloud: "\(resObj.clouds?.all ?? 0)", wind: "\(resObj.wind?.speed ?? 0)", icon: "\((resObj.weather)?[0].icon ?? "")",date : resObj.dt ?? 0,des : "\((resObj.weather)?[0].weatherDescription ?? "")")))
                
               break
            default:
                completion(0,nil)
                break
                
            }
        }
        
    }
    func getMultipleLocationData(name : String,lat : Float, lon : Float ,completion : @escaping(Int,[LocationDetailViewModel]?)->()) {
        let cordinates : CLLocation = .init(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(lon))
        
        APIManager.sharedManager().getWeatherData(type: EndPointItem.getFiveDaysWeather, loc: cordinates, decodingType: MultipleWetherData.self) { (result) in
            
            switch result{
            case .success(let resObj):
                
                var sendObject = [LocationDetailViewModel]()
                
                _ = resObj.list!.map({ (listObject) in
                    sendObject.append(.init(locData:.init(locationName: name, humidity: "\(listObject.main?.humidity ?? 0)", temp: "\(listObject.main?.temp ?? 0)", cloud: "\(listObject.clouds?.all ?? 0)", wind: "\(listObject.wind?.speed ?? 0)", icon: "\((listObject.weather)?[0].icon ?? "")",date : listObject.dt ?? 0,des : "\((listObject.weather)?[0].weatherDescription ?? "")")))
                })
                completion(1,sendObject)
               break
            default:
                completion(0,nil)
                break
                
            }
        }
        
    }
    
}
