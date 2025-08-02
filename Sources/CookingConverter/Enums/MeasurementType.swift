//
//  MeasurementType.swift
//  CookingConverter
//
//  Created by David Sherlock on 02/08/2025.
//


import Foundation

/// Categories of cooking measurements.
///
/// Cooking involves different types of measurements that behave differently
/// in conversions and have different precision requirements.
public enum MeasurementType: String, CaseIterable, Sendable {
    /// Volume measurements (cups, milliliters, tablespoons)
    case volume = "volume"
    
    /// Weight measurements (grams, ounces, pounds)
    case weight = "weight"
    
    /// Temperature measurements (Fahrenheit, Celsius)
    case temperature = "temperature"
    
    /// Count or serving measurements (pieces, servings)
    case quantity = "quantity"
    
    /// Human-readable description
    public var description: String {
        switch self {
        case .volume:
            return "Volume (cups, ml, tbsp)"
        case .weight:
            return "Weight (grams, ounces, lbs)"
        case .temperature:
            return "Temperature (°F, °C)"
        case .quantity:
            return "Quantity (pieces, servings)"
        }
    }
}