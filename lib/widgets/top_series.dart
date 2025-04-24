import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/cubits/top_series_cubit/top_series_cubit.dart';
import 'package:movie_app/cubits/top_series_cubit/top_series_states.dart';
import 'package:movie_app/pages/see_all_series_page.dart';
import 'package:movie_app/widgets/series_image.dart';

class TopSeries extends StatelessWidget {
  const TopSeries({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopSeriesCubit, TopSeriesStates>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(
            bottom: 16,
            left: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'Top series',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return SeeAllSeriesPage(
                              series: TopSeriesCubit.get(context).topSeriesList,
                            );
                          },
                        ),
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(right: 16),
                      child: Text(
                        'see all',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 320,
                child: state is GetTopSeriesSuccessState
                    ? ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return SeriesImage(
                            seriesModel: TopSeriesCubit.get(context)
                                .topSeriesList[index],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            width: 8,
                          );
                        },
                        itemCount:
                            TopSeriesCubit.get(context).topSeriesList.length,
                      )
                    : state is GetTopSeriesErrorState
                        ? Center(
                            child: Text(
                              'There was an error ${state.errorMessage}',
                            ),
                          )
                        : const Center(
                            child: CircularProgressIndicator(),
                          ),
              ),
            ],
          ),
        );
      },
    );
  }
}
