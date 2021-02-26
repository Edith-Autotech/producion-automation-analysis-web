import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:production_automation_web/models/count_model.dart';
import 'package:production_automation_web/models/factory.dart';
import 'package:production_automation_web/models/machine.dart';
import 'package:production_automation_web/models/part.dart';
import 'package:production_automation_web/models/stock.dart';
import 'package:production_automation_web/models/user.dart';
import 'package:production_automation_web/services/api_path.dart';

abstract class FirestoreDatabase {
  Stream<List<FactoryModel>> fetchFactories({String uid});
  Stream<List<Part>> fetchParts({FactoryModel model});
  Stream<List<Stock>> fetchStocks({FactoryModel model, Part part});
  Stream<CountModel> streamCountModel(
      {String dateString, FactoryModel factoryModel, Machine machine});
  Stream<List<Machine>> fetchMachines({FactoryModel factoryModel});
  Future<UserModel> fetchUpdatedUser(UserModel userModel);
  Future<void> setFactory({UserModel user, String key, String name});
  Future<void> updateOperationNo(
      {FactoryModel factoryModel, Machine machineModel, int opNumber});
  Future<void> confrmProductionState(
      {FactoryModel factoryModel, Machine machineModel});
  Future<void> updatePartNumber(
      {FactoryModel factoryModel, Machine machineModel, Part selectedPart});
  Future<void> updateReasonCode(
      {FactoryModel factoryModel, Machine machineModel, String reason});
  Future<CountModel> fetchCountModel(
      {FactoryModel factoryModel, Machine machineModel});
}

class Database with ChangeNotifier implements FirestoreDatabase {
  final _firebaseDatabase = FirebaseFirestore.instance;

  Future<void> _setData({String path, Map<String, dynamic> value}) async {
    await _firebaseDatabase.doc(path).set(value);
  }

  @override
  Future<void> setFactory({UserModel user, String key, String name}) async {
    await _setData(path: ApiPath.factoryPath(key: key, uid: user.uid), value: {
      "name": name,
      "key": key,
    });
  }

  @override
  Stream<List<FactoryModel>> fetchFactories({String uid}) {
    return _firebaseDatabase
        .collection(ApiPath.factories(uid: uid))
        .snapshots()
        .map((event) => event.docs.map((e) => FactoryModel.fromDocument(e)));
  }

  @override
  Stream<List<Part>> fetchParts({FactoryModel model}) {
    return _firebaseDatabase
        .collection(ApiPath.parts(key: model.key))
        .snapshots()
        .map(
          (event) => event.docs.map(
            (e) => Part.fromDocument(e),
          ),
        );
  }

  @override
  Stream<CountModel> streamCountModel(
      {String dateString, FactoryModel factoryModel, Machine machine}) {
    return _firebaseDatabase
        .doc(ApiPath.count(
          date: dateString,
          key: factoryModel.key,
          machineID: machine.machineId,
        ))
        .snapshots()
        .map((event) => CountModel.fromDocument(dateString, snapshot: event));
  }

  @override
  Stream<List<Stock>> fetchStocks({FactoryModel model, Part part}) {
    return _firebaseDatabase
        .collection(ApiPath.stock(key: model.key, partNumber: part.partNumber))
        .snapshots()
        .map((event) => event.docs.map((e) => Stock.fromDocument(e)));
  }

  @override
  Future<UserModel> fetchUpdatedUser(UserModel userModel) async {
    return await _firebaseDatabase
        .doc(ApiPath.userDoc(uid: userModel.uid))
        .get()
        .then((value) => userModel.copyWith(
            admin: value.data()['admin'],
            comapanyName: value.data()['companyName']));
  }

  @override
  Stream<List<Machine>> fetchMachines({FactoryModel factoryModel}) {
    return _firebaseDatabase
        .collection(ApiPath.machines(key: factoryModel.key))
        .snapshots()
        .map((event) => event.docs.map((e) => Machine.fromDocument(e)));
  }

  @override
  Future<void> updateOperationNo(
      {FactoryModel factoryModel, Machine machineModel, int opNumber}) async {
    await _firebaseDatabase
        .doc(ApiPath.machine(
      key: factoryModel.key,
      machineID: machineModel.machineId,
    ))
        .update({"working_operation_number": "Operation $opNumber"});
  }

  @override
  Future<void> confrmProductionState(
      {FactoryModel factoryModel, Machine machineModel}) async {
    await _firebaseDatabase
        .doc(ApiPath.machine(
            key: factoryModel.key, machineID: machineModel.machineId))
        .update({'previous_state': "Production"});
  }

  @override
  Future<void> updatePartNumber(
      {FactoryModel factoryModel,
      Machine machineModel,
      Part selectedPart}) async {
    await _firebaseDatabase
        .doc(ApiPath.machine(
            key: factoryModel.key, machineID: machineModel.machineId))
        .update({"working_part_number": selectedPart.partNumber});
  }

  @override
  Future<void> updateReasonCode(
      {FactoryModel factoryModel, Machine machineModel, String reason}) async {
    await _firebaseDatabase
        .doc(ApiPath.machine(
            key: factoryModel.key, machineID: machineModel.machineId))
        .update({'reason_code': reason});
  }

  @override
  Future<CountModel> fetchCountModel(
      {FactoryModel factoryModel, Machine machineModel}) async {
    DateTime today = DateTime.now();
    String dateString = today.toString().split(" ")[0];

    DocumentReference machineDocument = _firebaseDatabase.doc(ApiPath.count(
      key: factoryModel.key,
      machineID: machineModel.machineId,
      date: dateString,
    ));

    return await machineDocument
        .get()
        .then((value) => CountModel.fromDocument(dateString, snapshot: value))
        .catchError((error) {
      print(error);
      return CountModel(
        count: 0,
        date: dateString,
        idleTime: "No Data",
        productionTime: "No Data",
        standbyTime: "No Data",
      );
    });
  }
}
