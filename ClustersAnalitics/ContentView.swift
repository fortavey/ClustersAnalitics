//
//  ContentView.swift
//  ClustersAnalitics
//
//  Created by mb1 on 30.04.2026.
//

import SwiftUI

struct ContentView: View {
    @State private var contentVM: ContentViewModel = .init()
    @State private var numberOfClusters: Int = 10
    
    var body: some View {
        VStack {
            if contentVM.accountsList.isEmpty{
                Button("Сформировать"){
                    contentVM.getAccountsList()
                    contentVM.getAppsList()
                    contentVM.getBrendsList()
                }
            }else {
                VStack{
                    ScrollView{
                        ForEach(1...numberOfClusters, id: \.self) { cluster in
                            
                            HStack{
                                DefaultClusterView(cluster: cluster, contentVM: contentVM)
                                Spacer()
                            }
                            Divider()
                                .padding(.bottom, 10)
                        }
                    }
                    .padding(.horizontal, 20)
                    Spacer()
                }
            }
        }
    }
}
