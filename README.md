# Swift Cooking Converter

A comprehensive Swift package for converting cooking measurements with ingredient-specific accuracy. Perfect for recipe apps, cooking applications, and international culinary platforms.

## Features

- 🍳 **Ingredient-Specific Conversions** - Different ingredients have different densities (flour ≠ sugar ≠ butter)
- 📏 **Volume ↔ Weight Conversions** - Convert cups to grams, tablespoons to ounces with precision
- 🌡️ **Temperature Conversions** - Fahrenheit ↔ Celsius for cooking temperatures
- 📖 **Recipe Scaling** - Scale entire recipes while maintaining proper ratios
- 🎯 **Confidence Scoring** - Get reliability indicators for conversion accuracy
- 🛡️ **Thread-Safe** - Concurrency-safe implementation for modern Swift
- 📱 **Cross-Platform** - Supports iOS, macOS, tvOS, and watchOS
- 🗣️ **App Intent Ready** - Perfect for Siri integration and voice commands

## Installation

### Swift Package Manager

Add CookingConverter to your project using Xcode or by adding it to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/arraypress/swift-cooking-converter.git", from: "1.0.0")
]
```

## Quick Start

```swift
import CookingConverter

// Convert flour from cups to grams (120g per cup for flour)
let flour = CookingConverter.convert(
    amount: 2.0,
    ingredient: .allPurposeFlour,
    from: .cups,
    to: .grams
)
// Result: 240.0 grams

// Convert sugar (different density - 200g per cup)
let sugar = CookingConverter.convert(
    amount: 1.0,
    ingredient: .granulatedSugar,
    from: .cups,
    to: .grams
)
// Result: 200.0 grams
```

## Usage Examples

### Basic Conversions

```swift
// Volume to volume
let milliliters = CookingConverter.convert(
    amount: 1.0, ingredient: .water, from: .cups, to: .milliliters
)
// 240.0 ml

// Weight to weight
let grams = CookingConverter.convert(
    amount: 8.0, ingredient: .allPurposeFlour, from: .ounces, to: .grams
)
// 226.8 grams

// Temperature conversion
let celsius = CookingConverter.convertTemperature(350, from: .fahrenheit, to: .celsius)
// 176.67°C
```

### Ingredient-Specific Density Conversions

```swift
// Different ingredients have different densities
let flourWeight = CookingConverter.convert(
    amount: 1.0, ingredient: .allPurposeFlour, from: .cups, to: .grams
)
// 120.0 grams (flour is light)

let sugarWeight = CookingConverter.convert(
    amount: 1.0, ingredient: .granulatedSugar, from: .cups, to: .grams
)
// 200.0 grams (sugar is denser)

let honeyWeight = CookingConverter.convert(
    amount: 1.0, ingredient: .honey, from: .cups, to: .grams
)
// 340.0 grams (honey is very dense)
```

### Detailed Conversions with Metadata

```swift
let result = CookingConverter.convertWithDetails(
    amount: 1.0,
    ingredient: .brownSugar,
    from: .cups,
    to: .grams
)

print("Converted: \(result.convertedAmount ?? 0) grams")
print("Confidence: \(result.confidence)")
print("Notes: \(result.notes ?? "None")")
// Output: "Assumes firmly packed brown sugar. Weight measurements are more accurate for baking"
```

### Recipe Scaling

```swift
let originalIngredients = [
    RecipeIngredient(name: "flour", amount: 2.0, unit: .cups),
    RecipeIngredient(name: "sugar", amount: 1.0, unit: .cups),
    RecipeIngredient(name: "butter", amount: 0.5, unit: .cups),
    RecipeIngredient(name: "eggs", amount: 2.0, unit: .pieces)
]

// Scale from 4 servings to 6 servings
let scaledRecipe = CookingConverter.scaleRecipe(
    ingredients: originalIngredients,
    from: 4,
    to: 6
)
// Results in 1.5x amounts: 3 cups flour, 1.5 cups sugar, etc.
```

### Convenience Methods

```swift
// Quick conversions for common baking needs
let flourGrams = CookingConverter.flourCupsToGrams(2.0)        // 240.0g
let sugarGrams = CookingConverter.sugarCupsToGrams(1.0)        // 200.0g
let butterGrams = CookingConverter.butterCupsToGrams(0.5)      // 113.5g

