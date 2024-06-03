//
//  CustomSettingModel.swift
//  Vulcano
//
//  Created by Bema on 1/6/24.
//

import Foundation
import UIKit

struct CustomSettingModel: Hashable {
    let type: NameOfSettings
}

enum NameOfSettings: String {
    case usagePolicy = "Usage Policy"
    case shareApp = "Share App"
    case rateUs = "Rate Us"
}

extension NameOfSettings {
    var image: UIImage {
        let imageName: String
        switch self {
        case .usagePolicy:
            imageName = "list.clipboard.fill"
        case .shareApp:
            imageName = "arrowshape.turn.up.right.fill"
        case .rateUs:
            imageName = "star.fill"
        }
        return UIImage(systemName: imageName) ?? UIImage()
    }
    
    var color: UIColor {
        let color: UIColor
        switch self {
        case .usagePolicy:
            color = .systemRed
        case .shareApp:
            color = .systemRed
        case .rateUs:
            color = .systemRed
        }
        return color
    }
}
