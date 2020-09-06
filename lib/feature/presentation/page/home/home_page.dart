import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_recipe/feature/data/model/filterbycategory/filter_by_category_response.dart';
import 'package:food_recipe/feature/presentation/bloc/categorymeal/bloc.dart';
import 'package:food_recipe/feature/presentation/bloc/randommeal/bloc.dart';
import 'package:food_recipe/feature/presentation/page/detail/detail_page.dart';
import 'package:food_recipe/feature/presentation/widget/widget_custom_shimmer.dart';
import 'package:food_recipe/injection_container.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final randomMealBloc = sl<RandomMealBloc>();
  final categoryMealBloc = sl<CategoryMealBloc>();

  var paddingTop = 0.0;
  var categorySelected = 'Beef';
  var isCategoryLoading = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _doLoadData();
    });
    super.initState();
  }

  void _doLoadData() {
    isCategoryLoading = true;
    randomMealBloc.add(LoadRandomMealEvent());
    categoryMealBloc.add(LoadCategoryMealEvent());
  }

  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    paddingTop = mediaQueryData.padding.top;
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Recipe'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.refresh,
            ),
            onPressed: () {
              _doLoadData();
            },
          ),
        ],
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<RandomMealBloc>(
            create: (context) => randomMealBloc,
          ),
          BlocProvider<CategoryMealBloc>(
            create: (context) => categoryMealBloc,
          ),
        ],
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //_buildWidgetSearch(),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Random Recipe',
                  style: Theme.of(context).textTheme.bodyText2.copyWith(fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(height: 8),
              _buildWidgetRandomRecipe(),
              SizedBox(height: 8),
              _buildWidgetCategoryRecipe(),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  '${categorySelected[0].toUpperCase()}${categorySelected.substring(1)} Recipe',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(height: 8),
              BlocBuilder<CategoryMealBloc, CategoryMealState>(
                builder: (context, state) {
                  if (state is LoadingCategoryMealState) {
                    return _buildWidgetLoadingListRecipeByCategory();
                  } else if (state is LoadingDetailCategoryMealState) {
                    return _buildWidgetLoadingListRecipeByCategory();
                  } else if (state is FailureCategoryMealState) {
                    return _buildWidgetFailureListRecipeByCategory();
                  } else if (state is FailureDetailCategoryMealState) {
                    return _buildWidgetFailureListRecipeByCategory();
                  } else if (state is LoadedCategoryMealState) {
                    var filterByCategoryResponse = state.filterByCategoryResponse;
                    return _buildWidgetListRecipeByCategory(filterByCategoryResponse);
                  } else if (state is LoadedDetailCategoryMealState) {
                    var filterByCategoryResponse = state.filterByCategoryResponse;
                    return _buildWidgetListRecipeByCategory(filterByCategoryResponse);
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWidgetListRecipeByCategory(FilterByCategoryResponse data) {
    var listData = data.meals;
    return Expanded(
      child: ListView.separated(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: 16,
        ),
        itemBuilder: (context, index) {
          var itemData = listData[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(itemData.idMeal)));
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: CachedNetworkImage(
                    width: 48,
                    height: 48,
                    imageUrl: itemData.strMealThumb,
                    fit: BoxFit.cover,
                    placeholder: (context, url) {
                      return Image.asset(
                        'assets/images/img_placeholder.jpg',
                        fit: BoxFit.cover,
                        width: 48,
                        height: 48,
                      );
                    },
                    errorWidget: (context, url, dynamic) {
                      return Image.asset(
                        'assets/images/img_not_found.jpg',
                        fit: BoxFit.cover,
                        width: 48,
                        height: 48,
                      );
                    },
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    itemData.strMeal,
                    style: Theme.of(context).textTheme.bodyText2,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) => Divider(),
        itemCount: listData.length,
      ),
    );
  }

  Widget _buildWidgetFailureListRecipeByCategory() {
    return Center(
      child: IconButton(
        icon: Icon(Icons.refresh),
        onPressed: () {
          categoryMealBloc.add(LoadDetailCategoryMealEvent(categorySelected));
        },
      ),
    );
  }

  Widget _buildWidgetLoadingListRecipeByCategory() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: WidgetCustomShimmer(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            SizedBox(width: 8),
            Container(
              width: 64,
              height: 14,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWidgetCategoryRecipe() {
    return BlocBuilder<CategoryMealBloc, CategoryMealState>(
      condition: (previousState, currentState) {
        return isCategoryLoading;
      },
      builder: (context, state) {
        if (state is LoadingCategoryMealState) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SizedBox(
              height: 32,
              child: WidgetCustomShimmer(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                        child: Text(''),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                        child: Text(''),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                        child: Text(''),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (state is LoadedCategoryMealState) {
          isCategoryLoading = false;
          var categories = state.mealCategoryResponse.categories;
          if (categorySelected.isEmpty) {
            categorySelected = categories[0].strCategory.toLowerCase();
          }
          return SizedBox(
            height: 32,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) {
                var itemCategory = categories[index];
                var thumbnail = 'assets/images/img_' + itemCategory.strCategory.toLowerCase() + '.jpg';
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      categorySelected = itemCategory.strCategory.toLowerCase();
                      categoryMealBloc.add(LoadDetailCategoryMealEvent(categorySelected));
                    });
                  },
                  child: Container(
                    height: 32,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(thumbnail),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Container(
                      height: 32,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(4),
                        border: categorySelected == itemCategory.strCategory.toLowerCase()
                            ? Border.all(
                                color: Theme.of(context).primaryColor,
                                width: 2,
                              )
                            : null,
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      alignment: Alignment.center,
                      child: Text(
                        itemCategory.strCategory,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(width: 8),
              itemCount: categories.length,
            ),
          );
        } else if (state is FailureCategoryMealState) {
          return IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _doLoadData();
            },
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildWidgetRandomRecipe() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: BlocBuilder<RandomMealBloc, RandomMealState>(
        builder: (context, state) {
          if (state is LoadingRandomMealState) {
            return WidgetCustomShimmer(
              child: Container(
                width: double.infinity,
                height: 160,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            );
          } else if (state is FailureRandomMealState) {
            return Text('failure');
          } else if (state is LoadedRandomMealState) {
            var detailMealResponse = state.detailMealResponse;
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPage(detailMealResponse.idMeal),
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                height: 160,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: CachedNetworkImage(
                        width: double.infinity,
                        height: 128,
                        imageUrl: detailMealResponse.strMealThumb,
                        fit: BoxFit.cover,
                        placeholder: (context, url) {
                          return Image.asset(
                            'assets/images/img_placeholder.jpg',
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 128,
                          );
                        },
                        errorWidget: (context, url, dynamic) {
                          return Image.asset(
                            'assets/images/img_not_found.jpg',
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 128,
                          );
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
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
                    )
                  ],
                ),
              ),
            );
          } else {
            return Container();
          }
        },
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
