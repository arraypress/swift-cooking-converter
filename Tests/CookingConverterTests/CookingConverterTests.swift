//
//  CookingConverterTests.swift
//  CookingConverter
//
//  Comprehensive test suite for cooking measurement conversions
//  Created by David Sherlock on 02/08/2025.
//

import XCTest
@testable import CookingConverter

final class CookingConverterTests: XCTestCase {
    
    // MARK: - Helper Methods
    
    /// Helper to assert successful conversion with expected value
    private func assertConversion(
        amount: Double,
        ingredient: IngredientType,
        from: CookingUnit,
        to: CookingUnit,
        expected: Double,
        accuracy: Double = 0.1,
        message: String,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        let result = CookingConverter.convert(amount: amount, ingredient: ingredient, from: from, to: to)
        XCTAssertNotNil(result, "Conversion should succeed: \(message)", file: file, line: line)
        XCTAssertEqual(result!, expected, accuracy: accuracy, message, file: file, line: line)
    }

    /// Helper to assert temperature conversion
    private func assertTemperatureConversion(
        temperature: Double,
        from: CookingUnit,
        to: CookingUnit,
        expected: Double,
        accuracy: Double = 0.1,
        message: String,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        let result = CookingConverter.convertTemperature(temperature, from: from, to: to)
        XCTAssertNotNil(result, "Temperature conversion should succeed: \(message)", file: file, line: line)
        XCTAssertEqual(result!, expected, accuracy: accuracy, message, file: file, line: line)
    }
    
    // MARK: - Basic Conversion Tests
    
    func testBasicVolumeConversions() {
        assertConversion(
            amount: 1.0, ingredient: .water, from: .cups, to: .milliliters,
            expected: 240.0, message: "1 cup should equal 240ml"
        )
        
        assertConversion(
            amount: 1.0, ingredient: .water, from: .tablespoons, to: .teaspoons,
            expected: 3.0, message: "1 tablespoon should equal 3 teaspoons"
        )
        
        assertConversion(
            amount: 1.0, ingredient: .water, from: .fluidOunces, to: .milliliters,
            expected: 29.5735, message: "1 fl oz should equal ~29.57ml"
        )
    }
    
    func testBasicWeightConversions() {
        assertConversion(
            amount: 1.0, ingredient: .allPurposeFlour, from: .ounces, to: .grams,
            expected: 28.3495, message: "1 oz should equal ~28.35g"
        )
        
        assertConversion(
            amount: 1.0, ingredient: .allPurposeFlour, from: .pounds, to: .grams,
            expected: 453.592, message: "1 lb should equal ~453.59g"
        )
        
        assertConversion(
            amount: 1.0, ingredient: .allPurposeFlour, from: .kilograms, to: .grams,
            expected: 1000.0, message: "1 kg should equal 1000g"
        )
    }
    
    func testTemperatureConversions() {
        assertTemperatureConversion(
            temperature: 350, from: .fahrenheit, to: .celsius,
            expected: 176.67, message: "350°F should equal ~176.67°C"
        )
        
        assertTemperatureConversion(
            temperature: 180, from: .celsius, to: .fahrenheit,
            expected: 356.0, message: "180°C should equal 356°F"
        )
        
        assertTemperatureConversion(
            temperature: 100, from: .celsius, to: .celsius,
            expected: 100.0, message: "Same unit should return same value"
        )
        
        assertTemperatureConversion(
            temperature: 375, from: .fahrenheit, to: .celsius,
            expected: 190.56, message: "375°F should equal ~190.56°C"
        )
    }
    
    // MARK: - Ingredient-Specific Conversion Tests
    
    func testFlourConversions() {
        // All-purpose flour: 120g per cup
        assertConversion(
            amount: 1.0, ingredient: .allPurposeFlour, from: .cups, to: .grams,
            expected: 120.0, message: "1 cup all-purpose flour should equal 120g"
        )
        
        // Test reverse conversion
        assertConversion(
            amount: 240.0, ingredient: .allPurposeFlour, from: .grams, to: .cups,
            expected: 2.0, message: "240g flour should equal 2 cups"
        )
        
        // Different flour types have different densities
        assertConversion(
            amount: 1.0, ingredient: .breadFlour, from: .cups, to: .grams,
            expected: 127.0, message: "1 cup bread flour should equal 127g"
        )
        
        assertConversion(
            amount: 1.0, ingredient: .cakeFlour, from: .cups, to: .grams,
            expected: 114.0, message: "1 cup cake flour should equal 114g"
        )
    }
    
