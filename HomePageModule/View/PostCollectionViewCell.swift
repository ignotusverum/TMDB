//
//  PostCollectionViewCell.swift
//  moVimento
//
//  Created by Giuseppe Lanza on 07/09/2019.
//  Copyright © 2019 MERLin Tech. All rights reserved.
//

import UIKit
import Kingfisher

class PostCollectionViewCell: UICollectionViewCell {
    static var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM yyyy"
        return formatter
    }()
    
    static var prototypeCell: PostCollectionViewCell = {
        let prototype = Bundle(for: PostCollectionViewCell.self)
            .loadNibNamed("PostCollectionViewCell", owner: nil, options: nil)![0] as! PostCollectionViewCell
        prototype.isPrototype = true
        return prototype
    }()
    
    var isPrototype = false
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var excerptLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var voteLabel: UILabel!
    
    func setup(show: ShortTVShow) {
        titleLabel.text = show.title
        excerptLabel.text = show.overview
        releaseDateLabel.text = show.date.map {
            PostCollectionViewCell.dateFormatter.string(from: $0)
        }
        voteLabel.text = "\(show.averageVote)"
        
        guard !isPrototype else { return }
        let size = imageView.frame.size
        imageView.kf.setImage(with: show.posterURL(forWidth: Int(size.width)),
                              placeholder: RandomGradient
                                .image(withSize: imageView.frame.size / 4))
    }
    
    func applyTheme() {
        backgroundColor = .color(forPalette: .white)
        
        imageView.backgroundColor = UIColor.color(forPalette: .gray).withAlphaComponent(0.1)
        
        titleLabel.applyLabelStyle(.headline(attribute: .sBold))
        titleLabel.textColor = .color(forPalette: .primary)
        
        excerptLabel.applyLabelStyle(.body(attribute: .regular))
        excerptLabel.textColor = .color(forPalette: .gray)
        
        releaseDateLabel.applyLabelStyle(.caption(attribute: .bold))
        releaseDateLabel.textColor = .color(forPalette: .accent)
        
        voteLabel.applyLabelStyle(.caption(attribute: .regular))
        voteLabel.textColor = .color(forPalette: .gray)
        
        layer.masksToBounds = false
        
        layer.borderColor = UIColor.color(forPalette: .gray).withAlphaComponent(0.2).cgColor
        layer.borderWidth = 0.5
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.1
    }
}
