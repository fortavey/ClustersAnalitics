//
//  BrendModel.swift
//  ClustersAnalitics
//
//  Created by mb1 on 04.05.2026.
//

import Foundation

struct BrendModel: Identifiable, Hashable {
    var id: String
    var name: String
    var cluster: Int
    var isFavorite: Bool
    var countries: [String]
    var analiticsArray: [String]
}
