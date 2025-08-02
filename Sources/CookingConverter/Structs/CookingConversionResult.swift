//
//  CookingConversionResult.swift
//  CookingConverter
//
//  Created by David Sherlock on 02/08/2025.
//


import Foundation

// MARK: - Conversion Result

/// Detailed result of a cooking measurement conversion.
///
/// Contains the conversion result along with metadata about confidence,
/// notes, and potential errors. This provides transparency about the
/// reliability and context of conversions.
public struct CookingConversionResult: Sendable {
    /// Original amount that was converted
    public let originalAmount: Double
    
    /// Converted amount (nil if conversion failed)
    public let convertedAmount: Double?
    
    /// Ingredient that was converted
    public let ingredient: IngredientType
    
    /// Source unit
    public let fromUnit: CookingUnit
    
    /// Target unit
    public let toUnit: CookingUnit
    
    /// Confidence level of conversion (0.0 - 1.0)
    public let confidence: Double
    
    /// Error if conversion failed
    public let error: CookingConversionError?
    
    /// Additional notes about the conversion
    public let notes: String?
    
    /// Whether the conversion was successful
    public var isSuccess: Bool {
        return convertedAmount != nil && error == nil
    }
    
    /// Initialize a successful conversion result
    public init(
        originalAmount: Double,
        convertedAmount: Double,
        ingredient: IngredientType,
        fromUnit: CookingUnit,
        toUnit: CookingUnit,
        confidence: Double = 1.0,
        notes: String? = nil
    ) {
        self.originalAmount = originalAmount
        self.convertedAmount = convertedAmount
        self.ingredient = ingredient
        self.fromUnit = fromUnit
        self.toUnit = toUnit
        self.confidence = confidence
        self.error = nil
        self.notes = notes
    }
    
    /// Initialize a failed conversion result
    public init(
        originalAmount: Double,
        convertedAmount: Double? = nil,
        ingredient: IngredientType,
        fromUnit: CookingUnit,
        toUnit: CookingUnit,
        confidence: Double = 0.0,
        error: CookingConversionError,
        notes: String? = nil
    ) {
        self.originalAmount = originalAmount
        self.convertedAmount = convertedAmount
        self.ingredient = ingredient
        self.fromUnit = fromUnit
        self.toUnit = toUnit
        self.confidence = confidence
        self.error = error
        self.notes = notes
    }
}