//
//  SelfConfiguringCell.swift
//  Contacts_app
//
//  Created by Vlad Zinevich on 11.08.2021.
//

import UIKit

protocol SelfConfiguringCell {
    static var reuseId: String { get }
    func configure(with user: User)
}
