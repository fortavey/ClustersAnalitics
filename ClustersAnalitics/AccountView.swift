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
    @State private var currentAppsList: [AppModel] = []
    
    var body: some View {
        VStack{
            Text(account.alias)
            if !currentAppsList.isEmpty{
                ForEach(defaultAppsList, id: \.self){brend in
                    SingleApp(contentVM: contentVM, account: account, brend: brend.name, currentAppsList: currentAppsList)
                }
                Text("Первая модер. - \(getAppsInFirstModeration())")
                Text("Готовы к Webview - \(getAppsInReadyToRename())")
            }
            Spacer()
        }
        .onAppear{
            getAppsFromCurrentAccount()
        }
    }
    
    func getAppsFromCurrentAccount() {
        let workApps = contentVM.appsList.filter{$0.isBan != true}
        let appsFromAccount = workApps.filter{ $0.createAccount == account.alias }
        currentAppsList = appsFromAccount
    }
    
    func getAppsInReadyToRename() -> Int {
        return currentAppsList.filter{  $0.newAppName == "" &&
                                        $0.updateStatus == UpdateStatus.changeName.rawValue }.count
    }
    
    func getAppsInFirstModeration() -> Int {
        return currentAppsList.filter{  $0.newAppName == "" &&
                                        $0.updateStatus == UpdateStatus.firstModeration.rawValue }.count
    }
}

struct StatusRectangle: View {
    var color: Color
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(width: 15, height: 15)
    }
}

struct SingleApp: View {
    var contentVM: ContentViewModel
    var account: AccountModel
    var brend: String
    var currentAppsList: [AppModel]
    @State private var appsFromCurrentBrend: [AppModel] = []
    
    var body: some View {
        Button(action: {}) {
            if appsFromCurrentBrend.isEmpty {
                Text("")
                    .frame(width: 150, height: 20, alignment: .init(horizontal: .leading, vertical: .center))
            }else {
                HStack{
                    Text("\(appsFromCurrentBrend[0].newAppName)")
                    ForEach(appsFromCurrentBrend){ app in
                        switch app.moderationStatus {
                        case ModerationStatus.approved.rawValue: StatusRectangle(color: .green)
                        case ModerationStatus.readyToPublish.rawValue: StatusRectangle(color: .blue)
                        case ModerationStatus.review.rawValue: StatusRectangle(color: .yellow)
                        case ModerationStatus.rejected.rawValue: StatusRectangle(color: .red)
                        default: StatusRectangle(color: .gray)
                        }
                    }
                }
                .frame(width: 150, height: 20, alignment: .init(horizontal: .leading, vertical: .center))
            }
            
        }
        .onAppear{
            getAppsOrEmpty()
            
        }
    }
    
    func getAppsOrEmpty() {
        if currentAppsList.contains(where: { $0.newAppName == brend }) {
            currentAppsList.filter{ $0.newAppName == brend }.forEach{
                appsFromCurrentBrend.append($0)
            }
        }
    }
}
