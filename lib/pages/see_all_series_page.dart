import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/cubits/top_series_cubit/top_series_cubit.dart';
import 'package:movie_app/cubits/top_series_cubit/top_series_states.dart';
import 'package:movie_app/models/series_model.dart';
import 'package:movie_app/widgets/series_item.dart';

class SeeAllSeriesPage extends StatefulWidget {
  final List<SeriesModel> series;
  const SeeAllSeriesPage({super.key, required this.series});

  @override
  State<SeeAllSeriesPage> createState() => _SeeAllSeriesPageState();
}

class _SeeAllSeriesPageState extends State<SeeAllSeriesPage> {
  late final ScrollController scrollController;
  int nextPage = 2;
  bool isLoading = false;
  List<SeriesModel> seriesList = [];

  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(scrollListener);
    seriesList.addAll(widget.series);
    super.initState();
  }

  void scrollListener() async {
    var currentPosition = scrollController.position.pixels;
    var maxPosition = scrollController.position.maxScrollExtent;
    if (currentPosition >= 0.7 * maxPosition) {
      if (!isLoading) {
        isLoading = true;
        await TopSeriesCubit.get(context).getTopSeries(pageNumber: nextPage++);
        isLoading = false;
      }
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: const Text(
          'Top series',
        ),
      ),
      body: BlocConsumer<TopSeriesCubit, TopSeriesStates>(
        listener: (context, state) {
          if (state is GetTopSeriesSuccessState) {
            seriesList.addAll(TopSeriesCubit.get(context).topSeriesList);
          }
        },
        builder: (context, state) {
          if (state is GetTopSeriesSuccessState ||
              state is GetTopSeriesPaginationLoadingState ||
              state is GetTopSeriesPaginationErrorState) {
            return ListView.separated(
              controller: scrollController,
              itemBuilder: (context, index) {
                return SeriesItem(
                  series: seriesList[index],
                );
              },
              separatorBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Container(
                    height: 1,
                    width: double.infinity,
                    color: Colors.grey[700],
                  ),
                );
              },
              itemCount: seriesList.length,
            );
          } else if (state is GetTopSeriesErrorState) {
            return Center(
              child: Text(
                'There was an error ${state.errorMessage}',
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
