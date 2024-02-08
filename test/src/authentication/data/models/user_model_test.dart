import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_demo/core/utils/typedef.dart';
import 'package:tdd_demo/src/authentication/data/models/user_model.dart';
import 'package:tdd_demo/src/authentication/domain/entities/user.dart';

import '../../../../fixtures/fixture_reader.dart';

/// What does the class depends on
/// Answer -- Authentication Repository
/// How can we create a fake version of the dependency
/// Answer -- Use Mocktail package
/// How do we control what our dependencies do
/// Answer -- Using the mocktail's APIs

void main() {
  const tModel = UserModel.empty();
  final tJson = fixture('user.json');
  final tMap = jsonDecode(tJson) as DataMap;
  test('should be a class of [UserEntity]', () {
    /// Arrange

    /// Act

    /// Assert
    expect(tModel, isA<User>());
  });

  group('fromMap', () {
    test('should return a [UserModel] with the right data', () {
      /// Arrange

      /// Act
      final result = UserModel.fromMap(tMap);
      expect(result, equals(tModel));
    });
  });

  group('fromJson', () {
    test('should return a [UserModel] with the right data', () {
      /// Arrange

      /// Act
      final result = UserModel.fromJson(tJson);
      expect(result, equals(tModel));
    });
  });

  group('toMap', () {
    test('should return a [Map] with the right data', () {
      /// Arrange

      /// Act
      final result = tModel.toMap();
      expect(result, equals(tMap));
    });
  });

  group('toJson', () {
    test('should return a [JSON] String with the right data', () {
      /// Arrange

      /// Act
      final result = tModel.toJson();
      final tJson =
          jsonEncode({"id": "1", "avatar": "", "createdAt": "", "name": ""});
      expect(result, equals(tJson));
    });
  });


}
