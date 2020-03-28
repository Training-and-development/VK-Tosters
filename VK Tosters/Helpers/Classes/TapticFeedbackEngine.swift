//
//  TapticFeedbackEngine.swift
//  Epic Phrases
//
//  Created by programmist_np on 09.03.2020.
//  Copyright © 2020 Funny Applications. All rights reserved.
//

import Foundation
import UIKit

class TapticFeedbackEngine {
    class func setTapticEngine(style: ToastStyle) -> ()? {
        let notificationFeedbackGenerator = UINotificationFeedbackGenerator()
        notificationFeedbackGenerator.prepare()
        switch style {
        case .default:
            return nil
        case .error:
            return notificationFeedbackGenerator.notificationOccurred(.error)
        case .warning:
            return notificationFeedbackGenerator.notificationOccurred(.warning)
        case .success:
            return notificationFeedbackGenerator.notificationOccurred(.success)
        }
    }
}
