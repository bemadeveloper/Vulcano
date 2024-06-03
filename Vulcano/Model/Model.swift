//
//  Model.swift
//  Vulcano
//
//  Created by Bema on 29/5/24.
//

import Foundation

struct Model: Encodable {
    let name: String
    let login: String
    let password: String
    let country: String
    let phone: Int
    let userToken: String
}
