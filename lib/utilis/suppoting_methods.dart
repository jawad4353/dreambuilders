
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

}