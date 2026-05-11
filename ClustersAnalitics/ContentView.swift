//
//  ContentView.swift
//  ClustersAnalitics
//
//  Created by mb1 on 30.04.2026.
//
import Foundation
import SwiftUI

struct ContentView: View {
    @State private var contentVM: ContentViewModel = .init()
    @State private var numberOfClusters: Int = 10
    @State private var isFirstOpen = true
    
    var body: some View {
        VStack {
            if contentVM.accountsList.isEmpty{
                if isFirstOpen {
                    Button("Сформировать"){
                        isFirstOpen = false
                        updateDB()
                    }
                }else {
                    ProgressView()
                }
            }else {
                VStack{
                    HStack{
                        Button("Запуск Сервера"){
                            let str = "cd projects/parser\nnode index.js"
                            let pasteboard = NSPasteboard.general
                            pasteboard.declareTypes([NSPasteboard.PasteboardType.string], owner: nil)
                            pasteboard.setString(str, forType: .string)
                            openTerminalWithCommand()
                        }
                        Spacer()
                        Button("Обновить"){
                            contentVM.accountsList = []
                            updateDB()
                        }
                    }
                    ScrollView{
                        ForEach(1...numberOfClusters, id: \.self) { cluster in
                            
                            ClusterContainerView(contentVM: contentVM, cluster: cluster)
                            
                            Divider()
                                .padding(.vertical, 10)
                        }
                    }
                    .padding(.horizontal, 20)
                    Spacer()
                }
            }
        }
    }
    
    func openTerminalWithCommand() {
        guard let url = NSWorkspace.shared.urlForApplication(withBundleIdentifier: "com.apple.Terminal") else { return }

        let path = "/bin"
        let configuration = NSWorkspace.OpenConfiguration()
        configuration.arguments = [path]
        NSWorkspace.shared.openApplication(at: url,
                                           configuration: configuration,
                                           completionHandler: nil)
    }
    
    func updateDB(){
        contentVM.getAccountsList()
        contentVM.getAppsList()
        contentVM.getBrendsList()
    }
}
