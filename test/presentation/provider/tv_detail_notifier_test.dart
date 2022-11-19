import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_recommendations.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status_tv.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv.dart';
import 'package:ditonton/presentation/provider/tv_detail_notifier.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects_tv.dart';
import 'tv_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetTvDetail,
  GetTvRecommendations,
  GetWatchListStatusTv,
  SaveWatchlistTv,
  RemoveWatchlistTv,
])
void main() {
  late TvDetailNotifier provider;
  late MockGetTvDetail mockGetTvDetail;
  late MockGetTvRecommendations mockGetTvRecommendations;
  late MockGetWatchListStatusTv mockGetWatchlistStatusTv;
  late MockSaveWatchlistTv mockSaveWatchlistTv;
  late MockRemoveWatchlistTv mockRemoveWatchlistTv;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvDetail = MockGetTvDetail();
    mockGetTvRecommendations = MockGetTvRecommendations();
    mockGetWatchlistStatusTv = MockGetWatchListStatusTv();
    mockSaveWatchlistTv = MockSaveWatchlistTv();
    mockRemoveWatchlistTv = MockRemoveWatchlistTv();
    provider = TvDetailNotifier(
      getTvDetail: mockGetTvDetail,
      getTvRecommendations: mockGetTvRecommendations,
      getWatchListStatusTv: mockGetWatchlistStatusTv,
      saveWatchlistTv: mockSaveWatchlistTv,
      removeWatchlistTv: mockRemoveWatchlistTv,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tId = 58141;

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

  final tTvs = <Tv>[tTv];

  void _arrangeUsecase() {
    when(mockGetTvDetail.execute(tId))
        .thenAnswer((_) async => Right(testTvDetail));
    when(mockGetTvRecommendations.execute(tId))
        .thenAnswer((_) async => Right(tTvs));
  }

  group('Get Tv Detail', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvDetail(tId);
      // assert
      verify(mockGetTvDetail.execute(tId));
      verify(mockGetTvRecommendations.execute(tId));
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      _arrangeUsecase();
      // act
      provider.fetchTvDetail(tId);
      // assert
      expect(provider.tvState, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('should change tv when data is gotten successfully', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvDetail(tId);
      // assert
      expect(provider.tvState, RequestState.Loaded);
      expect(provider.tv, testTvDetail);
      expect(listenerCallCount, 3);
    });

    test('should change recommendation tv when data is gotten successfully',
        () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvDetail(tId);
      // assert
      expect(provider.tvState, RequestState.Loaded);
      expect(provider.tvRecommendations, tTvs);
    });
  });

  group('Get Tv Recommendations', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvDetail(tId);
      // assert
      verify(mockGetTvRecommendations.execute(tId));
      expect(provider.tvRecommendations, tTvs);
    });

    test('should update recommendation state when data is gotten successfully',
        () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvDetail(tId);
      // assert
      expect(provider.recommendationState, RequestState.Loaded);
      expect(provider.tvRecommendations, tTvs);
    });

    test('should update error message when request in successful', () async {
      // arrange
      when(mockGetTvDetail.execute(tId))
          .thenAnswer((_) async => Right(testTvDetail));
      when(mockGetTvRecommendations.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Failed')));
      // act
      await provider.fetchTvDetail(tId);
      // assert
      expect(provider.recommendationState, RequestState.Error);
      expect(provider.message, 'Failed');
    });
  });

  group('Watchlist', () {
    test('should get the watchlist status', () async {
      // arrange
      when(mockGetWatchlistStatusTv.execute(1)).thenAnswer((_) async => true);
      // act
      await provider.loadWatchlistStatusTv(1);
      // assert
      expect(provider.isAddedToWatchlistTv, true);
    });

    test('should execute save watchlist when function called', () async {
      // arrange
      when(mockSaveWatchlistTv.execute(testTvDetail))
          .thenAnswer((_) async => Right('Success'));
      when(mockGetWatchlistStatusTv.execute(testTvDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlistTv(testTvDetail);
      // assert
      verify(mockSaveWatchlistTv.execute(testTvDetail));
    });

    test('should execute remove watchlist when function called', () async {
      // arrange
      when(mockRemoveWatchlistTv.execute(testTvDetail))
          .thenAnswer((_) async => Right('Removed'));
      when(mockGetWatchlistStatusTv.execute(testTvDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.removeFromWatchlistTv(testTvDetail);
      // assert
      verify(mockRemoveWatchlistTv.execute(testTvDetail));
    });

    test('should update watchlist status when add watchlist success', () async {
      // arrange
      when(mockSaveWatchlistTv.execute(testTvDetail))
          .thenAnswer((_) async => Right('Added to Watchlist'));
      when(mockGetWatchlistStatusTv.execute(testTvDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlistTv(testTvDetail);
      // assert
      verify(mockGetWatchlistStatusTv.execute(testTvDetail.id));
      expect(provider.isAddedToWatchlistTv, true);
      expect(provider.watchlistMessage, 'Added to Watchlist');
      expect(listenerCallCount, 1);
    });

    test('should update watchlist message when add watchlist failed', () async {
      // arrange
      when(mockSaveWatchlistTv.execute(testTvDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      when(mockGetWatchlistStatusTv.execute(testTvDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.addWatchlistTv(testTvDetail);
      // assert
      expect(provider.watchlistMessage, 'Failed');
      expect(listenerCallCount, 1);
    });
  });

  group('on Error', () {
    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTvDetail.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      when(mockGetTvRecommendations.execute(tId))
          .thenAnswer((_) async => Right(tTvs));
      // act
      await provider.fetchTvDetail(tId);
      // assert
      expect(provider.tvState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