    func testSugarConversions() {
        // Granulated sugar: 200g per cup
        assertConversion(
            amount: 1.0, ingredient: .granulatedSugar, from: .cups, to: .grams,
            expected: 200.0, message: "1 cup granulated sugar should equal 200g"
        )
        
        // Brown sugar is denser: 213g per cup
        assertConversion(
            amount: 1.0, ingredient: .brownSugar, from: .cups, to: .grams,
            expected: 213.0, message: "1 cup brown sugar should equal 213g"
        )
        
        // Powdered sugar is lighter: 120g per cup
        assertConversion(
            amount: 1.0, ingredient: .powderedSugar, from: .cups, to: .grams,
            expected: 120.0, message: "1 cup powdered sugar should equal 120g"
        )
    }
    
    func testLiquidConversions() {
        // Water: 240g per cup (reference)
        assertConversion(
            amount: 1.0, ingredient: .water, from: .cups, to: .grams,
            expected: 240.0, message: "1 cup water should equal 240g"
        )
        
        // Milk is slightly denser: 245g per cup
        assertConversion(
            amount: 1.0, ingredient: .milk, from: .cups, to: .grams,
            expected: 245.0, message: "1 cup milk should equal 245g"
        )
        
        // Honey is very dense: 340g per cup
        assertConversion(
            amount: 1.0, ingredient: .honey, from: .cups, to: .grams,
            expected: 340.0, message: "1 cup honey should equal 340g"
        )
    }
    
    func testFatConversions() {
        // Butter: 227g per cup (2 sticks)
        assertConversion(
            amount: 1.0, ingredient: .butter, from: .cups, to: .grams,
            expected: 227.0, message: "1 cup butter should equal 227g"
        )
        
        // Oil: 218g per cup
        assertConversion(
            amount: 1.0, ingredient: .oil, from: .cups, to: .grams,
            expected: 218.0, message: "1 cup oil should equal 218g"
        )
        
        // Test tablespoons to grams for butter (common measurement)
        assertConversion(
            amount: 1.0, ingredient: .butter, from: .tablespoons, to: .grams,
            expected: 14.19, accuracy: 0.2, message: "1 tbsp butter should equal ~14.19g"
        )
    }
    
    // MARK: - Detailed Conversion Tests
    
    func testDetailedConversionSuccess() {
        let result = CookingConverter.convertWithDetails(
            amount: 2.0,
            ingredient: .allPurposeFlour,
            from: .cups,
            to: .grams
        )
        
        XCTAssertTrue(result.isSuccess, "Conversion should succeed")
        XCTAssertNotNil(result.convertedAmount, "Should have converted amount")
        XCTAssertEqual(result.convertedAmount!, 240.0, accuracy: 0.1, "2 cups flour should equal 240g")
        XCTAssertEqual(result.originalAmount, 2.0)
        XCTAssertEqual(result.ingredient, .allPurposeFlour)
        XCTAssertEqual(result.fromUnit, .cups)
        XCTAssertEqual(result.toUnit, .grams)
        XCTAssertGreaterThan(result.confidence, 0.8, "Should have high confidence for flour conversion")
        XCTAssertNil(result.error, "No error expected for valid conversion")
        XCTAssertNotNil(result.notes, "Should have notes about flour measurement")
    }
    
    func testDetailedConversionFailure() {
        let result = CookingConverter.convertWithDetails(
            amount: -1.0,
            ingredient: .allPurposeFlour,
            from: .cups,
            to: .grams
        )
        
        XCTAssertFalse(result.isSuccess, "Negative amount should fail")
        XCTAssertNil(result.convertedAmount, "Should not return converted amount for invalid input")
        XCTAssertNotNil(result.error, "Should provide error information")
        XCTAssertEqual(result.confidence, 0.0, "Confidence should be zero for failed conversion")
    }
    
    func testSameUnitConversion() {
        let result = CookingConverter.convert(
            amount: 5.0,
            ingredient: .allPurposeFlour,
            from: .cups,
            to: .cups
        )
        XCTAssertNotNil(result, "Same unit conversion should succeed")
        XCTAssertEqual(result!, 5.0, "Same unit conversion should return same value")
        
        let detailedResult = CookingConverter.convertWithDetails(
            amount: 5.0,
            ingredient: .allPurposeFlour,
            from: .cups,
            to: .cups
        )
        XCTAssertEqual(detailedResult.confidence, 1.0, "Same unit should have perfect confidence")
    }
    
