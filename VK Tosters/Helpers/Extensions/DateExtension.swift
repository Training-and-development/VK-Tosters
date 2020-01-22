//
//  DateExtension.swift
//  VK Tosters
//
//  Created by programmist_np on 22/01/2020.
//  Copyright © 2020 programmist_np. All rights reserved.
//

import Foundation

extension Date {
    init?(jsonDate: String) {

        let prefix = "/Date("
        let suffix = ")/"

        // Check for correct format:
        guard jsonDate.hasPrefix(prefix) && jsonDate.hasSuffix(suffix) else { return nil }

        // Extract the number as a string:
        let from = jsonDate.index(jsonDate.startIndex, offsetBy: prefix.count)
        let to = jsonDate.index(jsonDate.endIndex, offsetBy: -suffix.count)

        // Convert milliseconds to double
        guard let milliSeconds = Double(jsonDate[from ..< to]) else { return nil }

        // Create NSDate with this UNIX timestamp
        self.init(timeIntervalSince1970: milliSeconds/1000.0)
    }
}