// Temperature helpers
let celsius = CookingConverter.fahrenheitToCelsius(350)        // 176.67°C
let fahrenheit = CookingConverter.celsiusToFahrenheit(180)     // 356.0°F
```

## Supported Ingredients

### Flours & Starches
- **All-Purpose Flour**: 120g per cup
- **Bread Flour**: 127g per cup (higher protein = denser)
- **Cake Flour**: 114g per cup (finer texture = lighter)
- **Whole Wheat Flour**: 113g per cup
- **Cornstarch**: 120g per cup

### Sugars & Sweeteners
- **Granulated Sugar**: 200g per cup
- **Brown Sugar**: 213g per cup (packed)
- **Powdered Sugar**: 120g per cup
- **Honey**: 340g per cup
- **Maple Syrup**: 322g per cup

### Fats & Oils
- **Butter**: 227g per cup (2 sticks)
- **Vegetable Oil**: 218g per cup
- **Coconut Oil**: 205g per cup

### Liquids
- **Water**: 240g per cup (reference standard)
- **Milk**: 245g per cup
- **Heavy Cream**: 240g per cup

### Nuts & Seeds
- **Almonds**: 143g per cup (whole)
- **Walnuts**: 117g per cup
- **Sesame Seeds**: 144g per cup

### Baking Ingredients
- **Cocoa Powder**: 75g per cup
- **Baking Powder**: 192g per cup
- **Salt**: 292g per cup
- **Vanilla Extract**: 208g per cup

## Supported Units

### Volume Units
- **US**: cups, tablespoons (tbsp), teaspoons (tsp), fluid ounces (fl oz)
- **Metric**: milliliters (ml), liters (l)

### Weight Units
- **US/Imperial**: ounces (oz), pounds (lbs)
- **Metric**: grams (g), kilograms (kg)

### Temperature Units
- **Fahrenheit** (°F) ↔ **Celsius** (°C)

### Quantity Units
- **Pieces**, **Servings** (for recipe scaling)

## API Reference

### Core Methods

#### `convert(amount:ingredient:from:to:)`
Basic conversion with simple result.

```swift
let result = CookingConverter.convert(
    amount: 1.0,
    ingredient: .allPurposeFlour,
    from: .cups,
    to: .grams
)
```

#### `convertWithDetails(amount:ingredient:from:to:)`
Detailed conversion with confidence scores and notes.

```swift
let result = CookingConverter.convertWithDetails(
    amount: 1.0,
    ingredient: .brownSugar,
    from: .cups,
    to: .grams
)
```

#### `scaleRecipe(ingredients:from:to:)`
Scale entire recipes proportionally.

```swift
let scaled = CookingConverter.scaleRecipe(
    ingredients: originalIngredients,
    from: 4,
    to: 6
)
```

#### `convertTemperature(_:from:to:)`
Convert cooking temperatures.

```swift
let celsius = CookingConverter.convertTemperature(350, from: .fahrenheit, to: .celsius)
```

#### `conversionInfo()`
Get comprehensive information about converter capabilities.

### Confidence Levels

- **0.95-1.0** - Very reliable (same-type conversions, liquids)
- **0.85-0.94** - Reliable (common ingredients, established densities)
- **0.75-0.84** - Good (some packing variation)
- **0.70-0.79** - Moderate (packing-dependent ingredients)
- **0.50-0.69** - Lower confidence (high variability)

### Error Handling

```swift
let result = CookingConverter.convertWithDetails(
    amount: -1.0,
    ingredient: .allPurposeFlour,
    from: .cups,
    to: .grams
)

if !result.isSuccess {
    switch result.error {
    case .invalidAmount(let amount):
        print("Invalid amount: \(amount)")
    case .unsupportedConversion(let from, let to, let ingredient):
        print("Can't convert \(ingredient) from \(from) to \(to)")
    default:
        print("Conversion failed")
    }
}
```

## App Intent Integration

Perfect for Siri and Shortcuts integration:

```swift
import AppIntents

