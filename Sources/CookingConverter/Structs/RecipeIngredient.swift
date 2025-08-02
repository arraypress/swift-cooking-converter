//
//  RecipeIngredient.swift
//  CookingConverter
//
//  Created by David Sherlock on 02/08/2025.
//


import Foundation

// MARK: - Recipe Ingredient

/// Represents a single ingredient in a recipe with amount and unit.
///
/// Used for recipe scaling and batch conversions. Contains all the information
/// needed to represent an ingredient measurement in a recipe.
///
/// ## Example Usage
/// ```swift
/// let flour = RecipeIngredient(
///     name: "all-purpose flour",
///     amount: 2.0,
///     unit: .cups,
///     notes: "sifted"
/// )
/// ```
public struct RecipeIngredient: Sendable, Equatable {
    /// Name of the ingredient
    public let name: String
    
    /// Quantity of the ingredient
    public let amount: Double
    
    /// Unit of measurement
    public let unit: CookingUnit
    
    /// Optional notes about preparation or measurement
    public let notes: String?
    
    /// Initialize a recipe ingredient
    /// - Parameters:
    ///   - name: Ingredient name (e.g., "all-purpose flour")
    ///   - amount: Quantity (e.g., 2.0)
    ///   - unit: Measurement unit (e.g., .cups)
    ///   - notes: Optional preparation notes (e.g., "sifted")
    public init(name: String, amount: Double, unit: CookingUnit, notes: String? = nil) {
        self.name = name
        self.amount = amount
        self.unit = unit
        self.notes = notes
    }
}