    // MARK: - Recipe Scaling Tests
    
    func testRecipeScaling() {
        let originalIngredients = [
            RecipeIngredient(name: "flour", amount: 2.0, unit: .cups),
            RecipeIngredient(name: "sugar", amount: 1.0, unit: .cups),
            RecipeIngredient(name: "butter", amount: 0.5, unit: .cups),
            RecipeIngredient(name: "eggs", amount: 2.0, unit: .pieces)
        ]
        
        // Scale from 4 servings to 6 servings (1.5x)
        let scaledIngredients = CookingConverter.scaleRecipe(
            ingredients: originalIngredients,
            from: 4,
            to: 6
        )
        
        XCTAssertEqual(scaledIngredients.count, 4, "Should return same number of ingredients")
        XCTAssertEqual(scaledIngredients[0].amount, 3.0, accuracy: 0.1, "Flour should be 3.0 cups (2.0 × 1.5)")
        XCTAssertEqual(scaledIngredients[1].amount, 1.5, accuracy: 0.1, "Sugar should be 1.5 cups (1.0 × 1.5)")
        XCTAssertEqual(scaledIngredients[2].amount, 0.75, accuracy: 0.1, "Butter should be 0.75 cups (0.5 × 1.5)")
        XCTAssertEqual(scaledIngredients[3].amount, 3.0, accuracy: 0.1, "Eggs should be 3.0 pieces (2.0 × 1.5)")
    }
    
    func testRecipeScalingEdgeCases() {
        let ingredients = [
            RecipeIngredient(name: "flour", amount: 1.0, unit: .cups)
        ]
        
        // Scale with zero servings should return original
        let zeroScale = CookingConverter.scaleRecipe(ingredients: ingredients, from: 0, to: 4)
        XCTAssertEqual(zeroScale, ingredients, "Zero servings should return original")
        
        // Scale to zero servings should return original
        let toZeroScale = CookingConverter.scaleRecipe(ingredients: ingredients, from: 4, to: 0)
        XCTAssertEqual(toZeroScale, ingredients, "Scale to zero should return original")
        
        // Scale by 1.0 (same servings)
        let sameScale = CookingConverter.scaleRecipe(ingredients: ingredients, from: 4, to: 4)
        XCTAssertEqual(sameScale[0].amount, 1.0, "Same servings should return same amounts")
    }
    
    // MARK: - Error Handling Tests
    
    func testInvalidAmounts() {
        // Negative amount
        let negativeResult = CookingConverter.convert(
            amount: -1.0,
            ingredient: .allPurposeFlour,
            from: .cups,
            to: .grams
        )
        XCTAssertNil(negativeResult, "Negative amount should return nil")
        
        // Zero amount
        let zeroResult = CookingConverter.convert(
            amount: 0.0,
            ingredient: .allPurposeFlour,
            from: .cups,
            to: .grams
        )
        XCTAssertNil(zeroResult, "Zero amount should return nil")
    }
    
    func testUnsupportedConversions() {
        // Try to convert temperature to volume (should fail)
        let invalidResult = CookingConverter.convert(
            amount: 350.0,
            ingredient: .allPurposeFlour,
            from: .fahrenheit,
            to: .cups
        )
        XCTAssertNil(invalidResult, "Temperature to volume conversion should fail")
        
        // Try to convert quantity to weight (should fail)
        let quantityResult = CookingConverter.convert(
            amount: 2.0,
            ingredient: .allPurposeFlour,
            from: .pieces,
            to: .grams
        )
        XCTAssertNil(quantityResult, "Pieces to grams conversion should fail")
    }
    
    // MARK: - Confidence Score Tests
    
