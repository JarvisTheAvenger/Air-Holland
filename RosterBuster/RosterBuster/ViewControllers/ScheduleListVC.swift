//
//  ViewController.swift
//  RosterBuster
//
//  Created by Rahul on 05/10/21.
//

import UIKit

class ScheduleListVC: UIViewController {
    @IBOutlet weak var schedulesTableView: UITableView!
    
    private var scheduleViewModel: ScheduleVM = .init(ScheduleAPIProvider())
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self,
                                 action: #selector(handleRefresh),
                                 for: .valueChanged)
        refreshControl.tintColor = UIColor.red
        return refreshControl
    }()
    
    //MARK: - ViewController's Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        getSchedules()

    }
    
    //MARK: - Private methods
    private func getSchedules() {
        scheduleViewModel.getSchedules { _ in
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
                self.schedulesTableView.reloadData()
            }
        }
    }
    
    @objc
    private func handleRefresh() {
        getSchedules()
    }
    
    private func setup() {
        self.schedulesTableView.addSubview(self.refreshControl)

        let nib = UINib(nibName: "ScheduleTableViewCell", bundle: nil)
        schedulesTableView.register(nib, forCellReuseIdentifier: "ScheduleTableViewCell")
    }
    
    //MARK: - Segue Related...
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as? ScheduleDetailsVC
        vc?.scheduleCellVM = sender as? ScheduleCellVM
    }

}

//MARK: - UITableView Delegate, DataSource Methods
extension ScheduleListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = scheduleViewModel.schedules[section].keys.first!
        return scheduleViewModel.schedules[section][key]?.count ?? 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        scheduleViewModel.schedules.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleTableViewCell") as? ScheduleTableViewCell else  {
            return UITableViewCell()
        }
        
        let key = scheduleViewModel.schedules[indexPath.section].keys.first!
        let cellVM = scheduleViewModel.schedules[indexPath.section][key]?[indexPath.row]
        cell.setupCell(with: cellVM)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 25))
        headerView.backgroundColor = .systemGray4
        
        let label = UILabel()
        label.frame = CGRect.init(x: 10,
                                  y: 4,
                                  width: headerView.frame.width-10,
                                  height: headerView.frame.height-10)
        
        label.text = scheduleViewModel.schedules[section].keys.first!
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        
        headerView.addSubview(label)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let key = scheduleViewModel.schedules[indexPath.section].keys.first!
        let cellVM = scheduleViewModel.schedules[indexPath.section][key]?[indexPath.row]
        performSegue(withIdentifier: "segueScheduleListToDetails", sender: cellVM)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
}
