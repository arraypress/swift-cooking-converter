//
//  CookingConverter.swift
//  CookingConverter
//
//  A comprehensive cooking measurement converter with ingredient-specific conversions
//  Created by David Sherlock on 02/08/2025.
//

import Foundation

/// A comprehensive cooking measurement converter that handles ingredient-specific conversions.
///
/// CookingConverter goes beyond simple unit conversion by accounting for the different densities
/// and properties of various cooking ingredients. Unlike generic unit converters that only handle
/// volume-to-volume or weight-to-weight conversions, this library enables accurate conversions
/// between volume and weight measurements for specific ingredients.
///
/// ## Key Features
///
/// - **Ingredient-Specific Conversions**: Different ingredients have different densities
/// - **Volume ↔ Weight Conversions**: Convert cups to grams, tablespoons to ounces, etc.
/// - **Temperature Conversions**: Fahrenheit ↔ Celsius for cooking temperatures
/// - **Recipe Scaling**: Scale entire recipes while maintaining proper ratios
/// - **Confidence Scoring**: Indicates reliability of conversions
/// - **International Support**: US, Metric, and Imperial measurement systems
///
/// ## Example Usage
///
/// ```swift
/// // Convert flour from cups to grams
/// let flour = CookingConverter.convert(
///     amount: 2.0,
///     ingredient: .allPurposeFlour,
///     from: .cups,
///     to: .grams
/// )
/// // Result: 240.0 grams (120g per cup for flour)
///
/// // Convert sugar (different density than flour)
/// let sugar = CookingConverter.convert(
///     amount: 1.0,
///     ingredient: .granulatedSugar,
///     from: .cups,
///     to: .grams
/// )
/// // Result: 200.0 grams (200g per cup for sugar)
///
/// // Temperature conversion
/// let celsius = CookingConverter.convertTemperature(350, from: .fahrenheit, to: .celsius)
/// // Result: 176.67°C
/// ```
///
/// ## Supported Conversions
///
/// - **Volume Units**: cups, tablespoons, teaspoons, milliliters, liters, fluid ounces
/// - **Weight Units**: grams, kilograms, ounces, pounds
/// - **Temperature Units**: Fahrenheit, Celsius
/// - **30+ Common Ingredients**: Flours, sugars, fats, liquids, nuts, spices
///
/// ## Accuracy Notes
///
/// Volume-to-weight conversions depend on factors like ingredient packing, humidity,
/// and measurement technique. The library provides confidence scores and helpful notes
/// to indicate conversion reliability.
public struct CookingConverter {
    
    /// Convert a cooking measurement between units for a specific ingredient.
    ///
    /// This is the primary conversion method that handles ingredient-specific density
    /// calculations. It can convert between any supported units, automatically handling
    /// the complexity of volume-to-weight conversions based on ingredient properties.
    ///
    /// ## Conversion Types Supported
    ///
    /// - **Volume → Volume**: cups to milliliters, tablespoons to fluid ounces
    /// - **Weight → Weight**: grams to ounces, pounds to kilograms  
    /// - **Volume → Weight**: cups to grams (ingredient-specific)
    /// - **Weight → Volume**: grams to cups (ingredient-specific)
    ///
    /// ## Example
    /// ```swift
    /// // Different ingredients have different densities
    /// let flourGrams = CookingConverter.convert(
    ///     amount: 1.0,
    ///     ingredient: .allPurposeFlour,
    ///     from: .cups,
    ///     to: .grams
    /// )
    /// // Result: 120.0 (flour is lighter)
    ///
    /// let sugarGrams = CookingConverter.convert(
    ///     amount: 1.0,
    ///     ingredient: .granulatedSugar,
    ///     from: .cups,
    ///     to: .grams
    /// )
    /// // Result: 200.0 (sugar is denser)
    /// ```
    ///
    /// - Parameters:
    ///   - amount: The quantity to convert (must be positive)
    ///   - ingredient: The specific ingredient being measured
    ///   - fromUnit: Source measurement unit
    ///   - toUnit: Target measurement unit
    /// - Returns: Converted amount, or nil if conversion is not possible
    /// - Note: For detailed conversion information including confidence scores and notes,
    ///         use `convertWithDetails(_:ingredient:from:to:)` instead
    public static func convert(
        amount: Double,
        ingredient: IngredientType,
        from fromUnit: CookingUnit,
        to toUnit: CookingUnit
    ) -> Double? {
        return convertWithDetails(
            amount: amount,
            ingredient: ingredient,
            from: fromUnit,
            to: toUnit
        ).convertedAmount
    }
    
