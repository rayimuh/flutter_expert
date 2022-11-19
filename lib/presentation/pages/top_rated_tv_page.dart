import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_bloc/tv_bloc.dart';
import 'package:ditonton/common/constants.dart';


class TopRatedTvsPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-tv';

  @override
  _TopRatedTvsPageState createState() => _TopRatedTvsPageState();
}

class _TopRatedTvsPageState extends State<TopRatedTvsPage> {
   @override
  void initState() {
    super.initState();
    Future.microtask(
            () => context.read<TopRatedTvBloc>().add(FetchTopRatedTv()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedTvBloc, TvState>(
          builder: (context, state) {
            if (state is TvLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.tvs[index];
                  return TvCard(movie);
                },
                itemCount: state.tvs.length,
              );
            }  else if (state is TvHasError) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message, style: kSubtitle),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
