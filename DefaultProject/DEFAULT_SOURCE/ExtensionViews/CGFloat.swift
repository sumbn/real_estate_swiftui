//
//  CGFloat.swift
//  RingtoneMVVM2023
//
//  Created by CycTrung on 01/06/2023.
//

import Foundation
import SwiftUI

public extension CGFloat {
    /// Map the value to a new range
    /// Return a value on [from.lowerBound,from.upperBound] to a [to.lowerBound, to.upperBound] range
    ///
    /// - Parameters:
    ///   - from source: Current range (Default: 0...1.0)
    ///   - to target: Desired range (Default: 0...1.0)
    func mapped(from source: ClosedRange<CGFloat> = 0 ... 1.0, to target: ClosedRange<CGFloat> = 0 ... 1.0) -> CGFloat {
        return ((self - source.lowerBound) / (source.upperBound - source.lowerBound)) * (target.upperBound - target.lowerBound) + target.lowerBound
    }

    /// Map the value to a new inverted range
    /// Return a value on [from.lowerBound,from.upperBound] to the inverse of a [to.lowerBound, to.upperBound] range
    ///
    /// - Parameters:
    ///   - from source: Current range (Default: 0...1.0)
    ///   - to target: Desired range (Default: 0...1.0)
    func mappedInverted(from source: ClosedRange<CGFloat> = 0 ... 1.0, to target: ClosedRange<CGFloat> = 0 ... 1.0) -> CGFloat {
        return target.upperBound - mapped(from: source, to: target) + target.lowerBound
    }

    /// Map the value to a new range at a base-10 logarithmic scaling
    /// Return a value on [from.lowerBound,from.upperBound] to a [to.lowerBound, to.upperBound] range
    ///
    /// - Parameters:
    ///   - from source: Current range (Default: 0...1.0)
    ///   - to target: Desired range (Default: 0...1.0)
    func mappedLog10(from source: ClosedRange<CGFloat> = 0 ... 1.0, to target: ClosedRange<CGFloat> = 0 ... 1.0) -> CGFloat {
        let logN = log10(self)
        let logStart1 = log10(source.lowerBound)
        let logStop1 = log10(source.upperBound)
        let result = ((logN - logStart1) / (logStop1 - logStart1)) * (target.upperBound - target.lowerBound) + target.lowerBound
        if result.isNaN {
            return 0.0
        } else {
            return ((logN - logStart1) / (logStop1 - logStart1)) * (target.upperBound - target.lowerBound) + target.lowerBound
        }
    }

    /// Map the value to a new range at a base e^log(n) scaling
    /// Return a value on [from.lowerBound,from.upperBound] to a [to.lowerBound, to.upperBound] range
    ///
    /// - Parameters:
    ///   - from source: Current range (Default: 0...1.0)
    ///   - to target: Desired range (Default: 0...1.0)
    func mappedExp(from source: ClosedRange<CGFloat> = 0 ... 1.0, to target: ClosedRange<CGFloat> = 0 ... 1.0) -> CGFloat {
        let logStart2 = log(target.lowerBound)
        let logStop2 = log(target.upperBound)
        let scale = (logStop2 - logStart2) / (source.upperBound - source.lowerBound)
        return exp(logStart2 + scale * (self - source.lowerBound))
    }
}