    /// Convert a cooking measurement with comprehensive result metadata.
    ///
    /// Provides detailed conversion information including confidence scores, helpful notes,
    /// and error details. This method is recommended when you need to understand the
    /// reliability of the conversion or provide user feedback.
    ///
    /// ## Confidence Scoring
    ///
    /// - **0.95-1.0**: Highly reliable (same-type conversions, liquids)
    /// - **0.80-0.94**: Reliable (common ingredients, established densities)
    /// - **0.70-0.79**: Moderate (packing-dependent ingredients)
    /// - **0.50-0.69**: Lower confidence (variable density ingredients)
    ///
    /// ## Example
    /// ```swift
    /// let result = CookingConverter.convertWithDetails(
    ///     amount: 1.0,
    ///     ingredient: .brownSugar,
    ///     from: .cups,
    ///     to: .grams
    /// )
    ///
    /// if result.isSuccess {
    ///     print("Result: \(result.convertedAmount!) grams")
    ///     print("Confidence: \(result.confidence)")
    ///     print("Notes: \(result.notes ?? "None")")
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - amount: The quantity to convert (must be positive)
    ///   - ingredient: The specific ingredient being measured
    ///   - fromUnit: Source measurement unit
    ///   - toUnit: Target measurement unit
    /// - Returns: Detailed conversion result with metadata
    public static func convertWithDetails(
        amount: Double,
        ingredient: IngredientType,
        from fromUnit: CookingUnit,
        to toUnit: CookingUnit
    ) -> CookingConversionResult {
        
        guard amount > 0 else {
            return CookingConversionResult(
                originalAmount: amount,
                ingredient: ingredient,
                fromUnit: fromUnit,
                toUnit: toUnit,
                error: .invalidAmount(amount)
            )
        }
        
        // Same unit conversion
        if fromUnit == toUnit {
            return CookingConversionResult(
                originalAmount: amount,
                convertedAmount: amount,
                ingredient: ingredient,
                fromUnit: fromUnit,
                toUnit: toUnit,
                confidence: 1.0,
                notes: "Same unit - no conversion needed"
            )
        }
        
        // Get conversion factor for this ingredient
        guard let conversionFactor = getConversionFactor(
            ingredient: ingredient,
            from: fromUnit,
            to: toUnit
        ) else {
            return CookingConversionResult(
                originalAmount: amount,
                ingredient: ingredient,
                fromUnit: fromUnit,
                toUnit: toUnit,
                error: .unsupportedConversion(from: fromUnit, to: toUnit, for: ingredient)
            )
        }
        
        let convertedAmount = amount * conversionFactor
        let confidence = getConfidence(from: fromUnit, to: toUnit, ingredient: ingredient)
        let notes = generateNotes(from: fromUnit, to: toUnit, ingredient: ingredient)
        
        return CookingConversionResult(
            originalAmount: amount,
            convertedAmount: convertedAmount,
            ingredient: ingredient,
            fromUnit: fromUnit,
            toUnit: toUnit,
            confidence: confidence,
            notes: notes
        )
    }
    
