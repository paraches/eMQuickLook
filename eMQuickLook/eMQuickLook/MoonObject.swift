//
//  MoonObject.swift
//  QLSwift
//
//  Created by paraches on 2020/10/02.
//

import Foundation
import Cocoa

struct MoonLine {
    let point: CGPoint
    let width: CGFloat
}

struct MoonStroke: Decodable {
    let width: Double
    let color: NSColor
    let type: String
    let data: [Double]
    let points: [MoonLine]
    
    enum CodingKeys: String, CodingKey {
        case width
        case color
        case type
        case data
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        width = try values.decode(Double.self, forKey: .width)
        type = try values.decode(String.self, forKey: .type)
        data = try values.decode([Double].self, forKey: .data)
        let intColor = try values.decode(Int32.self, forKey: .color)
        color = NSColor(int32: intColor)

        var p = [MoonLine]()
        for i in stride(from: 0, to: data.count, by: 3) {
            let x = data[i]
            let y = data[i + 1]
            let width = data[i + 2]
            p.append(MoonLine(point: CGPoint(x: x, y: y), width: CGFloat(width)))
        }
        points = p
    }
}

struct MoonObject: Decodable {
    let version: String
    let x: Int
    let y: Int
    let width: Int
    let height: Int
    let scale: Double
    let color: Int
    let transparent: Bool
    let strokes: [MoonStroke]
}

