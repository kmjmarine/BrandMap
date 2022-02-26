//
//  Product.swift
//  BrandMap
//
//  Created by kmjmarine on 2022/02/25.
//

import Foundation

struct Product: Decodable {
    let seq: Int?
    let nameko, nameen, spec, prodsize, boxsize, capacity, launchdate, imageurl: String?
}
