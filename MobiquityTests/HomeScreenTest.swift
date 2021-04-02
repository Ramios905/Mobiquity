//
//  HomeScreenTest.swift
//  MobiquityTests
//
//  Created by Ram on 02/04/21.
//

import XCTest
@testable import Mobiquity

class HomeScreenTest: XCTestCase {
    var viewController: HomeViewController!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        viewController = storyboard.instantiateViewController(identifier: "HomeVC") as? HomeViewController
        
        XCTAssertNotNil(viewController?.view)
        
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewController = nil;
        CoredataLayer().deleteAllLocations()
    }
    
    func testInitialData() throws {
        CoredataLayer().deleteAllLocations()
        let testModel = LocationAddModel.init(locationName: "MyPlace", fav: false, lat: 12.12, lon: 11.11, loc_id: "1")
        CoredataLayer().insertLocation(locObject: .init(locData: testModel))
        
        viewController.reloadData()
        XCTAssertTrue(viewController.allLocs.count == 1);
        XCTAssertTrue(!viewController.allLocs[0].fav);
        XCTAssertTrue(viewController.allLocs[0].loc_name == "MyPlace");
        XCTAssertTrue(viewController.allLocs[0].lat == 12.12);
        XCTAssertTrue(viewController.allLocs[0].lon == 11.11);
    }
    
    
    func testCollectionViewIsNotNilAfterViewDidLoad() {
        
        XCTAssertNotNil(viewController.locCollectionVW)
    }
    
    
    func testShouldSetCollectionViewDataSource() {
        
        XCTAssertNotNil(viewController.locCollectionVW.dataSource)
    }
    
    func testConformsToCollectionViewDataSource() {
        
        XCTAssert(viewController.conforms(to: UICollectionViewDataSource.self))
        XCTAssertTrue(viewController.responds(to: #selector(viewController.collectionView(_:numberOfItemsInSection:))))
        XCTAssertTrue(viewController.responds(to:#selector(viewController.collectionView(_:cellForItemAt:))))
    }
    
    func testShouldSetCollectionViewDelegate() {
        
        XCTAssertNotNil(viewController.locCollectionVW.delegate)
    }
    
    func testConformsToCollectionViewDelegate() {
        
        XCTAssert(viewController.conforms(to: UICollectionViewDelegate.self))
        XCTAssertTrue(viewController.responds(to:#selector(viewController.collectionView(_:didSelectItemAt:))))
    }
    
    func testSUT_ConformsToCollectionViewDelegateFlowLayout () {
        
        XCTAssert(viewController.conforms(to:UICollectionViewDelegateFlowLayout.self))
        XCTAssertTrue(viewController.responds(to:#selector(viewController.collectionView(_:layout:sizeForItemAt:))))
        XCTAssertTrue(viewController.responds(to:#selector(viewController.collectionView(_:layout:insetForSectionAt:))))
        XCTAssertTrue(viewController.responds(to:#selector(viewController.collectionView(_:layout:minimumLineSpacingForSectionAt:))))
        XCTAssertTrue(viewController.responds(to:#selector(viewController.collectionView(_:layout:minimumInteritemSpacingForSectionAt:))))
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
