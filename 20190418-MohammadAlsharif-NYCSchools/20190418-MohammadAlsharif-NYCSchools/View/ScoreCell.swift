//
//  ScoreCell.swift
//  20190418-MohammadAlsharif-NYCSchools
//
//  Created by Mohammad on 18/04/19.
//  Copyright © 2019 MohammadAlsharif. All rights reserved.
//

import Foundation

import UIKit

class ScoreCell: UITableViewCell {
    
    @IBOutlet weak var schoolNameTitleLabel: UILabel!
    
    @IBOutlet weak var mathScoreLabel: UILabel!
    
    @IBOutlet weak var readingScoreLabel: UILabel!
    
    @IBOutlet weak var writingScoreLabel: UILabel!

    @IBOutlet weak var numberOfTestTakers: UILabel!
}
