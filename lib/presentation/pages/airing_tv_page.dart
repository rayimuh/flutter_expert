import 'package:ditonton/common/constants.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_bloc/tv_bloc.dart';

enum RequestState { Empty, Loading, Loaded, Error }

class AiringTvsPage extends StatefulWidget {
  static const ROUTE_NAME = '/airing-tv';

  @override
  _AiringTvsPageState createState() => _AiringTvsPageState();
}

class _AiringTvsPageState extends State<AiringTvsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<TvNowPlayingBloc>().add(FetchNowplayingTv()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Airing Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvNowPlayingBloc, TvState>(
          builder: (context, state) {
            if (state is TvLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvShow = state.tvs[index];
                  return TvCard(tvShow);
                },
                itemCount: state.tvs.length,
              );
            }  else if (state is TvHasError) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
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