    /// Scale an entire recipe to serve a different number of people.
    ///
    /// Proportionally adjusts all ingredient quantities while maintaining recipe ratios.
    /// This is essential for recipe scaling since ingredients don't always scale linearly
    /// (especially leavening agents and seasonings in very large batches).
    ///
    /// ## Example
    /// ```swift
    /// let originalIngredients = [
    ///     RecipeIngredient(name: "flour", amount: 2.0, unit: .cups),
    ///     RecipeIngredient(name: "sugar", amount: 1.0, unit: .cups),
    ///     RecipeIngredient(name: "butter", amount: 0.5, unit: .cups)
    /// ]
    ///
    /// // Scale from 4 servings to 6 servings
    /// let scaledIngredients = CookingConverter.scaleRecipe(
    ///     ingredients: originalIngredients,
    ///     from: 4,
    ///     to: 6
    /// )
    /// // Results in 1.5x amounts: 3 cups flour, 1.5 cups sugar, 0.75 cups butter
    /// ```
    ///
    /// - Parameters:
    ///   - ingredients: Array of recipe ingredients to scale
    ///   - originalServings: Original number of servings the recipe makes
    ///   - newServings: Desired number of servings
    /// - Returns: Array of scaled ingredients with adjusted amounts
    /// - Note: Very large scaling factors (>4x) may require adjustment of leavening agents
    public static func scaleRecipe(
        ingredients: [RecipeIngredient],
        from originalServings: Int,
        to newServings: Int
    ) -> [RecipeIngredient] {
        guard originalServings > 0 && newServings > 0 else { return ingredients }
        
        let scaleFactor = Double(newServings) / Double(originalServings)
        
        return ingredients.map { ingredient in
            RecipeIngredient(
                name: ingredient.name,
                amount: ingredient.amount * scaleFactor,
                unit: ingredient.unit,
                notes: ingredient.notes
            )
        }
    }
    
    /// Convert temperature between Fahrenheit and Celsius.
    ///
    /// Handles cooking temperature conversions using the standard temperature conversion
    /// formulas. Commonly used for oven temperatures, candy making, and precise cooking.
    ///
    /// ## Common Cooking Temperatures
    ///
    /// - **Oven Baking**: 350°F = 177°C, 375°F = 190°C, 425°F = 218°C
    /// - **Deep Frying**: 350-375°F = 177-190°C
    /// - **Candy Making**: Soft ball = 235°F = 113°C, Hard crack = 300°F = 149°C
    ///
    /// ## Example
    /// ```swift
    /// let celsius = CookingConverter.convertTemperature(350, from: .fahrenheit, to: .celsius)
    /// // Result: 176.67
    ///
    /// let fahrenheit = CookingConverter.convertTemperature(180, from: .celsius, to: .fahrenheit)
    /// // Result: 356.0
    /// ```
    ///
    /// - Parameters:
    ///   - temperature: Temperature value to convert
    ///   - from: Source temperature unit (.fahrenheit or .celsius)
    ///   - to: Target temperature unit (.fahrenheit or .celsius)
    /// - Returns: Converted temperature, or nil if units are not temperature units
    public static func convertTemperature(
        _ temperature: Double,
        from: CookingUnit,
        to: CookingUnit
    ) -> Double? {
        switch (from, to) {
        case (.fahrenheit, .celsius):
            return (temperature - 32) * 5/9
        case (.celsius, .fahrenheit):
            return temperature * 9/5 + 32
        case (from, to) where from == to:
            return temperature
        default:
            return nil
        }
    }
    
    /// Get comprehensive information about converter capabilities.
    ///
    /// Returns metadata about supported ingredients, units, and conversion types.
    /// Useful for building user interfaces or validating conversion requests.
    ///
    /// ## Example
    /// ```swift
    /// let info = CookingConverter.conversionInfo()
    /// print("Supported ingredients: \(info.supportedIngredients.count)")
    /// print("Supported units: \(info.supportedUnits.count)")
    /// print("Total conversions possible: \(info.totalConversions)")
    /// ```
    ///
    /// - Returns: Comprehensive conversion capability information
    public static func conversionInfo() -> CookingConversionInfo {
        return CookingConversionInfo(
            supportedIngredients: IngredientType.allCases,
            supportedUnits: CookingUnit.allCases,
            supportedSystems: CookingSystem.allCases,
            conversionTypes: MeasurementType.allCases,
            description: "Professional-grade cooking measurement converter with ingredient-specific density calculations"
        )
    }
    
}