    func testConfidenceScores() {
        // High confidence: volume to volume
        let volumeResult = CookingConverter.convertWithDetails(
            amount: 1.0,
            ingredient: .water,
            from: .cups,
            to: .milliliters
        )
        XCTAssertGreaterThan(volumeResult.confidence, 0.95, "Volume to volume should have very high confidence")
        
        // High confidence: weight to weight
        let weightResult = CookingConverter.convertWithDetails(
            amount: 1.0,
            ingredient: .allPurposeFlour,
            from: .ounces,
            to: .grams
        )
        XCTAssertGreaterThan(weightResult.confidence, 0.95, "Weight to weight should have very high confidence")
        
        // Lower confidence: volume to weight for variable ingredients
        let brownSugarResult = CookingConverter.convertWithDetails(
            amount: 1.0,
            ingredient: .brownSugar,
            from: .cups,
            to: .grams
        )
        XCTAssertLessThan(brownSugarResult.confidence, 0.85, "Brown sugar volume to weight should have lower confidence")
        
        // Medium confidence: common ingredients
        let flourResult = CookingConverter.convertWithDetails(
            amount: 1.0,
            ingredient: .allPurposeFlour,
            from: .cups,
            to: .grams
        )
        XCTAssertGreaterThan(flourResult.confidence, 0.8, "Flour should have good confidence")
        XCTAssertLessThan(flourResult.confidence, 0.9, "But not perfect due to packing variations")
    }
    
    // MARK: - Conversion Notes Tests
    
    func testConversionNotes() {
        // Brown sugar should mention packing
        let brownSugarResult = CookingConverter.convertWithDetails(
            amount: 1.0,
            ingredient: .brownSugar,
            from: .cups,
            to: .grams
        )
        XCTAssertNotNil(brownSugarResult.notes, "Brown sugar should have notes")
        XCTAssertTrue(brownSugarResult.notes?.lowercased().contains("packed") == true, "Should mention packing")
        
        // Flour should mention spooning and leveling
        let flourResult = CookingConverter.convertWithDetails(
            amount: 1.0,
            ingredient: .allPurposeFlour,
            from: .cups,
            to: .grams
        )
        XCTAssertNotNil(flourResult.notes, "Flour should have notes")
        XCTAssertTrue(flourResult.notes?.lowercased().contains("spoon") == true, "Should mention spooning technique")
        
        // Butter should mention temperature
        let butterResult = CookingConverter.convertWithDetails(
            amount: 1.0,
            ingredient: .butter,
            from: .cups,
            to: .grams
        )
        XCTAssertNotNil(butterResult.notes, "Butter should have notes")
        XCTAssertTrue(butterResult.notes?.lowercased().contains("temperature") == true, "Should mention temperature")
    }
    
    // MARK: - Round-Trip Conversion Tests
    
    func testRoundTripConversions() {
        let testCases: [(ingredient: IngredientType, amount: Double, unit1: CookingUnit, unit2: CookingUnit)] = [
            (.allPurposeFlour, 2.0, .cups, .grams),
            (.granulatedSugar, 1.0, .cups, .ounces),
            (.butter, 0.5, .cups, .grams),
            (.milk, 1.0, .cups, .milliliters)
        ]
        
        for testCase in testCases {
            // Convert forward
            guard let converted = CookingConverter.convert(
                amount: testCase.amount,
                ingredient: testCase.ingredient,
                from: testCase.unit1,
                to: testCase.unit2
            ) else {
                XCTFail("Forward conversion failed for \(testCase.ingredient)")
                continue
            }
            
            // Convert back
            guard let roundTrip = CookingConverter.convert(
                amount: converted,
                ingredient: testCase.ingredient,
                from: testCase.unit2,
                to: testCase.unit1
            ) else {
                XCTFail("Round-trip conversion failed for \(testCase.ingredient)")
                continue
            }
            
            XCTAssertEqual(
                roundTrip,
                testCase.amount,
                accuracy: 0.01,
                "Round-trip conversion should preserve original amount for \(testCase.ingredient)"
            )
        }
    }
    
    // MARK: - Information and Metadata Tests
    
    func testConversionInfo() {
        let info = CookingConverter.conversionInfo()
        
        XCTAssertGreaterThan(info.supportedIngredients.count, 20, "Should support many ingredients")
        XCTAssertGreaterThan(info.supportedUnits.count, 10, "Should support many units")
        XCTAssertTrue(info.supportedSystems.contains(.us), "Should support US system")
        XCTAssertTrue(info.supportedSystems.contains(.metric), "Should support metric system")
        XCTAssertGreaterThan(info.totalConversions, 1000, "Should support many conversion combinations")
        
        // Test grouped data
        let volumeUnits = info.unitsByType[.volume] ?? []
        XCTAssertTrue(volumeUnits.contains(.cups), "Volume units should include cups")
        XCTAssertTrue(volumeUnits.contains(.milliliters), "Volume units should include milliliters")
        
        let weightUnits = info.unitsByType[.weight] ?? []
        XCTAssertTrue(weightUnits.contains(.grams), "Weight units should include grams")
        XCTAssertTrue(weightUnits.contains(.ounces), "Weight units should include ounces")
    }
    
