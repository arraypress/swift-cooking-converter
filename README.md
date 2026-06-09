# Swift Cooking Converter

A comprehensive Swift package for converting cooking measurements with ingredient-specific accuracy. Unlike generic unit converters, it accounts for the density of each ingredient, enabling reliable volume ↔ weight conversions (cups to grams, tablespoons to ounces, and more) across 30+ common ingredients, with recipe scaling, temperature conversion, and confidence scoring.

## Features

- 🥄 **Ingredient-specific conversions** — densities for 23+ ingredients across flours, sugars, fats, liquids, nuts, and baking staples
- ⚖️ **Volume ↔ weight** — convert cups to grams, tablespoons to ounces, and back
- 🔁 **Volume & weight units** — cups, tablespoons, teaspoons, milliliters, liters, fluid ounces, grams, kilograms, ounces, pounds
- 🌡️ **Temperature conversion** — Fahrenheit ↔ Celsius for oven and candy temperatures
- 📐 **Recipe scaling** — proportionally scale ingredient lists between serving counts
- 📊 **Confidence scoring** — detailed results report reliability and helpful notes
- ❗ **Error reporting** — typed errors for invalid amounts and unsupported conversions
- 🌍 **System metadata** — US, Metric, and Imperial systems exposed via capability info
- 🧵 **Sendable models** — value types ready for concurrent use

## Requirements

- iOS 13.0+ / macOS 10.15+ / tvOS 13.0+ / watchOS 6.0+
- Swift 6.1+
- Xcode 16.0+

## Installation

### Swift Package Manager

```swift
dependencies: [
    .package(url: "https://github.com/arraypress/swift-cooking-converter.git", from: "1.0.0")
]
```

## Usage

### Basic Conversion

```swift
import CookingConverter

let flourGrams = CookingConverter.convert(
    amount: 2.0,
    ingredient: .allPurposeFlour,
    from: .cups,
    to: .grams
)
// 240.0 (flour is ~120g per cup)

let sugarGrams = CookingConverter.convert(
    amount: 1.0,
    ingredient: .granulatedSugar,
    from: .cups,
    to: .grams
)
// 200.0 (sugar is denser)
```

### Detailed Conversion

```swift
import CookingConverter

let result = CookingConverter.convertWithDetails(
    amount: 1.0,
    ingredient: .brownSugar,
    from: .cups,
    to: .grams
)

if result.isSuccess {
    print("Result:", result.convertedAmount ?? 0)
    print("Confidence:", result.confidence)
    print("Notes:", result.notes ?? "None")
}
```

### Temperature Conversion

```swift
import CookingConverter

let celsius = CookingConverter.convertTemperature(350, from: .fahrenheit, to: .celsius)
// ~176.67

let fahrenheit = CookingConverter.convertTemperature(180, from: .celsius, to: .fahrenheit)
// 356.0
```

### Recipe Scaling

```swift
import CookingConverter

let ingredients = [
    RecipeIngredient(name: "flour", amount: 2.0, unit: .cups),
    RecipeIngredient(name: "sugar", amount: 1.0, unit: .cups),
    RecipeIngredient(name: "butter", amount: 0.5, unit: .cups)
]

let scaled = CookingConverter.scaleRecipe(ingredients: ingredients, from: 4, to: 6)
// 1.5x amounts: 3 cups flour, 1.5 cups sugar, 0.75 cups butter
```

### Capability Info

```swift
import CookingConverter

let info = CookingConverter.conversionInfo()
print(info.supportedIngredients.count)
print(info.supportedUnits.count)
print(info.totalConversions)
```

## How It Works

`CookingConverter` looks up a per-ingredient density (grams per cup) to bridge volume and weight units, falling back to direct conversion factors for same-type conversions. Each conversion returns a confidence score and notes reflecting how packing- and humidity-dependent the result is, so callers can surface that reliability to users.

## Models

### `CookingConversionResult`

| Property | Type | Description |
|----------|------|-------------|
| `originalAmount` | `Double` | The input amount |
| `convertedAmount` | `Double?` | The converted amount, or nil on failure |
| `ingredient` | `IngredientType` | The ingredient converted |
| `fromUnit` | `CookingUnit` | Source unit |
| `toUnit` | `CookingUnit` | Target unit |
| `confidence` | `Double` | Confidence of the conversion (0.0–1.0) |
| `error` | `CookingConversionError?` | Error if the conversion failed |
| `notes` | `String?` | Notes about reliability or context |
| `isSuccess` | `Bool` | Whether the conversion succeeded (computed) |

### `RecipeIngredient`

| Property | Type | Description |
|----------|------|-------------|
| `name` | `String` | Ingredient name |
| `amount` | `Double` | Quantity |
| `unit` | `CookingUnit` | Measurement unit |
| `notes` | `String?` | Optional preparation notes |

### `CookingConversionInfo`

| Property | Type | Description |
|----------|------|-------------|
| `supportedIngredients` | `[IngredientType]` | All supported ingredients |
| `supportedUnits` | `[CookingUnit]` | All supported units |
| `supportedSystems` | `[CookingSystem]` | US, Metric, Imperial |
| `conversionTypes` | `[MeasurementType]` | Volume, weight, temperature, quantity |
| `description` | `String` | Description of the converter |
| `totalConversions` | `Int` | Total possible conversions (computed) |

## Use Cases

- Recipe and meal-planning apps
- Cooking and baking utilities
- International culinary platforms needing metric/imperial parity
- Kitchen automation and Shortcuts integrations

## Testing

```bash
swift test
```

The test suite covers ingredient-specific volume/weight conversions, temperature conversion, recipe scaling, error handling for invalid inputs, and confidence scoring.

## License

MIT License — see LICENSE file for details.

## Author

Created by David Sherlock ([ArrayPress](https://github.com/arraypress)) in 2026.
