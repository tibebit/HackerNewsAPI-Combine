//
//  UITableViewCell+Extension.swift
//  HackerNews(UIKit&Combine)
//
//  Created by Fabio Tiberio on 03/03/22.
//

import UIKit

extension UITableViewCell {
    func configure(title: String, author: String) -> UIContentConfiguration {
        var customConfiguration = defaultContentConfiguration()
        customConfiguration.text = title
        customConfiguration.textProperties.font = .preferredFont(forTextStyle: .headline)
        customConfiguration.textProperties.color = .systemOrange
        customConfiguration.textProperties.lineBreakMode = .byTruncatingTail
        customConfiguration.textProperties.numberOfLines = 1
        customConfiguration.secondaryTextProperties.font = .preferredFont(forTextStyle: .footnote)
        customConfiguration.secondaryText = "by \(author)"
        return customConfiguration
    }
}