    // MARK: - Edge Case Tests
    
    func testVeryLargeAmounts() {
        // Test conversion with large amounts (commercial kitchen scale)
        let largeAmount = CookingConverter.convert(
            amount: 100.0,
            ingredient: .allPurposeFlour,
            from: .cups,
            to: .grams
        )
        XCTAssertNotNil(largeAmount, "Large amount conversion should succeed")
        XCTAssertEqual(largeAmount!, 12000.0, accuracy: 1.0, "100 cups flour should be 12kg")
    }
    
    func testVerySmallAmounts() {
        // Test conversion with very small amounts (precision baking)
        let smallAmount = CookingConverter.convert(
            amount: 0.125,
            ingredient: .salt,
            from: .teaspoons,
            to: .grams
        )
        XCTAssertNotNil(smallAmount, "Should handle very small amounts")
        XCTAssertGreaterThan(smallAmount!, 0, "Small amount should be positive")
    }
    
    func testDecimalPrecision() {
        // Test that decimal amounts work correctly
        assertConversion(
            amount: 1.5, ingredient: .granulatedSugar, from: .cups, to: .grams,
            expected: 300.0, message: "1.5 cups sugar should be 300g"
        )
        
        assertConversion(
            amount: 2.25, ingredient: .allPurposeFlour, from: .cups, to: .grams,
            expected: 270.0, message: "2.25 cups flour should be 270g"
        )
    }
    
    // MARK: - Performance Tests
    
    func testPerformanceBasicConversions() {
        measure {
            for _ in 0..<1000 {
                _ = CookingConverter.convert(
                    amount: 1.0,
                    ingredient: .allPurposeFlour,
                    from: .cups,
                    to: .grams
                )
            }
        }
    }
    
    func testPerformanceDetailedConversions() {
        measure {
            for _ in 0..<100 {
                _ = CookingConverter.convertWithDetails(
                    amount: 1.0,
                    ingredient: .allPurposeFlour,
                    from: .cups,
                    to: .grams
                )
            }
        }
    }
    
    func testPerformanceRecipeScaling() {
        let largeRecipe = Array(0..<100).map { i in
            RecipeIngredient(name: "ingredient\(i)", amount: Double(i), unit: .cups)
        }
        
        measure {
            for _ in 0..<10 {
                _ = CookingConverter.scaleRecipe(
                    ingredients: largeRecipe,
                    from: 4,
                    to: 6
                )
            }
        }
    }
    
    // MARK: - Integration Tests
    
    func testRealWorldRecipeConversion() {
        // Test a realistic recipe conversion scenario
        let originalRecipe = [
            RecipeIngredient(name: "all-purpose flour", amount: 3.0, unit: .cups),
            RecipeIngredient(name: "granulated sugar", amount: 2.0, unit: .cups),
            RecipeIngredient(name: "butter", amount: 1.0, unit: .cups),
            RecipeIngredient(name: "milk", amount: 1.0, unit: .cups),
            RecipeIngredient(name: "vanilla extract", amount: 2.0, unit: .teaspoons)
        ]
        
        // Scale recipe from 8 servings to 12 servings
        let scaledRecipe = CookingConverter.scaleRecipe(
            ingredients: originalRecipe,
            from: 8,
            to: 12
        )
        
        XCTAssertEqual(scaledRecipe[0].amount, 4.5, accuracy: 0.1, "Flour should scale to 4.5 cups")
        XCTAssertEqual(scaledRecipe[1].amount, 3.0, accuracy: 0.1, "Sugar should scale to 3.0 cups")
        
        // Convert scaled ingredients to metric
        assertConversion(
            amount: scaledRecipe[0].amount, ingredient: .allPurposeFlour, from: .cups, to: .grams,
            expected: 540.0, accuracy: 1.0, message: "4.5 cups flour should be 540g"
        )
        
        assertConversion(
            amount: scaledRecipe[1].amount, ingredient: .granulatedSugar, from: .cups, to: .grams,
            expected: 600.0, accuracy: 1.0, message: "3.0 cups sugar should be 600g"
        )
    }
    
}
