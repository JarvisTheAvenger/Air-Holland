//
//  ScheduleDetailsVC.swift
//  ScheduleDetailsVC
//
//  Created by Rahul on 10/10/21.
//

import UIKit

class ScheduleDetailsVC: UIViewController {
    @IBOutlet weak var dutyLabel: UILabel!
    @IBOutlet weak var aircraftTypeLabel: UILabel!
    @IBOutlet weak var flightAttendantLabel: UILabel!
    @IBOutlet weak var firstOfficerLabel: UILabel!
    @IBOutlet weak var captainNameLabel: UILabel!
    @IBOutlet weak var flightTimeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    
    @IBOutlet weak var flightImageView: UIImageView!
    
    var scheduleCellVM: ScheduleCellVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        dutyLabel.text = scheduleCellVM.dutyType
        
        captainNameLabel.text = scheduleCellVM.captain
        firstOfficerLabel.text = scheduleCellVM.firstOfficer
        flightAttendantLabel.text = scheduleCellVM.flightAttendant
        
        aircraftTypeLabel.text = scheduleCellVM.aircraftType
        
        flightTimeLabel.text = scheduleCellVM.flightTiming
        dateLabel.text = scheduleCellVM.date
        
        flightImageView.image = UIImage(named: scheduleCellVM.flightImage)
        sourceLabel.text = scheduleCellVM.source
        destinationLabel.text = scheduleCellVM.destination
    }
    
}
