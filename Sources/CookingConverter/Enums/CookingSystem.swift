//
//  CookingSystem.swift
//  CookingConverter
//
//  Core enums for cooking measurement systems and units
//  Created by David Sherlock on 02/08/2025.
//

import Foundation

/// International cooking measurement systems.
///
/// Different regions use different measurement conventions for cooking and baking.
/// This enum represents the major systems used worldwide.
///
/// ## System Characteristics
///
/// - **US System**: Uses cups, tablespoons, teaspoons, ounces, pounds, Fahrenheit
/// - **Metric System**: Uses milliliters, liters, grams, kilograms, Celsius
/// - **Imperial System**: Uses fluid ounces, pints, ounces, pounds (British measurements)
///
/// ## Regional Usage
///
/// - **United States**: Primarily US system with some metric adoption
/// - **Europe**: Metric system standard
/// - **United Kingdom**: Mixed Imperial and Metric
/// - **Australia/Canada**: Primarily metric with some Imperial legacy
public enum CookingSystem: String, CaseIterable, Sendable {
    
    /// United States measurement system (cups, tablespoons, ounces, Fahrenheit)
    case us = "US"
    
    /// Metric measurement system (milliliters, grams, Celsius)
    case metric = "Metric"
    
    /// Imperial measurement system (fluid ounces, pints, pounds)
    case imperial = "Imperial"
    
    /// Human-readable description of the measurement system
    public var description: String {
        switch self {
        case .us:
            return "United States (cups, tablespoons, ounces, °F)"
        case .metric:
            return "Metric (milliliters, grams, °C)"
        case .imperial:
            return "Imperial (fluid ounces, pints, pounds)"
        }
    }
    
    /// Primary units used in this system
    public var primaryUnits: [CookingUnit] {
        switch self {
        case .us:
            return [.cups, .tablespoons, .teaspoons, .ounces, .pounds, .fahrenheit]
        case .metric:
            return [.milliliters, .liters, .grams, .kilograms, .celsius]
        case .imperial:
            return [.fluidOunces, .ounces, .pounds, .fahrenheit]
        }
    }
    
}
