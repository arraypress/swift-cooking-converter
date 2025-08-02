//
//  represents.swift
//  CookingConverter
//
//  Created by David Sherlock on 02/08/2025.
//


import Foundation

/// Comprehensive database of cooking ingredients with density information.
///
/// This enum represents common cooking ingredients with their specific density characteristics
/// for accurate volume-to-weight conversions. Each ingredient has carefully measured density
/// values based on standard cooking measurement techniques and industry references.
///
/// ## Density Variations
///
/// Ingredient densities can vary based on:
/// - **Packing method**: Sifted vs scooped flour, packed vs loose brown sugar
/// - **Humidity**: Affects flour and sugar measurements
/// - **Temperature**: Affects butter and oil measurements
/// - **Brand variations**: Different processing methods
/// - **Ingredient age**: Fresh vs aged ingredients
///
/// ## Measurement Standards
///
/// All density values are based on:
/// - **US cup measurements** (240ml volume)
/// - **Standard measurement techniques** (spooned and leveled for flour, packed for brown sugar)
/// - **Room temperature** ingredients unless otherwise noted
/// - **Professional culinary references** and food industry standards
///
/// ## Example Usage
///
/// ```swift
/// // Different ingredients have vastly different densities
/// let flourWeight = IngredientType.allPurposeFlour.gramsPerCup // 120g
/// let sugarWeight = IngredientType.granulatedSugar.gramsPerCup // 200g
/// let butterWeight = IngredientType.butter.gramsPerCup // 227g
/// ```
public enum IngredientType: String, CaseIterable, Sendable {
    
    // MARK: - Flours and Starches
    
    /// All-purpose flour, spooned and leveled (not scooped)
    ///
    /// **Density**: 120g per cup
    /// **Notes**: Most common flour type, moderate protein content (10-12%)
    /// **Measurement tip**: Spoon flour into measuring cup and level with knife
    case allPurposeFlour = "all-purpose flour"
    
    /// Bread flour, higher protein content for gluten development
    ///
    /// **Density**: 127g per cup
    /// **Notes**: Higher protein (12-14%) makes it slightly denser than all-purpose
    /// **Use**: Yeast breads, pizza dough, artisan breads
    case breadFlour = "bread flour"
    
    /// Cake flour, finely milled for tender cakes
    ///
    /// **Density**: 114g per cup
    /// **Notes**: Lower protein (6-8%), finer texture makes it less dense
    /// **Use**: Delicate cakes, pastries, biscuits
    case cakeFlour = "cake flour"
    
    /// Whole wheat flour, includes bran and germ
    ///
    /// **Density**: 113g per cup
    /// **Notes**: Heavier ingredients but absorbs more liquid
    /// **Use**: Whole grain breads, healthy baking
    case wholeWheatFlour = "whole wheat flour"
    
    /// Cornstarch, fine white powder for thickening
    ///
    /// **Density**: 120g per cup
    /// **Notes**: Very fine powder, used for thickening sauces
    /// **Use**: Thickening, tenderizing baked goods
    case cornstarch = "cornstarch"
    
    // MARK: - Sugars and Sweeteners
    
    /// Granulated white sugar, standard table sugar
    ///
    /// **Density**: 200g per cup
    /// **Notes**: Free-flowing crystals, most common sugar type
    /// **Use**: General baking, beverages, preserving
    case granulatedSugar = "granulated sugar"
    
    /// Brown sugar, packed measurement
    ///
    /// **Density**: 213g per cup
    /// **Notes**: Contains molasses, should be firmly packed when measuring
    /// **Measurement tip**: Press into measuring cup until level
    case brownSugar = "brown sugar"
    
    /// Powdered sugar (confectioner's sugar), very fine powder
    ///
    /// **Density**: 120g per cup
    /// **Notes**: Contains cornstarch, very light and airy
    /// **Use**: Icings, dustings, delicate desserts
    case powderedSugar = "powdered sugar"
    
    /// Honey, liquid sweetener
    ///
    /// **Density**: 340g per cup
    /// **Notes**: Dense liquid, warmer honey flows more easily
    /// **Measurement tip**: Lightly oil measuring cup for easy release
    case honey = "honey"
    
