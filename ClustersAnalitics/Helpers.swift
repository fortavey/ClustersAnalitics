//
//  Helpers.swift
//  ClustersAnalitics
//
//  Created by mm2 on 07.05.2026.
//

import Foundation

class Helpers {
    func getLangFromGeo(geo: String) -> String {
        switch geo {
        case "it" : return "it"
        case "es" : return "es"
        case "fr" : return "fr"
        case "de" : return "de"
        case "pl" : return "pl"
        case "ar" : return "es-419"
        case "pe" : return "es-419"
        case "cl" : return "es-419"
        case "ve" : return "es-419"
        case "ec" : return "es-419"
        case "ro" : return "ro"
        case "hu" : return "hu"
        case "pt" : return "pt"
        case "br" : return "pt-br"
        case "tr" : return "tr"
        case "cz" : return "cs"
        case "kz" : return "kk"
        case "gr" : return "el"
        case "ru" : return "ru"
        default: return "en"
        }
    }
    
    func getStringForSearch(name: String) -> String {
        return name.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)

    }
}
