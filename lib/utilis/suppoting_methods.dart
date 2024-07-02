
import 'dart:math' show asin, cos, pi, pow, sin, sqrt;

class SupportingMethods{



  static Map<String, dynamic> calculatePlasterMaterials(
      double length, double width, double thickness, double costCementBag, double costSandPer40Kg) {
    double wastageFactor = 1.20; // 20% wastage
    double mixRatio = 5.0; // Total parts (1 part cement + 4 parts sand)
    double totalArea = length * width;
    double volumeOfPlaster = totalArea * thickness;
    double totalVolume = volumeOfPlaster * wastageFactor;
    double volumeOfCement = totalVolume / mixRatio; // Volume of cement
    double volumeOfSand = totalVolume - volumeOfCement; // Volume of sand
    double cementBags = volumeOfCement / 0.0347;
    double weightOfSand = volumeOfSand * 1600; // in kg
    double sandBags = weightOfSand / 40; // Convert to 40kg bags
    double totalCost = (cementBags.ceil() * costCementBag) + (sandBags.ceil() * costSandPer40Kg);
    return {
      'totalArea': totalArea,
      'cementBags': cementBags.ceil(), // Round up to the next whole number
      'sandRequired': volumeOfSand,
      'totalCost': totalCost
    };
  }


  static bool containsNoDigits(String input) {
    RegExp regExp = RegExp(r'\d');
    return !regExp.hasMatch(input);
  }


  static Map<String, dynamic> calculateTiles(
      double lengthOfFloor,
      double widthOfFloor,
      double tileLength,
      double tileWidth,
      double costPerCm,
      double wastagePercent,
      ) {

    double floorLengthCm = lengthOfFloor * 100;
    double floorWidthCm = widthOfFloor * 100;
    double totalArea = lengthOfFloor * widthOfFloor;
    double tileAreaCm2 = tileLength * tileWidth;
    double tilesWithWastage = ((floorLengthCm * floorWidthCm) / tileAreaCm2) * (1 + wastagePercent / 100);
    int tilesRequired = tilesWithWastage.ceil();
    double tileCost = tileAreaCm2 * costPerCm;
    double totalCost = tilesRequired * tileCost;
    return {
      'totalArea': totalArea,
      'tilesRequired': tilesRequired,
      'totalCost': totalCost,
    };
  }

 static Map<String, dynamic> calculateSteelCost({
    required double length,
    required double width,
    required double diameter,
    required double density,
    required double costPerKg,
  }) {

    double totalArea = length * width;
    double steelAmount = totalArea * diameter;
    double totalDensity = steelAmount * density;
    double totalDiameter = diameter * length * width;
    double cost = steelAmount * costPerKg;

    return {
      'cost': cost,
      'steelAmount': steelAmount,
      'totalArea': totalArea,
      'totalDensity': totalDensity,
      'totalDiameter': totalDiameter,
    };
  }


  static Map<String, dynamic> calculateWallBricksRequired(double length, double width, double thickness, double costPerBrick, double wastePercentage) {
    double totalArea = length * width;
    double totalBricks = (totalArea * 1000) / (thickness * 1000);
    double wasteMultiplier = 1 + (wastePercentage / 100);
    double bricksWithWaste = totalBricks * wasteMultiplier;
    double wastedBricks = bricksWithWaste - totalBricks;
    double totalCost = bricksWithWaste * costPerBrick;
    return {
      'totalArea': totalArea,
      'totalBricks': bricksWithWaste.ceil(),
      'wastedBricks': wastedBricks.ceil(),
      'totalCost': totalCost,
    };
  }

}