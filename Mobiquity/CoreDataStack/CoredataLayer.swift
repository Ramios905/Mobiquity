//
//  CoredataLayer.swift
//  Mobiquity Test
//
//  Created by Ram on 01/04/21.
//

import Foundation
import CoreData

class CoredataLayer {
    func insertLocation(locObject : LocationAddViewModel) {
        let predicate = NSPredicate(format: "SELF.%@ == %@",KeyConstant.loc_id,locObject.loc_id)
        let locObj: Location = PersistenceManager.shared.fetchData(Location.self, predicate).last ?? Location(context: PersistenceManager.shared.context)
        locObj.loc_name = locObject.locationName
        locObj.lat = locObject.lat
        locObj.lon = locObject.lon
        locObj.fav = locObject.fav
        locObj.loc_id = locObject.loc_id
        PersistenceManager.shared.savePesistenceContext()
    }
    
    func getLocations(_ by : Bool? = nil) -> [Location] {
        if let fav = by {
            let predicate = NSPredicate(format: "SELF.%@ == %@",KeyConstant.fav,fav)
            return PersistenceManager.shared.fetchData(Location.self, predicate)
        }
        return PersistenceManager.shared.fetchData(Location.self, nil)
        
        
    }
    func getPreference() -> Preference {
        return PersistenceManager.shared.fetchData(Preference.self, nil).last ?? Preference(context: PersistenceManager.shared.context)
        
        
    }
    func updatePreference(value:Bool,tag : Int) {
        
        let preObj: Preference = PersistenceManager.shared.fetchData(Preference.self, nil).last ?? Preference(context: PersistenceManager.shared.context)
        if tag == 0 {
            preObj.in_cent = value
        }else{
            preObj.metric_data = value
        }
        
        PersistenceManager.shared.savePesistenceContext()
        
    }
    func deleteAllLocations() {
        PersistenceManager.shared.deleteRecords(Location.self)
    }
    func deleteLocation(locId : String) {
        let predicate = NSPredicate(format: "SELF.%@ == %@",KeyConstant.loc_id,locId)
        let locObject = PersistenceManager.shared.fetchData(Location.self, predicate).last ?? Location(context: PersistenceManager.shared.context)
        PersistenceManager.shared.deleteRecord(locObject)
    }
}
