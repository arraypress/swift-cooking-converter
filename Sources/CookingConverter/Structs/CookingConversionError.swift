//
//  CookingConversionError.swift
//  CookingConverter
//
//  Created by David Sherlock on 02/08/2025.
//

import Foundation

/// Errors that can occur during cooking conversions.
public enum CookingConversionError: Error, LocalizedError, Equatable, Sendable {
    
    /// Invalid amount provided (negative or zero)
    case invalidAmount(Double)
    
    /// Conversion not supported between these units for this ingredient
    case unsupportedConversion(from: CookingUnit, to: CookingUnit, for: IngredientType)
    
    /// Unknown ingredient provided
    case unknownIngredient(String)
    
    /// Ambiguous conversion request
    case ambiguousConversion(String)
    
    /// Amount out of reasonable range
    case amountOutOfRange(Double, validRange: String)
    
    public var errorDescription: String? {
        switch self {
        case .invalidAmount(let amount):
            return "Invalid amount: \(amount). Amount must be positive."
        case .unsupportedConversion(let from, let to, let ingredient):
            return "Cannot convert \(ingredient.rawValue) from \(from.rawValue) to \(to.rawValue)"
        case .unknownIngredient(let ingredient):
            return "Unknown ingredient: \(ingredient)"
        case .ambiguousConversion(let description):
            return "Ambiguous conversion: \(description)"
        case .amountOutOfRange(let amount, let range):
            return "Amount \(amount) out of valid range: \(range)"
        }
    }
    
    /// User-friendly error message
    public var userFriendlyDescription: String {
        switch self {
        case .invalidAmount:
            return "Please enter a positive amount"
        case .unsupportedConversion(let from, let to, let ingredient):
            return "Can't convert \(ingredient.description) from \(from.fullName) to \(to.fullName)"
        case .unknownIngredient(let ingredient):
            return "Don't recognize ingredient: \(ingredient)"
        case .ambiguousConversion:
            return "Please be more specific about the conversion"
        case .amountOutOfRange:
            return "Amount seems unusually large or small"
        }
    }
    
}
