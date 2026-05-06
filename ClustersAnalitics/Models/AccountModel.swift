//
//  AccountModel.swift
//  ClustersAnalitics
//
//  Created by mb1 on 30.04.2026.
//

import Foundation

struct AccountModel: Identifiable, Hashable {
    var id: String
    var alias: String
    var cluster: Int
    var isBan: Bool?
    var appCounter: Int?
}
