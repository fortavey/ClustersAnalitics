//
//  ClusterContainerView.swift
//  ClustersAnalitics
//
//  Created by mm2 on 06.05.2026.
//

import SwiftUI

struct ClusterContainerView: View {
    var contentVM: ContentViewModel
    var cluster: Int
    @State private var defaultAppsList: [BrendModel] = []
    @State private var clusterAccountsList: [AccountModel] = []
    
    var body: some View {
        HStack{
            DefaultClusterView(cluster: cluster, defaultAppsList: defaultAppsList)
            ForEach(clusterAccountsList){ account in
                AccountView(contentVM: contentVM, account: account, defaultAppsList: defaultAppsList)
            }
            Spacer()
        }
        .onAppear{
            defaultAppsList = getAppsListFromCluster()
            clusterAccountsList = getAccountsListFromCluster()
        }
    }
    
    func getAppsListFromCluster() -> [BrendModel] {
        return contentVM.brendsList.filter{ $0.cluster == cluster && $0.isFavorite }
    }
    
    func getAccountsListFromCluster() -> [AccountModel] {
        let accListEnabled = contentVM.accountsList.filter{ $0.cluster == cluster && $0.isBan != true }
        var sortedArray: [AccountModel] = []
        
        sortedArray = accListEnabled.sorted { (account1, account2) in
            let appsArr1 = contentVM.appsList.filter{ $0.isBan != true && $0.createAccount == account1.alias }
            let appsArr2 = contentVM.appsList.filter{ $0.isBan != true && $0.createAccount == account2.alias }
            
            return appsArr1.count > appsArr2.count
        }
        
        
        return sortedArray
    }
}
