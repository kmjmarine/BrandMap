//
//  Product.swift
//  BrandMap
//
//  Created by kmjmarine on 2022/02/25.
//

import Foundation

struct Product: Decodable {
    let seq: Int?
    let line, channel, nameko, nameen, spec, capacity, launchdate, type, imageurl, subimageurls: String?
}


