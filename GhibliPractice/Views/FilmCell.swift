//
//  FilmCell.swift
//  GhibliPractice
//
//  Created by C4Q on 10/2/19.
//  Copyright © 2019 Iram Fattah. All rights reserved.
//

import UIKit

protocol FilmCellDelegate: AnyObject {
    func actionSheet(tag: Int)
}

class FilmCell: UITableViewCell {
  
    @IBOutlet weak var filmImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var optionsButton: UIButton!
    
    weak var delegate: FilmCellDelegate?
 
    @IBAction func optionsButtonPressed(_ sender: UIButton) {
        delegate?.actionSheet(tag: sender.tag)
        
    }
    
}
