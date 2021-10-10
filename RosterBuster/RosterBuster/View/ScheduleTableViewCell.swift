//
//  ScheduleTableViewCell.swift
//  ScheduleTableViewCell
//
//  Created by Rahul on 10/10/21.
//

import UIKit

class ScheduleTableViewCell: UITableViewCell {

    @IBOutlet weak var flightStateImageView: UIImageView!
    @IBOutlet weak var departureDestinationLabel: UILabel!
    @IBOutlet weak var dutyCodeLabel: UILabel!
    @IBOutlet weak var matchCrewLabel: UILabel!
    @IBOutlet weak var flightTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(with scheduleVM: ScheduleCellVM?) {
        guard let _scheduleVM = scheduleVM else { return }
        
        self.departureDestinationLabel.text = _scheduleVM.place
        self.flightTimeLabel.text = _scheduleVM.flightTiming
        self.dutyCodeLabel.text = _scheduleVM.dutyType
        
        flightStateImageView.image = UIImage(named: _scheduleVM.flightImage)
        
        matchCrewLabel.isHidden = _scheduleVM.isMatchCrewHidden
        flightTimeLabel.isHidden = _scheduleVM.isflightTimeHidden
    }
    
}
