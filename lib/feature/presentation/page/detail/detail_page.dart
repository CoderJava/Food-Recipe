import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipe/feature/presentation/bloc/detailmeal/bloc.dart';
import 'package:food_recipe/injection_container.dart';

class DetailPage extends StatefulWidget {
  final String idMeal;

  DetailPage(this.idMeal);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final detailMealBloc = sl<DetailMealBloc>();

  var paddingTop = 0.0;
  var paddingBottom = 0.0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      debugPrint('idMeal: ${widget.idMeal}');
      _doLoadData();
    });
    super.initState();
  }

  void _doLoadData() {
    detailMealBloc.add(LoadDetailMealEvent(widget.idMeal));
  }

  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    paddingTop = mediaQueryData.padding.top;
    paddingBottom = mediaQueryData.padding.bottom;
    return Scaffold(
      body: BlocProvider<DetailMealBloc>(
        create: (context) => detailMealBloc,
        child: BlocBuilder<DetailMealBloc, DetailMealState>(
          builder: (context, state) {
            if (state is LoadingDetailMealState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is FailureDetailMealState) {
              return Center(
                child: IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: () {
                    _doLoadData();
                  },
                ),
              );
            } else if (state is LoadedDetailMealState) {
              var detailMealResponse = state.detailMealResponse;
              return Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: detailMealResponse.strMealThumb ?? '',
                    width: double.infinity,
                    height: 192,
                    fit: BoxFit.cover,
                    placeholder: (context, url) {
                      return Image.asset(
                        'assets/images/img_placeholder.jpg',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 192,
                      );
                    },
                    errorWidget: (context, url, dynamic) {
                      return Image.asset(
                        'assets/images/img_not_found.jpg',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 192,
                      );
                    },
                  ),
                  Positioned(
                    left: 8,
                    top: paddingTop + 8,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.all(8),
                        child: Center(
                          child: Icon(
                            Icons.arrow_back,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(top: paddingTop),
                    child: Column(
                      children: [
                        SizedBox(height: 128),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    detailMealResponse.strMeal ?? '-',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context).textTheme.caption.copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey[800],
                                        ),
                                  ),
                                  Text(
                                    detailMealResponse.strCategory ?? '-',
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                  Divider(color: Colors.grey[400]),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      _buildWidgetInfoFloatingHotRecipe(
                                        Icons.location_on,
                                        Colors.orange,
                                        detailMealResponse.strArea,
                                      ),
                                      _buildWidgetInfoFloatingHotRecipe(
                                        Icons.kitchen,
                                        Colors.lightBlue,
                                        '${detailMealResponse.listIngredients.length} Ingredients',
                                      ),
                                      _buildWidgetInfoFloatingHotRecipe(
                                        Icons.ondemand_video,
                                        Theme.of(context).primaryColor,
                                        detailMealResponse.strYoutube != null ? 'Youtube' : 'N/A',
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView(
                            padding: EdgeInsets.only(
                              left: 16,
                              top: 16,
                              right: 16,
                              bottom: paddingBottom + 16,
                            ),
                            children: <Widget>[
                              Text(
                                'Ingredients',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              SizedBox(height: 4),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: detailMealResponse.listIngredients
                                    .map((element) => Text(
                                          '• $element',
                                          style: Theme.of(context).textTheme.caption,
                                        ))
                                    .toList(),
                              ),
                              SizedBox(height: 16),
                              Text(
                                'Instructions',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              Text(
                                detailMealResponse.strInstructions,
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Widget _buildWidgetInfoFloatingHotRecipe(
    IconData icon,
    Color iconColor,
    String label,
  ) {
    return Wrap(
      children: [
        Icon(
          icon,
          size: 14,
          color: iconColor,
        ),
        SizedBox(width: 4),
        Text(
          label ?? '-',
          style: Theme.of(context).textTheme.caption.copyWith(fontSize: 11),
        ),
      ],
    );
  }
}
