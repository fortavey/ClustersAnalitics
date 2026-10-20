//
//  Helpers.swift
//  ClustersAnalitics
//
//  Created by mm2 on 07.05.2026.
//

import Foundation
import SwiftUI

class Helpers {
    let fileManager = FileManager.default
    let runFilePath = "\(NSHomeDirectory())/run.sh"
    let runFileURL = URL(fileURLWithPath: "\(NSHomeDirectory())/run.sh")
    
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
        case "mx" : return "es-419"
        case "ro" : return "ro"
        case "hu" : return "hu"
        case "pt" : return "pt"
        case "br" : return "pt-br"
        case "tr" : return "tr"
        case "cz" : return "cs"
        case "kz" : return "kk"
        case "gr" : return "el"
        case "ru" : return "ru"
        case "sn" : return "fr"
        case "cd" : return "fr"
        case "ci" : return "fr"
        case "ml" : return "fr"
        case "bf" : return "fr"
        case "ne" : return "fr"
        case "gq" : return "fr"
        case "cg" : return "fr"
        case "cm" : return "fr"
        case "tn" : return "fr"
        default: return "en"
        }
    }
    
    func getStringForSearch(name: String) -> String {
        return name.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)

    }
}
