//
//  DefaultClusterView.swift
//  ClustersAnalitics
//
//  Created by mb1 on 04.05.2026.
//

import SwiftUI

struct DefaultClusterView: View {
    var contentVM: ContentViewModel
    var cluster: Int
    var defaultAppsList: [BrendModel]
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Кластер \(cluster)")
            ForEach(defaultAppsList, id: \.self){brend in
                BrendItemView(contentVM: contentVM, brend: brend)
            }
            Text("Итого прил - \(defaultAppsList.count)")
            Spacer()
        }
    }
}

struct BrendItemView: View {
    var contentVM: ContentViewModel
    var requestString = "http://localhost:1717/api/googlePlayRequest"
    var brend: BrendModel
    @State private var idList: [String] = []
    @State private var countryPositions: [String: Int] = [:]
    @State private var isPlayRequestActive: Bool = false
    
    var body: some View {
        HStack{
            Button(action: {
                copyText(brendName: brend.name)
            }) {
                HStack{
                    Text(brend.name)
                    Spacer()
                    ForEach(brend.countries, id: \.self){ countryCode in
                        FlagIcon(brend: brend, countryCode: countryCode, countryPositions: countryPositions)
                    }
                }
                .frame(width: 250, height: 20, alignment: .init(horizontal: .leading, vertical: .center))
            }
            .buttonStyle(.borderedProminent)
            .onAppear{
                brend.countries.forEach { countryCode in
                    countryPositions[countryCode.lowercased()] = 0
                }
            }
            if isPlayRequestActive {
                ProgressView()
                    .controlSize(.small)
                    .frame(width: 40)
            }else {
                Button(action: {
                    sendPlayRequest()
                }, label: {
                    Image(systemName: "arrowshape.right")
                })
            }
        }
    }
    
    func sendPlayRequest(){
        isPlayRequestActive = true
        
        brend.countries.forEach { countryCode in
            let geo = countryCode.lowercased()
            fetch(lang: Helpers().getLangFromGeo(geo: geo), geo: geo)
        }
    }
    
    func copyText(brendName: String){
        let pasteboard = NSPasteboard.general
        pasteboard.declareTypes([NSPasteboard.PasteboardType.string], owner: nil)
        pasteboard.setString(brendName, forType: .string)
    }
    
    func changeAppPosition(geo: String, idList: [String]){
        let allOurAppsIds = contentVM.appsList.filter{$0.isBan != true}.map{ "com." + $0.firstAppName.lowercased() }
        var pos = 0
        idList.enumerated().forEach { index, appId in
            if allOurAppsIds.contains(appId){
                if pos == 0 {
                    pos = index + 1
                }
            }
        }
        countryPositions[geo.lowercased()] = pos
    }
    
    func fetch(lang: String, geo: String) {
        var query = brend.name
        query = query.replacing(" ", with: "+")
        let url = URL(string: requestString)
        
        guard let url else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let requestVal = [query, lang, geo]
        let encoder = JSONEncoder()
        let data = try! encoder.encode(requestVal)
        request.httpBody = data
                
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil { return }
            
            if let response = response as? HTTPURLResponse {
                print(response)
                if response.statusCode == 200 {
                    guard let data = data else { return }
                    do {
                        let results = try JSONDecoder().decode([String].self, from: data)
                        changeAppPosition(geo: geo, idList: results)
                        isPlayRequestActive = false
                    } catch {
                        print("Failure", error)
                    }
                }else {
                    print("Else Error Parser")
                }
            }
        }
        task.resume()
    }
}

struct FlagIcon: View {
    var brend: BrendModel
    var countryCode: String
    var countryPositions: [String: Int]
    @State private var isHovered: Bool = false
    @State private var position: Int = 0
    
    var body: some View {
        HStack{
            Image(getFlagIconName())
            Text("\(countryPositions[countryCode.lowercased()] ?? 0)")
        }
        .onHover { hover in
            isHovered = hover ? true : false
        }
        .popover(isPresented: $isHovered) {
            Text("\(countryCode)")
                .padding()
        }
        .contextMenu {
            if let link = URL(string: "https://play.google.com/store/search?q=\(Helpers().getStringForSearch(name: brend.name))&c=apps&hl=\(Helpers().getLangFromGeo(geo: countryCode.lowercased()))&gl=\(countryCode)") {
                Link(destination: link) {
                    Text("Открыть в поиске")
                }
            }
        }
    }
    
    func getFlagIconName() -> String {
        if countryCode == "" { return "cn" }
        return countryCode.lowercased()
    }
}
