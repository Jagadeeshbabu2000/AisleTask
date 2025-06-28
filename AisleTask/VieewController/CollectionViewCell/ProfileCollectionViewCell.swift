//
//  ProfileCollectionViewCell.swift
//  AisleTask
//
//  Created by K V Jagadeesh babu on 28/06/25.
//

import UIKit

import UIKit

class ProfileCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ProfileCollectionViewCell"
    
    var backgroundImage: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleToFill
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = 15
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    var nameAgeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Tap to review 50+ notes"
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)

        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(backgroundImage)
        contentView.addSubview(nameAgeLabel)
        contentView.addSubview(subtitleLabel)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            backgroundImage.widthAnchor.constraint(equalToConstant: 280),
            backgroundImage.heightAnchor.constraint(equalToConstant: 280),
            
            nameAgeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            nameAgeLabel.bottomAnchor.constraint(equalTo: subtitleLabel.topAnchor, constant: -4),
            
            subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            subtitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    func configure(with image: UIImage?, name: String, age: Int) {
        backgroundImage.image = image
        nameAgeLabel.text = "\(name), \(age)"
    }
}

