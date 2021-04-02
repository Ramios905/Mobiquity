//
//  HomeViewController.swift
//  Mobiquity Test
//
//  Created by Ram on 01/04/21.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var locCollectionVW: UICollectionView!
    var allLocs = [Location]()
    var locModelObjects = [LocationAddViewModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNib()
        self.title = StrConstant.homeTitle
      
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.showTabBar()
        reloadData()
    }
    func registerNib() {
        let nib = UINib(nibName: LocCollectionViewCell.nibName, bundle: nil)
        locCollectionVW?.register(nib, forCellWithReuseIdentifier: LocCollectionViewCell.reuseIdentifier)
    }
    
    func reloadData() {
        locModelObjects.removeAll()
        allLocs = CoredataLayer().getLocations()
        _ = allLocs.map { (locObject) in
            locModelObjects.append(.init(locData: .init(locationName: locObject.loc_name ?? "no name", fav: locObject.fav, lat: locObject.lat, lon: locObject.lon, loc_id: locObject.loc_id!)))
          }
        locCollectionVW.reloadData()
    }

    @IBAction func clickOnAddLocation(_ sender: Any) {
        if(MUtility().checkLocationIsEnabled()){
            self.pushToController(with: .addLocVC, inStoryboard: .main)
        }
        
    }
    
    @objc func selectFavBtn(_ sender : UIButton) {
        
        let deviceObject = allLocs[sender.tag]
        CoredataLayer().insertLocation(locObject: .init(locData: .init(locationName: deviceObject.loc_name ?? "", fav: deviceObject.fav == true ? false : true, lat: (deviceObject.lat), lon: (deviceObject.lon), loc_id: (deviceObject.loc_id)!)))
        reloadData()
    }
    
}

extension HomeViewController : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        allLocs.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LocCollectionViewCell.reuseIdentifier,
                                                         for: indexPath) as? LocCollectionViewCell {
            cell.locModel = locModelObjects[indexPath.item]
            cell.favSwt.addTarget(self, action: #selector(selectFavBtn(_:)), for: .touchUpInside)
            cell.favSwt.tag = indexPath.row
    
            return cell
        }
        return UICollectionViewCell()


    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let width  = (view.frame.width-20)/2.2
        if allLocs.count == 1 {
            return CGSize(width: view.frame.width-20, height: width)
        }else{
            return CGSize(width: width, height: width)
            
        }
          
        }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        
        return  UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
             return 10;
        }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 10;
        }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nextVC = self.getController(fromStoryboard: .main, with: .detailLocVC) as! LocDetailViewController
        nextVC.getLocData = allLocs[indexPath.row]
        self.navigationController?.pushViewController(nextVC, animated: true)
    }

}
