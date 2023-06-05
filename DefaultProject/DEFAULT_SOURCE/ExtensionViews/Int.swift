//
//  Int.swift
//  RingtoneMVVM2023
//
//  Created by CycTrung on 01/06/2023.
//

import Foundation
public extension Int {
    /// Map the value to a new range
    /// Return a value on [from.lowerBound,from.upperBound] to a [to.lowerBound, to.upperBound] range
    ///
    /// - Parameters:
    ///   - from source: Current range
    ///   - to target: Desired range (Default: 0...1.0)
    func mapped(from source: ClosedRange<Int>, to target: ClosedRange<CGFloat> = 0 ... 1.0) -> CGFloat {
        return (CGFloat(self - source.lowerBound) / CGFloat(source.upperBound - source.lowerBound)) * (target.upperBound - target.lowerBound) + target.lowerBound
    }
}
