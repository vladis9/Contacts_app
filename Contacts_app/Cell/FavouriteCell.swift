//
//  FavouriteCell.swift
//  Contacts_app
//
//  Created by Vlad Zinevich on 11.08.2021.
//

import UIKit

class FavouriteCell: UICollectionViewCell, SelfConfiguringCell {
    
    static var reuseId: String = "FavouriteCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .blue
    }
    
    func configure(with user: User) {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
