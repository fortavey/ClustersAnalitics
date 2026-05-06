//
//  AccountView.swift
//  ClustersAnalitics
//
//  Created by mm2 on 06.05.2026.
//

import SwiftUI

struct AccountView: View {
    var contentVM: ContentViewModel
    var account: AccountModel
    var defaultAppsList: [BrendModel]
    
    var body: some View {
        VStack{
            Text(account.alias)
            ForEach(defaultAppsList, id: \.self){brend in
                SingleApp(contentVM: contentVM, account: account, brend: brend.name)
            }
        }
    }
}

struct SingleApp: View {
    var contentVM: ContentViewModel
    var account: AccountModel
    var brend: String
    @State private var appsFromCurrentBrend: [AppModel] = []
    
    var body: some View {
        Button(action: {}) {
            if appsFromCurrentBrend.isEmpty {
                Text("")
                    .frame(width: 120, height: 20, alignment: .init(horizontal: .leading, vertical: .center))
            }else {
                HStack{
                    Text("\(appsFromCurrentBrend[0].newAppName)")
                    ForEach(appsFromCurrentBrend){ app in
                        if app.moderationStatus == ModerationStatus.approved.rawValue {
                            Rectangle()
                                .fill(.green)
                                .frame(width: 15, height: 15)
                        }else if app.moderationStatus == ModerationStatus.readyToPublish.rawValue {
                            Rectangle()
                                .fill(.blue)
                                .frame(width: 15, height: 15)
                        }else if app.moderationStatus == ModerationStatus.review.rawValue {
                            Rectangle()
                                .fill(.yellow)
                                .frame(width: 15, height: 15)
                        }else if app.moderationStatus == ModerationStatus.rejected.rawValue {
                            Rectangle()
                                .fill(.red)
                                .frame(width: 15, height: 15)
                        }else {
                            Rectangle()
                                .fill(.gray)
                                .frame(width: 15, height: 15)
                        }
                    }
                }
                .frame(width: 120, height: 20, alignment: .init(horizontal: .leading, vertical: .center))
            }
            
        }
        .onAppear{
            getAppsOrEmpty()
        }
    }
    
    func getAppsOrEmpty() {
        let workApps = contentVM.appsList.filter{$0.isBan != true}
        let appsFromAccount = workApps.filter{ $0.createAccount == account.alias }
        if appsFromAccount.contains(where: { $0.newAppName == brend }) {
            appsFromAccount.filter{ $0.newAppName == brend }.forEach{
                appsFromCurrentBrend.append($0)
            }
        }
    }
}