    /// Pure maple syrup, liquid sweetener
    ///
    /// **Density**: 322g per cup
    /// **Notes**: Less dense than honey, grade affects flavor not weight
    /// **Use**: Pancakes, baking, glazes
    case mapleSyrup = "maple syrup"
    
    // MARK: - Fats and Oils
    
    /// Butter, room temperature
    ///
    /// **Density**: 227g per cup (equivalent to 2 standard sticks)
    /// **Notes**: Temperature affects measurement accuracy
    /// **Measurement tip**: Use stick markings or room temperature for cups
    case butter = "butter"
    
    /// Vegetable oil, liquid at room temperature
    ///
    /// **Density**: 218g per cup
    /// **Notes**: Most liquid oils have similar density
    /// **Use**: Baking, frying, salad dressings
    case oil = "oil"
    
    /// Coconut oil, solid at room temperature
    ///
    /// **Density**: 205g per cup
    /// **Notes**: Melts at 76°F, measure solid unless recipe specifies melted
    /// **Use**: Baking, healthy cooking
    case coconutOil = "coconut oil"
    
    // MARK: - Liquids
    
    /// Water, reference liquid
    ///
    /// **Density**: 240g per cup
    /// **Notes**: Standard reference for liquid measurements
    /// **Use**: Baking, cooking, beverages
    case water = "water"
    
    /// Milk, whole milk standard
    ///
    /// **Density**: 245g per cup
    /// **Notes**: Slightly denser than water due to proteins and fats
    /// **Use**: Baking, beverages, sauces
    case milk = "milk"
    
    /// Heavy cream, high fat content
    ///
    /// **Density**: 240g per cup
    /// **Notes**: Fat content varies by brand (35-40%)
    /// **Use**: Whipping, rich sauces, desserts
    case cream = "cream"
    
    // MARK: - Nuts and Seeds
    
    /// Whole almonds, raw
    ///
    /// **Density**: 143g per cup
    /// **Notes**: Whole nuts, sliced or chopped will pack differently
    /// **Use**: Snacking, baking, almond flour preparation
    case almonds = "almonds"
    
    /// Walnut halves, raw
    ///
    /// **Density**: 117g per cup
    /// **Notes**: Irregular shapes create air pockets
    /// **Use**: Baking, salads, snacking
    case walnuts = "walnuts"
    
    /// Sesame seeds, raw
    ///
    /// **Density**: 144g per cup
    /// **Notes**: Small seeds pack efficiently
    /// **Use**: Baking, cooking, garnishes
    case sesameSeeds = "sesame seeds"
    
    // MARK: - Baking Ingredients
    
    /// Unsweetened cocoa powder, Dutch-processed or natural
    ///
    /// **Density**: 75g per cup
    /// **Notes**: Very light powder, sift before measuring for accuracy
    /// **Use**: Chocolate baking, beverages
    case cocoaPowder = "cocoa powder"
    
    /// Baking powder, double-acting
    ///
    /// **Density**: 192g per cup
    /// **Notes**: Denser than most powders due to chemical components
    /// **Use**: Leavening agent for cakes and quick breads
    case bakingPowder = "baking powder"
    
    /// Table salt, fine crystals
    ///
    /// **Density**: 292g per cup
    /// **Notes**: Very dense, kosher salt and sea salt have different densities
    /// **Use**: Seasoning, baking, preserving
    case salt = "salt"
    
    /// Pure vanilla extract, alcohol-based
    ///
    /// **Density**: 208g per cup
    /// **Notes**: Alcohol content affects density
    /// **Use**: Flavoring for baked goods and desserts
    case vanillaExtract = "vanilla extract"
    
    /// Human-readable description of the ingredient
    public var description: String {
        return rawValue.capitalized
    }
    
