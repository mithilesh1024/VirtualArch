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
        modelName: projectInfo['modelName'],
        modelPrice: double.parse(projectInfo['modelPrice']),
        modelEstimatedBuildPrice:
            double.parse(projectInfo['modelEstimatedBuildPrice']),
        modelArchitectname: projectInfo['modelArchitectname'],
        modelArchitectID: projectInfo['modelArchitectID'],
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
        modelCeilingHeight: double.parse(projectInfo['modelCeilingHeight']),
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
        // modelOtherDesignLinks: {},
      );
      final json = newProject.toJson();
      await docProject.set(json);
      return {'noErrors': true, 'projectId': docProject.id};
    } on FirebaseException catch (e) {
      print("upload text $e");
      return {'noErrors': false, 'projectId': ""};
    }
  }
}
