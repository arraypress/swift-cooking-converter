//
//  CookingConversionInfo.swift
//  CookingConverter
//
//  Created by David Sherlock on 02/08/2025.
//

import Foundation

/// Comprehensive information about converter capabilities.
public struct CookingConversionInfo: Sendable {
    
    /// All supported ingredients
    public let supportedIngredients: [IngredientType]
    
    /// All supported measurement units
    public let supportedUnits: [CookingUnit]
    
    /// All supported measurement systems
    public let supportedSystems: [CookingSystem]
    
    /// All supported conversion types
    public let conversionTypes: [MeasurementType]
    
    /// Description of the converter
    public let description: String
    
    /// Total number of possible conversions
    public var totalConversions: Int {
        let ingredients = supportedIngredients.count
        let units = supportedUnits.count
        return ingredients * units * (units - 1) // n ingredients × n units × (n-1) target units
    }
    
    /// Units grouped by measurement type
    public var unitsByType: [MeasurementType: [CookingUnit]] {
        return Dictionary(grouping: supportedUnits) { $0.measurementType }
    }
    
    /// Ingredients grouped by category
    public var ingredientsByCategory: [IngredientCategory: [IngredientType]] {
        return Dictionary(grouping: supportedIngredients) { $0.category }
    }
    
}
