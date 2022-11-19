import 'dart:convert';

import 'package:ditonton/data/models/tv_model.dart';
import 'package:ditonton/data/models/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tTvModel = TvModel(
      backdropPath: "/n6CnWXRQlgw3mlqHjnOn5Biq7ne.jpg",
      firstAirDate: "2011-07-24",
      genreIds: [],
      id: 58141,
      name: "Farma",
      originalName: "Farma",
      overview: "Serbian version of the reality series The Farm.",
      popularity: 1834.27,
      posterPath: "/kbHpBaS67JWmstgAqH39pxEPDyG.jpg",
      voteAverage: 4.3,
      voteCount: 2);

  final tTvResponseModel =
      TvResponse(tvList: <TvModel>[tTvModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/now_playing_tv.json'));
      // act
      final result = TvResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
        "backdrop_path": "/n6CnWXRQlgw3mlqHjnOn5Biq7ne.jpg",
        "first_air_date": "2011-07-24",
        "genre_ids": [],
        "id": 58141,
        "name": "Farma",        
        "original_name": "Farma",        
        "overview": "Serbian version of the reality series The Farm.",
        "popularity": 1834.27,
        "poster_path": "/kbHpBaS67JWmstgAqH39pxEPDyG.jpg",
        "vote_average": 4.3,
        "vote_count": 2,
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