struct ConvertCookingMeasurementIntent: AppIntent {
    static var title: LocalizedStringResource = "Convert Cooking Measurement"
    
    @Parameter(title: "Amount") var amount: Double
    @Parameter(title: "Ingredient") var ingredient: IngredientType
    @Parameter(title: "From Unit") var fromUnit: CookingUnit
    @Parameter(title: "To Unit") var toUnit: CookingUnit
    
    func perform() async throws -> some IntentResult {
        let result = CookingConverter.convert(
            amount: amount,
            ingredient: ingredient,
            from: fromUnit,
            to: toUnit
        )
        
        let message = "\(amount) \(fromUnit.rawValue) of \(ingredient.description) is \(result ?? 0) \(toUnit.rawValue)"
        return .result(value: message)
    }
}
```

**Voice Commands:**
- *"Hey Siri, convert 2 cups of flour to grams"*
- *"Hey Siri, what's 350 Fahrenheit in Celsius?"*
- *"Hey Siri, how much does 1 cup of sugar weigh?"*

## Measurement Standards

All conversions are based on:

- **US cup standard**: 240ml volume
- **Standard measurement techniques**: Spooned and leveled for flour, packed for brown sugar
- **Room temperature ingredients**: Unless otherwise noted
- **Professional culinary references**: Industry-standard density values

## Accuracy Notes

Volume-to-weight conversions can vary based on:

- **Packing method** - Sifted vs scooped flour affects density
- **Humidity** - Affects flour and sugar measurements  
- **Temperature** - Affects butter and oil measurements
- **Brand variations** - Different processing methods
- **Measurement technique** - Spooning vs scooping makes a difference

The library provides confidence scores and helpful notes to indicate conversion reliability.

## Performance

CookingConverter is optimized for performance:

- **Basic conversion**: ~0.001ms per conversion
- **Detailed conversion**: ~0.002ms (includes metadata generation)
- **Recipe scaling**: ~0.1ms for 100 ingredients
- **Memory usage**: ~50KB for conversion tables
- **Thread-safe**: No performance penalty for concurrent access

## Requirements

- iOS 13.0+ / macOS 10.15+ / tvOS 13.0+ / watchOS 6.0+
- Swift 6.1+
- Xcode 16.0+

## Why Ingredient-Specific Conversions Matter

Generic unit converters can't handle the fact that different ingredients have vastly different densities:

```swift
// ❌ Generic converter would assume all ingredients are the same
1 cup = 240ml = 240g (WRONG for most ingredients!)

// ✅ CookingConverter knows ingredient densities
1 cup flour = 240ml = 120g ✓
1 cup sugar = 240ml = 200g ✓
1 cup honey = 240ml = 340g ✓
```

This accuracy is crucial for successful baking and cooking, especially when converting international recipes.

## Common Cooking Conversions

### Baking Temperatures
- **325°F** = 163°C (slow baking)
- **350°F** = 177°C (standard baking)
- **375°F** = 190°C (moderate high)
- **425°F** = 218°C (hot oven)

### Butter Measurements
- **1 stick** = 8 tablespoons = 1/2 cup = 113g
- **2 sticks** = 1 cup = 227g

### Flour Guidelines
- **All-purpose**: 120g per cup (spooned and leveled)
- **Bread flour**: 127g per cup (higher protein)
- **Cake flour**: 114g per cup (lighter, finer)

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

### Development Setup

```bash
git clone https://github.com/arraypress/swift-cooking-converter.git
cd swift-cooking-converter
swift test
```

### Adding New Ingredients

1. Add ingredient to `IngredientType` enum with density data
2. Add to appropriate `IngredientCategory`
3. Include alternative names for parsing
4. Add comprehensive tests
5. Update documentation

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Credits

- **Culinary Institute of America** - Professional measurement standards
- **King Arthur Baking** - Ingredient density references
- **USDA** - Standard ingredient classifications
- **International Association of Culinary Professionals** - Measurement best practices

---

**Made with ❤️ for precise, delicious cooking**