    /// Density in grams per US cup (240ml)
    ///
    /// These values are based on standard cooking measurement techniques:
    /// - Flour: spooned and leveled (not scooped)
    /// - Brown sugar: firmly packed
    /// - Butter: room temperature
    /// - Liquids: measured in liquid measuring cup
    public var gramsPerCup: Double {
        switch self {
        // Flours & Starches
        case .allPurposeFlour: return 120
        case .breadFlour: return 127
        case .cakeFlour: return 114
        case .wholeWheatFlour: return 113
        case .cornstarch: return 120
        
        // Sugars
        case .granulatedSugar: return 200
        case .brownSugar: return 213      // packed
        case .powderedSugar: return 120
        case .honey: return 340
        case .mapleSyrup: return 322
        
        // Fats
        case .butter: return 227          // 2 sticks
        case .oil: return 218
        case .coconutOil: return 205
        
        // Liquids
        case .water: return 240           // reference standard
        case .milk: return 245
        case .cream: return 240
        
        // Nuts (whole)
        case .almonds: return 143
        case .walnuts: return 117
        case .sesameSeeds: return 144
        
        // Baking ingredients
        case .cocoaPowder: return 75      // unsweetened
        case .bakingPowder: return 192
        case .salt: return 292            // table salt
        case .vanillaExtract: return 208
        }
    }
    
    /// Category this ingredient belongs to
    public var category: IngredientCategory {
        switch self {
        case .allPurposeFlour, .breadFlour, .cakeFlour, .wholeWheatFlour, .cornstarch:
            return .flours
        case .granulatedSugar, .brownSugar, .powderedSugar, .honey, .mapleSyrup:
            return .sugars
        case .butter, .oil, .coconutOil:
            return .fats
        case .water, .milk, .cream:
            return .liquids
        case .almonds, .walnuts, .sesameSeeds:
            return .nuts
        case .cocoaPowder, .bakingPowder, .salt, .vanillaExtract:
            return .baking
        }
    }
    
    /// Common alternative names for this ingredient
    public var alternativeNames: [String] {
        switch self {
        case .allPurposeFlour:
            return ["flour", "ap flour", "plain flour", "white flour"]
        case .breadFlour:
            return ["strong flour", "high gluten flour"]
        case .cakeFlour:
            return ["soft flour", "pastry flour"]
        case .wholeWheatFlour:
            return ["whole meal flour", "graham flour", "brown flour"]
        case .cornstarch:
            return ["corn starch", "cornflour", "corn flour"]
        case .granulatedSugar:
            return ["sugar", "white sugar", "caster sugar", "superfine sugar"]
        case .brownSugar:
            return ["brown", "light brown sugar", "dark brown sugar"]
        case .powderedSugar:
            return ["confectioners sugar", "icing sugar", "10x sugar", "powdered"]
        case .honey:
            return ["liquid honey", "clover honey", "wildflower honey"]
        case .mapleSyrup:
            return ["pure maple syrup", "maple", "grade a maple syrup"]
        case .butter:
            return ["unsalted butter", "salted butter", "sweet butter"]
        case .oil:
            return ["vegetable oil", "canola oil", "neutral oil"]
        case .coconutOil:
            return ["virgin coconut oil", "refined coconut oil"]
        case .water:
            return ["filtered water", "tap water"]
        case .milk:
            return ["whole milk", "2% milk", "dairy milk"]
        case .cream:
            return ["heavy cream", "whipping cream", "double cream"]
        case .almonds:
            return ["whole almonds", "raw almonds"]
        case .walnuts:
            return ["walnut halves", "english walnuts"]
        case .sesameSeeds:
            return ["sesame", "white sesame seeds"]
        case .cocoaPowder:
            return ["cocoa", "unsweetened cocoa", "dutch cocoa"]
        case .bakingPowder:
            return ["baking pwd", "double acting baking powder"]
        case .salt:
            return ["table salt", "fine salt", "iodized salt"]
        case .vanillaExtract:
            return ["vanilla", "pure vanilla", "vanilla essence"]
        }
    }
    
    /// Measurement notes and tips for this ingredient
    public var measurementNotes: String? {
        switch self {
        case .allPurposeFlour:
            return "Spoon into measuring cup and level with knife. Do not scoop or pack."
        case .brownSugar:
            return "Pack firmly into measuring cup until level with rim."
        case .butter:
            return "Use stick markings or measure at room temperature for accuracy."
        case .honey, .mapleSyrup:
            return "Lightly oil measuring cup for easy release."
        case .cocoaPowder:
            return "Sift before measuring for most accurate results."
        case .powderedSugar:
            return "May need sifting if lumpy. Measure after sifting."
        default:
            return nil
        }
    }
}