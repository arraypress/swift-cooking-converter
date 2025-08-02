//
//  CookingUnit.swift
//  CookingConverter
//
//  Created by David Sherlock on 02/08/2025.
//

import Foundation

/// Comprehensive cooking measurement units.
///
/// Represents all commonly used cooking measurements across different international
/// systems. Each unit belongs to a specific measurement type and has conversion
/// factors for accurate transformations.
///
/// ## Unit Categories
///
/// ### Volume Units
/// - **US**: cups, tablespoons (tbsp), teaspoons (tsp), fluid ounces (fl oz)
/// - **Metric**: milliliters (ml), liters (l)
///
/// ### Weight Units  
/// - **US/Imperial**: ounces (oz), pounds (lbs)
/// - **Metric**: grams (g), kilograms (kg)
///
/// ### Temperature Units
/// - **US**: Fahrenheit (°F)
/// - **Metric**: Celsius (°C)
///
/// ## Usage Examples
///
/// ```swift
/// let volumeUnits = CookingUnit.allCases.filter { $0.measurementType == .volume }
/// let weightUnits = CookingUnit.allCases.filter { $0.measurementType == .weight }
/// ```
public enum CookingUnit: String, CaseIterable, Sendable {
    
    // MARK: - Volume Units
    
    /// US cups (240ml standard)
    case cups = "cups"
    
    /// Tablespoons (15ml standard)
    case tablespoons = "tbsp"
    
    /// Teaspoons (5ml standard)
    case teaspoons = "tsp"
    
    /// Milliliters (metric volume)
    case milliliters = "ml"
    
    /// Liters (metric volume, 1000ml)
    case liters = "l"
    
    /// US fluid ounces (29.5735ml)
    case fluidOunces = "fl oz"
    
    // MARK: - Weight Units
    
    /// Grams (metric weight)
    case grams = "g"
    
    /// Kilograms (metric weight, 1000g)
    case kilograms = "kg"
    
    /// Ounces (28.3495g)
    case ounces = "oz"
    
    /// Pounds (453.592g)
    case pounds = "lbs"
    
    // MARK: - Temperature Units
    
    /// Fahrenheit temperature scale
    case fahrenheit = "°F"
    
    /// Celsius temperature scale
    case celsius = "°C"
    
    // MARK: - Quantity Units
    
    /// Individual pieces or items
    case pieces = "pieces"
    
    /// Recipe servings
    case servings = "servings"
    
    /// The measurement type this unit belongs to
    public var measurementType: MeasurementType {
        switch self {
        case .cups, .tablespoons, .teaspoons, .milliliters, .liters, .fluidOunces:
            return .volume
        case .grams, .kilograms, .ounces, .pounds:
            return .weight
        case .fahrenheit, .celsius:
            return .temperature
        case .pieces, .servings:
            return .quantity
        }
    }
    
    /// Human-readable full name
    public var fullName: String {
        switch self {
        case .cups: return "Cups"
        case .tablespoons: return "Tablespoons"
        case .teaspoons: return "Teaspoons"
        case .milliliters: return "Milliliters"
        case .liters: return "Liters"
        case .fluidOunces: return "Fluid Ounces"
        case .grams: return "Grams"
        case .kilograms: return "Kilograms"
        case .ounces: return "Ounces"
        case .pounds: return "Pounds"
        case .fahrenheit: return "Fahrenheit"
        case .celsius: return "Celsius"
        case .pieces: return "Pieces"
        case .servings: return "Servings"
        }
    }
    
    /// Alternative names and abbreviations for parsing
    public var alternativeNames: [String] {
        switch self {
        case .tablespoons:
            return ["tablespoon", "tbsp", "tb", "T"]
        case .teaspoons:
            return ["teaspoon", "tsp", "t"]
        case .cups:
            return ["cup", "c", "C"]
        case .fluidOunces:
            return ["fl oz", "fluid ounces", "fl. oz.", "fluid oz"]
        case .milliliters:
            return ["milliliter", "mL", "ML"]
        case .liters:
            return ["liter", "litre", "L"]
        case .ounces:
            return ["oz", "ounce"]
        case .pounds:
            return ["lb", "lbs", "pound", "#"]
        case .grams:
            return ["gram", "gr", "G"]
        case .kilograms:
            return ["kilogram", "kg", "KG"]
        case .fahrenheit:
            return ["f", "fahrenheit", "degrees f", "deg f", "°f"]
        case .celsius:
            return ["c", "celsius", "degrees c", "deg c", "°c", "centigrade"]
        case .pieces:
            return ["piece", "pcs", "pc", "each", "item", "items"]
        case .servings:
            return ["serving", "portion", "portions"]
        }
    }
    
    /// Whether this unit is commonly used in professional kitchens
    public var isProfessional: Bool {
        switch self {
        case .grams, .kilograms, .milliliters, .liters, .celsius:
            return true  // Metric units preferred by professional chefs
        case .ounces, .pounds:
            return true  // Weight measurements are precise
        default:
            return false // Volume measurements can be imprecise
        }
    }
    
    /// Typical precision for this unit (decimal places)
    public var typicalPrecision: Int {
        switch measurementType {
        case .weight:
            return 1  // 250.5g, 8.2oz
        case .volume:
            return 2  // 240.25ml, 1.33 cups
        case .temperature:
            return 0  // 350°F, 177°C
        case .quantity:
            return 0  // 2 pieces, 4 servings
        }
    }
    
}
