//
//  NSColor+Int32.swift
//  QLSwift
//
//  Created by paraches on 2020/10/08.
//

import Foundation
import Cocoa

extension NSColor {
    public convenience init(int32: Int32) {
        let uInt32Color = UInt32(bitPattern: int32)
        let alpha = CGFloat((uInt32Color & 0xff000000) >> 24) / 255
        let red = CGFloat((uInt32Color & 0x00ff0000) >> 16) / 255
        let green = CGFloat((uInt32Color & 0x0000ff00) >> 8) / 255
        let blue = CGFloat(uInt32Color & 0x000000ff) / 255
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
