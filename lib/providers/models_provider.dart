import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/upload_model.dart';

class ModelsProvider with ChangeNotifier {
  bool init = false;
  List<Models3D> models = [
    //   Models3D(
    //     modelId: '5',
    //     modelImageURL: "assets/imagesModels/Villa4.png",
    //     model3dURL: "assets/3dModels/Villa1.glb",
    //     modelName: "Tranquility Manor",
    //     modelPrice: 67,
    //     modelEstimatedBuildPrice: 10000000,
    //     modelArchitectname: "Tara Shetkar",
    //     modelArchitectID: "1",
    //     modelColorScheme: ["Laminate"],
    //     modelFloors: 1,
    //     modelTotalSquareFootage: 400,
    //     modelRoofStyle: ["Laminate"],
    //     modelNumberOfCommonRooms: 2,
    //     modelNumberOfBedrooms: 2,
    //     modelNumberOfBaths: 3,
    //     modelFlooringOfRooms: ["Laminate"],
    //     modelLightingOfRooms: ["Track lighting"],
    //     modelCeilingHeight: 9.0,
    //     modelKitchenCountertops: [],
    //     modelKitchenCabinetry: [],
    //     modelFlooringOfKitchen: [],
    //     modelBathroomVanity: [],
    //     modelYard: true,
    //     modelDeck: false,
    //     modelPatio: false,
    //     modelParkings: true,
    //     modelPool: false,
    //     modelTechnologyAndSmartFeatures: ["Smart thermostat"],
    //     modelOtherDesignLinks: {},
    //   ),
  ];

  Stream<List<Models3D>> get getMyModels {
    var result =
        FirebaseFirestore.instance.collection("models").snapshots().map(
              (snapshot) => snapshot.docs
                  .map((docs) => Models3D.fromJson(docs.data()))
                  .toList(),
            );
    return result;
  }

  RangeValues currentRangeValuesPrice = const RangeValues(4000, 12000);
  RangeValues currentRangeValuesArea = const RangeValues(1800, 3000);
  double currentValueFloor = 3;
  double currentValueBeds = 6;
  double currentValueBaths = 5;

  List<Models3D> get getModel {
    return [...models];
  }

  List<Models3D> get getFilteredModel {
    // print("currentRangeValuesPrice $currentRangeValuesPrice");
    // print("currentRangeValuesArea $currentRangeValuesArea");
    // print("currentValueFloor $currentValueFloor");
    // print("currentValueBeds $currentValueBeds");
    List<Models3D> w3 = models
        .where((e) =>
            (e.modelPrice >= currentRangeValuesPrice.start &&
                e.modelPrice <= currentRangeValuesPrice.end) &&
            (e.modelTotalSquareFootage >= currentRangeValuesArea.start &&
                e.modelTotalSquareFootage <= currentRangeValuesArea.end) &&
            (e.modelFloors >= currentValueFloor) &&
            (e.modelNumberOfBedrooms >= currentValueBeds) &&
            (e.modelNumberOfBaths >= currentValueBaths))
        .toList();
    //models = w3;
    // print(w3.length);
    return w3;
  }

  Models3D getModelById(String id) {
    return models.firstWhere((prod) => prod.modelId == id);
  }
}
