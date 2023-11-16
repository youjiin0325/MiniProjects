//
//  MovieTableViewCell.swift
//  MoviesInfo
//
//  Created by YOU on 11/16/23.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet var movieTitle: UILabel!
    @IBOutlet var movieImage: UIImageView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
