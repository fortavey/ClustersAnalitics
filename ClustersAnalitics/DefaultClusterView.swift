//
//  DefaultClusterView.swift
//  ClustersAnalitics
//
//  Created by mb1 on 04.05.2026.
//

import SwiftUI

struct DefaultClusterView: View {
    var cluster: Int
    var defaultAppsList: [BrendModel]
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Кластер \(cluster)")
            ForEach(defaultAppsList, id: \.self){brend in
                Button(action: {
                    copyText(brendName: brend.name)
                }) {
                    Text(brend.name)
                        .frame(width: 150, height: 20, alignment: .init(horizontal: .leading, vertical: .center))
                }
                .buttonStyle(.borderedProminent)
            }
            Text("Итого прил - \(defaultAppsList.count)")
        }
    }
    
    func copyText(brendName: String){
        let pasteboard = NSPasteboard.general
        pasteboard.declareTypes([NSPasteboard.PasteboardType.string], owner: nil)
        pasteboard.setString(brendName, forType: .string)
    }
    
    
}
