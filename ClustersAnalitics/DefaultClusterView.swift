//
//  DefaultClusterView.swift
//  ClustersAnalitics
//
//  Created by mb1 on 04.05.2026.
//

import SwiftUI

struct DefaultClusterView: View {
    var cluster: Int
    var contentVM: ContentViewModel
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Кластер \(cluster)")
            ForEach(getSingleAppsList(), id: \.self){brend in
                Text(brend.name)
            }
        }
    }
    
    func getSingleAppsList() -> [BrendModel] {
        return contentVM.brendsList.filter{ $0.cluster == cluster && $0.isFavorite }
    }
}
