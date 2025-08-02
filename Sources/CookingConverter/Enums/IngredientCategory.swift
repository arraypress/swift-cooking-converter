//
//  IngredientCategory.swift
//  CookingConverter
//
//  Created by David Sherlock on 02/08/2025.
//

import Foundation

/// Categories for grouping related ingredients
public enum IngredientCategory: String, CaseIterable, Sendable {
    case flours = "Flours & Starches"
    case sugars = "Sugars & Sweeteners"
    case fats = "Fats & Oils"
    case liquids = "Liquids"
    case nuts = "Nuts & Seeds"
    case baking = "Baking Ingredients"
    
    /// Ingredients in this category
    public var ingredients: [IngredientType] {
        return IngredientType.allCases.filter { $0.category == self }
    }
}
