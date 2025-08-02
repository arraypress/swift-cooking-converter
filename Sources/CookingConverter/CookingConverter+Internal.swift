//
//  CookingConverter+Internal.swift
//  CookingConverter
//
//  Internal conversion logic and helper methods
//  Created on 02/08/2025.
//

import Foundation

// MARK: - Internal Conversion Logic

extension CookingConverter {
    
    /// Volume conversion factors (to milliliters as base unit)
    internal static let volumeConversions: [CookingUnit: Double] = [
        .cups: 240.0,           // US cup standard
        .tablespoons: 15.0,     // US tablespoon
        .teaspoons: 5.0,        // US teaspoon
        .milliliters: 1.0,      // Base unit
        .liters: 1000.0,        // 1000 ml per liter
        .fluidOunces: 29.5735   // US fluid ounce
    ]
    
    /// Weight conversion factors (to grams as base unit)
    internal static let weightConversions: [CookingUnit: Double] = [
        .grams: 1.0,            // Base unit
        .kilograms: 1000.0,     // 1000g per kg
        .ounces: 28.3495,       // Avoirdupois ounce
        .pounds: 453.592        // Avoirdupois pound
    ]
    
    /// Get conversion factor between two units for a specific ingredient
    internal static func getConversionFactor(
        ingredient: IngredientType,
        from fromUnit: CookingUnit,
        to toUnit: CookingUnit
    ) -> Double? {
        
        let fromType = fromUnit.measurementType
        let toType = toUnit.measurementType
        
        switch (fromType, toType) {
        case (.volume, .volume):
            return convertVolumeToVolume(from: fromUnit, to: toUnit)
            
        case (.weight, .weight):
            return convertWeightToWeight(from: fromUnit, to: toUnit)
            
        case (.volume, .weight):
            return convertVolumeToWeight(ingredient: ingredient, from: fromUnit, to: toUnit)
            
        case (.weight, .volume):
            return convertWeightToVolume(ingredient: ingredient, from: fromUnit, to: toUnit)
            
        case (.temperature, .temperature):
            // Temperature conversions handled separately
            return nil
            
        default:
            return nil
        }
    }
    
    /// Convert between volume units
    private static func convertVolumeToVolume(from: CookingUnit, to: CookingUnit) -> Double? {
        guard let fromFactor = volumeConversions[from],
              let toFactor = volumeConversions[to] else { return nil }
        return fromFactor / toFactor
    }
    
    /// Convert between weight units
    private static func convertWeightToWeight(from: CookingUnit, to: CookingUnit) -> Double? {
        guard let fromFactor = weightConversions[from],
              let toFactor = weightConversions[to] else { return nil }
        return fromFactor / toFactor
    }
    
    /// Convert volume to weight using ingredient density
    private static func convertVolumeToWeight(
        ingredient: IngredientType,
        from: CookingUnit,
        to: CookingUnit
    ) -> Double? {
        let density = ingredient.gramsPerCup
        
        guard let volumeInML = volumeConversions[from],
              let weightFactor = weightConversions[to] else { return nil }
        
        // Convert: volume → ml → grams (via density) → target weight unit
        let gramsPerFromUnit = (volumeInML / 240.0) * density  // density is per cup (240ml)
        return gramsPerFromUnit / weightFactor
    }
    
    /// Convert weight to volume using ingredient density
    private static func convertWeightToVolume(
        ingredient: IngredientType,
        from: CookingUnit,
        to: CookingUnit
    ) -> Double? {
        let density = ingredient.gramsPerCup
        
        guard let weightInGrams = weightConversions[from],
              let volumeFactor = volumeConversions[to] else { return nil }
        
        // Convert: weight → grams → ml (via density) → target volume unit
        let mlPerFromUnit = (weightInGrams / density) * 240.0  // density is per cup (240ml)
        return mlPerFromUnit / volumeFactor
    }
    
    /// Calculate confidence score for a conversion
    internal static func getConfidence(
        from: CookingUnit,
        to: CookingUnit,
        ingredient: IngredientType
    ) -> Double {
        let fromType = from.measurementType
        let toType = to.measurementType
        
        switch (fromType, toType) {
        case (.volume, .volume), (.weight, .weight):
            return 0.98  // High confidence for same-type conversions
            
        case (.volume, .weight), (.weight, .volume):
            // Lower confidence for volume/weight - depends on packing, humidity, etc.
            switch ingredient {
            case .water, .milk, .oil, .cream, .honey, .mapleSyrup, .vanillaExtract:
                return 0.95  // Liquids are very consistent
            case .allPurposeFlour, .granulatedSugar, .salt:
                return 0.85  // Common ingredients, well-established measurements
            case .brownSugar, .powderedSugar:
                return 0.75  // Packing method affects density significantly
            case .butter, .coconutOil:
                return 0.80  // Temperature affects measurement
            case .cocoaPowder:
                return 0.70  // Very light, prone to air pockets
            default:
                return 0.75  // Other ingredients have moderate variability
            }
            
        case (.temperature, .temperature):
            return 0.99  // Temperature conversions are mathematical
            
        default:
            return 0.50  // Cross-type conversions not supported well
        }
    }
    
    /// Generate helpful notes about the conversion
    internal static func generateNotes(
        from: CookingUnit,
        to: CookingUnit,
        ingredient: IngredientType
    ) -> String? {
        let fromType = from.measurementType
        let toType = to.measurementType
        
        guard fromType != toType else { return nil }
        
        var notes: [String] = []
        
        // Add ingredient-specific notes
        if let measurementNote = ingredient.measurementNotes {
            notes.append(measurementNote)
        }
        
        // Add conversion-specific notes
        switch ingredient {
        case .brownSugar:
            if fromType == .volume {
                notes.append("Assumes firmly packed brown sugar")
            }
        case .butter:
            if fromType == .volume {
                notes.append("Assumes room temperature butter")
            }
        case .honey, .mapleSyrup:
            notes.append("Liquid measurement")
        case .cocoaPowder:
            if fromType == .volume {
                notes.append("Sift cocoa powder for most accurate measurement")
            }
        case .allPurposeFlour, .breadFlour, .cakeFlour, .wholeWheatFlour:
            if fromType == .volume {
                notes.append("Assumes spooned and leveled flour (not scooped)")
            }
        default:
            break
        }
        
        // Add general conversion notes
        if fromType == .volume && toType == .weight {
            notes.append("Weight measurements are more accurate for baking")
        } else if fromType == .weight && toType == .volume {
            notes.append("Volume measurement may vary based on packing method")
        }
        
        return notes.isEmpty ? nil : notes.joined(separator: ". ")
    }
    
}
