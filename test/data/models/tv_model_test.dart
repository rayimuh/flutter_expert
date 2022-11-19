import 'package:ditonton/data/models/tv_model.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:flutter_test/flutter_test.dart';

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

  final tTv = Tv(
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

  test('should be a subclass of Tv entity', () async {
    final result = tTvModel.toEntity();
    expect(result, tTv);
  });
}
