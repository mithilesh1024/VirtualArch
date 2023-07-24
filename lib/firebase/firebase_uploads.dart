import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:virtualarch/models/upload_model.dart';

class FirebaseUploads {
  Future<Map<String, dynamic>> createProject({
    required Map projectInfo,
  }) async {
    try {
      final docProject = FirebaseFirestore.instance.collection("models").doc();
      final newProject = Models3D(
        modelId: docProject.id,
        modelImageURL: projectInfo['modelImageURL'],
        model3dURL: projectInfo['model3dURL'],
        model3dBirdsView: projectInfo['model3dBirdsView'],
        modelName: projectInfo['modelName'],
        modelPrice: projectInfo['modelPrice'],
        modelEstimatedBuildPrice: projectInfo['modelEstimatedBuildPrice'],
        modelArchitectname: projectInfo['modelArchitectname'],
        modelArchitectID: projectInfo['modelArchitectID'],
        modelPassword: projectInfo['modelPassword'],
        modelColorScheme: projectInfo['modelColorScheme'],
        modelFloors: int.parse(projectInfo['modelFloors']),
        modelTotalSquareFootage:
            int.parse(projectInfo['modelTotalSquareFootage']),
        modelRoofStyle: projectInfo['modelRoofStyle'],
        modelNumberOfCommonRooms:
            int.parse(projectInfo['modelNumberOfCommonRooms']),
        modelNumberOfBedrooms: int.parse(projectInfo['modelNumberOfBedrooms']),
        modelNumberOfBaths: int.parse(projectInfo['modelNumberOfBaths']),
        modelFlooringOfRooms: projectInfo['modelFlooringOfRooms'],
        modelLightingOfRooms: projectInfo['modelLightingOfRooms'],
        modelCeilingHeight: int.parse(projectInfo['modelCeilingHeight']),
        modelKitchenCountertops: projectInfo['modelKitchenCountertops'],
        modelKitchenCabinetry: projectInfo['modelKitchenCabinetry'],
        modelFlooringOfKitchen: projectInfo['modelFlooringOfKitchen'],
        modelBathroomVanity: projectInfo['modelBathroomVanity'],
        modelYard: projectInfo['modelYard'],
        modelDeck: projectInfo['modelDeck'],
        modelPatio: projectInfo['modelPatio'],
        modelParkings: projectInfo['modelParkings'],
        modelPool: projectInfo['modelPool'],
        modelTechnologyAndSmartFeatures:
            projectInfo['modelTechnologyAndSmartFeatures'],
      );
      final json = newProject.toJson();
      await docProject.set(json);
      return {'noErrors': true, 'projectId': docProject.id};
    } on FirebaseException catch (e) {
      print("upload text $e");
      return {'noErrors': false, 'projectId': ""};
    }
  }

  Future<bool> addOtherDesignLinks(
      {required projectId,
      required Map<String, String> modelOtherDesignLinks}) async {
    try {
      var doc = FirebaseFirestore.instance;
      await doc.collection("models").doc(projectId).update(
        {"modelOtherDesignLinks": modelOtherDesignLinks},
      );
      return true;
    } catch (e) {
      return false;
    }
  }
}
