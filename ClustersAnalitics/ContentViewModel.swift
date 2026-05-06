import Foundation
import Combine
import FirebaseFirestore

@Observable
class ContentViewModel {
    var accountsList: [AccountModel] = []
    var appsList: [AppModel] = []
    var brendsList: [BrendModel] = []
        
    func getAccountsList(){
        FirebaseServices().getDocuments(collection: "trust") { docs in
            var array: [AccountModel] = []
            
            docs.forEach{doc in
                let id = doc.documentID
                let alias = doc["alias"] as? String
                let cluster = doc["cluster"] as? Int
                let isBan = doc["isBan"] as? Bool
                
                array.append(
                    AccountModel(
                        id: id,
                        alias: alias ?? "",
                        cluster: cluster ?? 0,
                        isBan: isBan
                    )
                )
            }
            self.accountsList = array
        }
    }
    
    func getAppsList(){
        FirebaseServices().getDocuments(collection: "apps") { docs in
            var array: [AppModel] = []
            
            docs.forEach{doc in
                let id = doc.documentID
                let createAccount = doc["createAccount"] as? String
                let firstAppName = doc["firstAppName"] as? String
                let moderationStatus = doc["moderationStatus"] as? String
                let updateStatus = doc["updateStatus"] as? String
                let newAppName = doc["newAppName"] as? String
                let isBan = doc["isBan"] as? Bool
                
                array.append(
                    AppModel(
                        id: id,
                        createAccount: createAccount ?? "",
                        firstAppName: firstAppName ?? "",
                        moderationStatus: moderationStatus ?? "",
                        updateStatus: updateStatus ?? "",
                        newAppName: newAppName ?? "",
                        isBan: isBan ?? false
                    )
                )
            }
            self.appsList = array
            print(self.appsList)
        }
    }
    
    func getBrendsList(){
        FirebaseServices().getDocuments(collection: "brends") { docs in
            var array: [BrendModel] = []
            
            docs.forEach{doc in
                let id = doc.documentID
                let name = doc["name"] as? String
                let cluster = doc["limitCounter"] as? Int
                let isFavorite = doc["isFavorite"] as? Bool
                
                array.append(
                    BrendModel(
                        id: id,
                        name: name ?? "",
                        cluster: cluster ?? 0,
                        isFavorite: isFavorite ?? false
                    )
                )
            }
            self.brendsList = array
        }
    }
}
