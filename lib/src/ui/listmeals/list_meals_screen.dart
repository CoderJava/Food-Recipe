import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe/src/blocs/list_meals_bloc.dart';
import 'package:food_recipe/src/models/categories/categories.dart';
import 'package:food_recipe/src/models/filtercategories/filter_categories.dart';
import 'package:food_recipe/src/utils/utils.dart';

class ListMealsScreen extends StatefulWidget {
  @override
  _ListMealsScreenState createState() => _ListMealsScreenState();
}

class _ListMealsScreenState extends State<ListMealsScreen> {
  CategoryItem categoryItem;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    categoryItem = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: <Widget>[
            _buildWidgetBackgroundCircle(mediaQuery),
            _buildWidgetContent(mediaQuery),
          ],
        ),
      ),
    );
  }

  Widget _buildWidgetContent(MediaQueryData mediaQuery) {
    return SafeArea(
      minimum: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(padding: EdgeInsets.only(top: 16.0)),
          Hero(
            tag: "label_item_category_${categoryItem.idCategory}",
            child: Text(
              categoryItem.strCategory,
              style: Theme.of(context)
                  .textTheme
                  .display2
                  .merge(TextStyle(fontWeight: FontWeight.bold)),
              maxLines: 1,
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 16.0)),
          Expanded(
            child: FutureBuilder(
              future:
                  listMealsBloc.getFilterCategories(categoryItem.strCategory),
              builder: (BuildContext context,
                  AsyncSnapshot<FilterCategories> snapshot) {
                if (snapshot.hasData) {
                  FilterCategories filterCategories = snapshot.data;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: filterCategories.filterCategoryItems.length,
                    itemBuilder: (context, index) {
                      FilterCategoryItem filterCategoryItem =
                          filterCategories.filterCategoryItems[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: GestureDetector(
                          onTap: () {
                            // TODO: do something in here
                            print("tap item list meals");
                          },
                          child: Card(
                            elevation: 8.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16.0),
                              child: Stack(
                                children: <Widget>[
                                  FadeInImage(
                                    image: NetworkImage(
                                        filterCategoryItem.strMealThumb),
                                    placeholder: AssetImage(
                                        "assets/images/img_placeholder.jpg"),
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: mediaQuery.size.width / 1.5,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: mediaQuery.size.width / 1.5,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          stops: [
                                            0.1,
                                            0.9
                                          ],
                                          colors: [
                                            Color(0xFFFFFFFF),
                                            Color(0x00FFFFFF),
                                          ]),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Expanded(
                                          child: Text(
                                            filterCategoryItem.strMeal,
                                            style:
                                                Theme.of(context).textTheme.title,
                                            maxLines: 2,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            // TODO: do something in here
                                            print("tap favorite");
                                          },
                                          child: CircleAvatar(
                                            backgroundColor: Color(0xAFE8364B),
                                            child: Icon(
                                              Icons.favorite_border,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                return Center(child: buildCircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWidgetBackgroundCircle(MediaQueryData mediaQuery) {
    return Positioned(
      top: -100.0,
      left: -100.0,
      child: Container(
        width: mediaQuery.size.height / 2.2,
        height: mediaQuery.size.height / 2.2,
        decoration: BoxDecoration(
          color: Color(0x3FE8364B),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
