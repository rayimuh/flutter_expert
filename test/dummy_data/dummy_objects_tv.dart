import 'package:ditonton/data/models/tv_table.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';

final testTv = Tv(
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

final testTvList = [testTv];

final testTvDetail = TvDetail(
    adult: false,
    backdropPath: "/n6CnWXRQlgw3mlqHjnOn5Biq7ne.jpg",
    firstAirDate: "2011-07-24",
    genres: [],
    homepage: "",
    id: 58141,
    inProduction: true,
    lastAirDate: "2022-10-27",
    name: "Farma",
    numberOfEpisodes: 446,
    numberOfSeasons: 7,
    originalName: "Farma",
    overview: "Serbian version of the reality series The Farm.",
    posterPath: "/kbHpBaS67JWmstgAqH39pxEPDyG.jpg",
    status: "Returning Series",
    tagline: "",
    type: "Reality",
    voteAverage: 4.3,
    voteCount: 2);

final testWatchlistTv = Tv.watchlist(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvTable = TvTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name',
};
