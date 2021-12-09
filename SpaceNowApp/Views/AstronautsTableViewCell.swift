//
//  AstronautsTableViewCell.swift
//  SpaceNowApp
//
//  Created by sonam taya on 7/12/21.
//

import UIKit
import Nuke

class AstronautsTableViewCell: UITableViewCell {

    // MARK: - Variables and Properties

    static var reuseIdentifier: String {
        String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelNationality: UILabel!
    @IBOutlet weak var imageviewProfile: UIImageView!

    func configureCell(with AstronautsData: Astronaut) {
        labelName.text = AstronautsData.name
        labelNationality.text = "Nationality: \(AstronautsData.nationality)"
        if let imageUrl = URL(string: AstronautsData.profile_image_thumbnail) {
            Nuke.loadImage(with: imageUrl, into: imageviewProfile)
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageviewProfile.layer.cornerRadius = 8
        selectionStyle = .none
        separatorInset =  UIEdgeInsets(top: 0, left: CGFloat.greatestFiniteMagnitude, bottom: 0, right: 0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
