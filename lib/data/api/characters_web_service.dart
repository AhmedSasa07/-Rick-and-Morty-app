import 'dart:developer';
import 'package:breaking/constants/strings.dart';
import 'package:breaking/data/models/charactersModel.dart';
import 'package:dio/dio.dart';


//Mine
// class CharactersService {
//   late final Dio dio;
//   CharactersService() {
//     BaseOptions options = BaseOptions(
//       baseUrl: baseUrl,
//       receiveDataWhenStatusError: true,
//       connectTimeout: Duration(seconds: 20),
//       receiveTimeout: Duration(seconds: 20),
//     );
//     dio = Dio(options);
//   }
//   //Original
//   Future<List<CharacterModel>> getAllCharacters() async {
//     try {
//       Response response = await dio.get('/character');
//       print('XxResponsexX');
//       print(response.toString());
//       print('XxEndResponsexX');
//       return response.data;
//     } on DioException catch (e) {
//       // TODO
//       final String errorMessage = e.response?.data['error']['message'] ??
//           "Oops there was an error X_X, Try again Later";
//       throw Exception(errorMessage);
//     } catch (e) {
//       log(e.toString());
//       throw Exception("Oops there was an error X_X, Try again Later");
//     }
//   }
//
// }
class CharactersService {
  late final Dio dio;
  CharactersService() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: Duration(seconds: 20),
      receiveTimeout: Duration(seconds: 20),
    );
    dio = Dio(options);
  }

  Future<List<CharacterModel>> getAllCharacters() async {
    try {
      Response response = await dio.get('/character');
      print('XxResponsexX');
      print(response.toString());
      print('XxEndResponsexX');

      // Parse the response data
      final data = response.data as Map<String, dynamic>;
      final results = data['results'] as List<dynamic>;

      return results.map((json) => CharacterModel.fromJson(json as Map<String, dynamic>)).toList();
    } on DioException catch (e) {
      // Handle DioException
      final String errorMessage = e.response?.data['error']['message'] ??
          "Oops there was an error X_X, Try again Later";
      throw Exception(errorMessage);
    } catch (e) {
      log(e.toString());
      throw Exception("Oops there was an error X_X, Try again Later");
    }
  }
}
