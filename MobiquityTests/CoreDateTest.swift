
import XCTest
@testable import Mobiquity

class CoreDateTest: XCTestCase {

    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {

        CoredataLayer().deleteAllLocations()
    }
    
    func getAllLocations() -> [Location]{
        let locations = CoredataLayer().getLocations()
        return locations;
    }
    
    func testCompleteDelete() throws {
        CoredataLayer().deleteAllLocations()
        XCTAssertTrue(self.getAllLocations().count == 0)
    }
    
    func testInsert() throws{
        let testModel = LocationAddModel.init(locationName: "MyPlace", fav: false, lat: 12.12, lon: 11.11, loc_id: "1")
        CoredataLayer().insertLocation(locObject: .init(locData: testModel))
        XCTAssertTrue(self.getAllLocations().count == 1)
    }

    func testFavorite() throws{
        let testModel = LocationAddModel.init(locationName: "MyPlace", fav: false, lat: 12.12, lon: 11.11, loc_id: "1")
        let testModel1 = LocationAddModel.init(locationName: "MyPlace2", fav: true, lat: 12.12, lon: 11.11, loc_id: "2")

        CoredataLayer().insertLocation(locObject: .init(locData: testModel))
        CoredataLayer().insertLocation(locObject: .init(locData: testModel1))

        let locations:[Location] = self.getAllLocations();
        XCTAssertTrue(locations.count == 2)
        XCTAssertTrue(!locations[0].fav)
        XCTAssertTrue(locations[1].fav)
    }
    
    func testDeleteLcoation() throws{
        let testModel = LocationAddModel.init(locationName: "MyPlace", fav: false, lat: 12.12, lon: 11.11, loc_id: "1")
        CoredataLayer().insertLocation(locObject: .init(locData: testModel))
        XCTAssertTrue(self.getAllLocations().count == 1)
        CoredataLayer().deleteLocation(locId: "1")
        XCTAssertTrue(self.getAllLocations().count == 0)
    
    }
    
    func testPreferenceData() throws{
        CoredataLayer().updatePreference(value: true, tag: 0)
        CoredataLayer().updatePreference(value: false, tag: 1)

        let preferences = CoredataLayer().getPreference()
        XCTAssertTrue(preferences.in_cent)
        XCTAssertTrue(!preferences.metric_data)
        
        CoredataLayer().updatePreference(value: false, tag: 0)
        CoredataLayer().updatePreference(value: true, tag: 1)
        XCTAssertTrue(!preferences.in_cent)
        XCTAssertTrue(preferences.metric_data)
    }
    
}
