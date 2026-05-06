//
//  AppModel.swift
//  ClustersAnalitics
//
//  Created by mb1 on 03.05.2026.
//

import Foundation

enum ModerationStatus: String {
    case prepared = "Подготовлено"
    case approved = "Одобрено"
    case rejected = "Отклон"
    case review = "Модерация"
    case readyToPublish = "Ожидание публикации"
}
enum UpdateStatus: String {
    case firstModeration = "Первая модерация"
    case changeName = "Изменено название"
    case addKreo = "Добавлены креативы"
    case addWebview = "Добавлено Webview"
    case ready = "Готово"
}

struct AppModel: Identifiable, Hashable {
    var id: String
    var createAccount: String
    var firstAppName: String
    var moderationStatus: String
    var updateStatus: String
    var newAppName: String
    var isBan: Bool
}
