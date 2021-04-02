//
//  LocationDetailViewController.swift
//  Mobiquity Test
//
//  Created by Ram on 01/04/21.
//

import UIKit

class LocDetailViewController: UIViewController {
   
    @IBOutlet weak var listTable: UITableView!
    let pref = CoredataLayer().getPreference()
    var listModel = [LocationDetailViewModel]()
    var getLocData = Location()

    override func viewDidLoad() {
        super.viewDidLoad()

        listTable.register(UINib.init (nibName: ListTableCell.nibName, bundle: nil), forCellReuseIdentifier: ListTableCell.reuseIdentifier)
        
        
        
        self.listTable.tableFooterView = UIView(frame: .zero)

        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.hideTabBar()
        DispatchQueue.main.async {
            self.loadData()
        }
    }
    func loadData() {
        if pref.metric_data {
            LocationDataClass().getMultipleLocationData(name :getLocData.loc_name ?? "" ,lat : getLocData.lat,lon : getLocData.lon) { [self] (status, result) in
                if(status == 1){
                    
                    listModel = result!
                    DispatchQueue.main.async {
                        listTable.reloadData()
                    }
                    
                }
            }
            
            
        }else{
            LocationDataClass().getSingleLocationData(name :getLocData.loc_name ?? "",lat : getLocData.lat,lon : getLocData.lon) { [self] (status, result) in
                if(status == 1){
                    listModel.append(result!)
                    DispatchQueue.main.async {
                        listTable.reloadData()
                    }
                }
            }
        }
    }

    @IBAction func clickOnDeleteBtn(_ sender: Any) {
        CoredataLayer().deleteLocation(locId: getLocData.loc_id!)
        SystemAlert().basicNonActionAlert(withTitle: "", message: "Location deleted successfully", alert: .okAlert)
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension LocDetailViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableCell.reuseIdentifier, for: indexPath) as! ListTableCell
        cell.locModel = listModel[indexPath.row]
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
