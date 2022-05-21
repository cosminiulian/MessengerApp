//
//  LocalNotificationHelper.swift
//  MessengerApp
//
//  Created by Cosmin Iulian on 28.03.2022.
//

import UIKit
import UserNotifications

open class LocalNotificationHelper {

    open class func showNotification(title: String, subtitle: String, body: String, identifier: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.body = body
        content.sound = .default
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
}
