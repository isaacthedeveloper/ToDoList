//
//  ToDoCell.swift
//  ToDoList
//
//  Created by Isaac Ballas on 12/20/18.
//  Copyright © 2018 Isaac Ballas. All rights reserved.
//

import UIKit
@objc protocol ToDoCellDelegate: class {
    func checkMarkTapped(sender: ToDoCell)
}
class ToDoCell: UITableViewCell {
    @IBOutlet weak var isComplete: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBAction func completeButtonTapped(_ sender: UIButton) {
        // Inform the delegate that the button has been tapped.
        delegate?.checkMarkTapped(sender: self)
    }
    var delegate: ToDoCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
