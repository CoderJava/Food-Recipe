import 'package:flutter/material.dart';
import 'package:food_recipe/src/blocs/searchmeals/search_meals_bloc.dart';
import 'package:food_recipe/src/models/searchmeals/search_meals.dart';
import 'package:food_recipe/src/ui/detailmeals/detail_meals_screen.dart';
import 'package:food_recipe/src/utils/utils.dart';
import 'package:food_recipe/values/color_assets.dart';

class SearchMealsScreen extends StatefulWidget {
  @override
  _SearchMealsScreenState createState() => _SearchMealsScreenState();
}

class _SearchMealsScreenState extends State<SearchMealsScreen> {

  @override
  void dispose() {
    searchMealsBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            _buildWidgetBackground(),
            _buildWidgetContent(mediaQuery, context),
          ],
        ),
      ),
    );
  }

  Widget _buildWidgetContent(MediaQueryData mediaQuery, BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(padding: EdgeInsets.only(top: 16.0 + mediaQuery.padding.top)),
          Text(
            "Search\nSomething ?",
            style: Theme.of(context).textTheme.display1.merge(
                  TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Roboto",
                  ),
                ),
          ),
          Padding(padding: EdgeInsets.only(top: 16.0)),
          _buildTextFieldSearchMeals(),
          Padding(padding: EdgeInsets.only(top: 16.0)),
          Expanded(child: _buildResultSearchMeals(mediaQuery)),
        ],
      ),
    );
  }

  Widget _buildResultSearchMeals(MediaQueryData mediaQuery) {
    return StreamBuilder(
      stream: searchMealsBloc.resultSearchMealsByKeyword,
      builder: (BuildContext context, AsyncSnapshot<SearchMeals> snapshot) {
        if (snapshot.hasData) {
          SearchMeals searchMeals = snapshot.data;
          if (searchMeals.isLoading) {
            return Center(child: buildCircularProgressIndicator());
          } else if (searchMeals.searchMealsItems == null || searchMeals.searchMealsItems.isEmpty) {
            return Container();
          }
          return ListView.builder(
            shrinkWrap: true,
            itemCount: searchMeals.searchMealsItems.length,
            itemBuilder: (context, index) {
              var searchMealsItem = searchMeals.searchMealsItems[index];
              return Padding(
                padding: EdgeInsets.only(bottom: 16.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return DetailMealsScreen(
                            searchMealsItem.idMeal,
                            searchMealsItem.strMeal,
                            searchMealsItem.strMealThumb,
                          );
                        },
                      ),
                    );
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
                          Hero(
                            tag: "image_detail_meals_${searchMealsItem.idMeal}",
                            child: FadeInImage(
                              image: NetworkImage(searchMealsItem.strMealThumb),
                              placeholder: AssetImage(
                                  "assets/images/img_placeholder.jpg"),
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: mediaQuery.size.width / 1.5,
                            ),
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
                            padding: EdgeInsets.all(16.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    searchMealsItem.strMeal,
                                    style: Theme.of(context).textTheme.title,
                                    maxLines: 2,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // TODO: do something in here
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
        return Container();
      },
    );
  }

  Widget _buildTextFieldSearchMeals() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(36.0),
        color: Color(0x2FFFFFFF),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 8.0,
        ),
        child: TextFieldSearch(),
      ),
    );
  }

  Widget _buildWidgetBackground() {
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            color: ColorAssets.primarySwatchColor,
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.white,
          ),
        )
      ],
    );
  }
}

class TextFieldSearch extends StatefulWidget {
  @override
  _TextFieldSearchState createState() => _TextFieldSearchState();
}

class _TextFieldSearchState extends State<TextFieldSearch> {
  var _textEditingControllerKeyword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(
          Icons.search,
          color: Colors.white,
        ),
        Padding(padding: EdgeInsets.only(right: 8.0)),
        Expanded(
          child: TextField(
            controller: _textEditingControllerKeyword,
            decoration: InputDecoration.collapsed(
              hintText: "Search...",
              hintStyle: TextStyle(
                color: Colors.white70,
              ),
            ),
            style: TextStyle(color: Colors.white),
            maxLines: 1,
            textInputAction: TextInputAction.search,
            onChanged: (value) {
              setState(() {});
              searchMealsBloc.searchMealsByKeyword(value);
            },
            onSubmitted: (value) {
              setState(() {});
              searchMealsBloc.searchMealsByKeyword(value);
            },
          ),
        ),
        _textEditingControllerKeyword.text.isEmpty
            ? Container()
            : GestureDetector(
                onTap: () {
                  setState(() => _textEditingControllerKeyword.clear());
                  searchMealsBloc.searchMealsByKeyword("");
                },
                child: Icon(
                  Icons.clear,
                  color: Colors.white,
                ),
              ),
      ],
    );
  }
}
