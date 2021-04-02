//
//  SettingsViewController.swift
//  Mobiquity Test
//
//  Created by Ram on 01/04/21.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var settingTable: UITableView!
    var hdrText = ["Temperature","Weather Info","Reset Locations"]
    var values = [String]()
    var prefe = CoredataLayer().getPreference()
    override func viewDidLoad() {
        super.viewDidLoad()
        settingTable.register(UINib.init (nibName: SettingTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: SettingTableViewCell.reuseIdentifier)
        self.settingTable.tableFooterView = UIView(frame: .zero)
        updateValue()
        self.title = StrConstant.settingsTitle
        
    
    }
    func updateValue() {
        values.removeAll()
        values.append(prefe.in_cent == true ? "°C" : "°F")
        values.append(prefe.metric_data == true ? "Forecast" : "Single data")
        values.append("")
        settingTable.reloadData()
    }
    @objc func btnClicked(_ sender : UIButton){
        switch sender.tag {
        case 0:
            CoredataLayer().updatePreference(value: prefe.in_cent == true ? false : true, tag: 0)
            break
        case 1:
            CoredataLayer().updatePreference(value: prefe.metric_data == false ? true : false, tag: 1)
            break
        default:
            break
        }
        
        updateValue()
    }

}

extension SettingsViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hdrText.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.reuseIdentifier, for: indexPath) as! SettingTableViewCell
        cell.selectionStyle = .none
        cell.hdrLbl.text = hdrText[indexPath.row]
        cell.btn.setTitle("\(values[indexPath.row])", for: .normal)
        cell.btn.tag = indexPath.row
        cell.btn.addTarget(self, action: #selector(btnClicked(_:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 2 {
            CoredataLayer().deleteAllLocations()
            SystemAlert().basicNonActionAlert(withTitle: "", message: "All locations reset successfully", alert: .okAlert)
        }
       
        
    }
    
}
