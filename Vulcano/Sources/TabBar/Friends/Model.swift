//
//  Model.swift
//  Vulcano
//
//  Created by Bema on 1/6/24.
//

import Foundation
import UIKit

struct Friend: Hashable {
    var name: String
    var date: String
}

extension Friend {
    static var friends: [[Friend]] = [
        [Friend(name: "Ed Ross", date: "13.08.1990")],
        [Friend(name: "Courtney Henry", date: "23.09.1987")],
        [Friend(name: "Wade Warren", date: "11.05.2000")],
        [Friend(name: "Albert Flores", date: "12.07.1999")]
    ]
}
