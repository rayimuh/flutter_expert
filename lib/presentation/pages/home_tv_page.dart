import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/tv_detail_page.dart';
import 'package:ditonton/presentation/pages/popular_tv_page.dart';
import 'package:ditonton/presentation/pages/search_page_tv.dart';
import 'package:ditonton/presentation/pages/top_rated_tv_page.dart';
import 'package:ditonton/presentation/pages/watchlist_tv_page.dart';
import 'package:ditonton/presentation/pages/home_movie_page.dart';
import 'package:ditonton/presentation/pages/airing_tv_page.dart';
import 'package:flutter/material.dart';
import 'package:ditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_bloc/tv_bloc.dart';



class HomeTvPage extends StatefulWidget {
  @override
  _HomeTvPageState createState() => _HomeTvPageState();
  static const ROUTE_NAME='/home-tv';
}

class _HomeTvPageState extends State<HomeTvPage> {
@override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TvNowPlayingBloc>().add(FetchNowplayingTv());
      context.read<PopularTvBloc>().add(FetchPopularTv());
      context.read<TopRatedTvBloc>().add(FetchTopRatedTv());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, HomeMoviePage.ROUTE_NAME);
              },
              leading: Icon(Icons.movie),
              title: Text('Movies'),
            ),
           ListTile(
              leading: Icon(Icons.live_tv),
              title: Text('Tv Series'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist TV Series'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistTvsPage.ROUTE_NAME);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist Movie'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistMoviesPage.ROUTE_NAME);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
              },
              leading: Icon(Icons.info_outline),
              title: Text('About'),
            ),                               
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchTvPage.ROUTE_NAME);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            _buildSubHeading(
                title: 'Airing Today',
                onTap: () =>
                    Navigator.pushNamed(context, AiringTvsPage.ROUTE_NAME),
              ),
               BlocBuilder<TvNowPlayingBloc, TvState>(
                builder: (context, state) {
              if (state is TvLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is TvHasData) {
                return TvList(state.tvs);
              } else {
                return const Text('Failed');
              }
            },),
              _buildSubHeading(
                title: 'Popular',
                onTap: () =>
                    Navigator.pushNamed(context, PopularTvsPage.ROUTE_NAME),
              ),
             BlocBuilder<PopularTvBloc, TvState>(
                builder: (context, state) {
              if (state is TvLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is TvHasData) {
                return TvList(state.tvs);
              } else {
                return const Text('Failed');
              }
            },),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, TopRatedTvsPage.ROUTE_NAME),
              ),
              BlocBuilder<TopRatedTvBloc, TvState>(
                builder: (context, state) {
              if (state is TvLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is TvHasData) {
                return TvList(state.tvs);
              } else {
                return const Text('Failed');
              }
            },),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TvList extends StatelessWidget {
  final List<Tv> tv;

  TvList(this.tv);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = tv[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TvDetailPage.ROUTE_NAME,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tv.length,
      ),
    );
  }
}
