//@Author : Amr Aboeleneen
// @Date  : 09-07-2021

import 'dart:math';

const _chars = 'AaBbCcdefghijklmnopqrstuvwxyz1234567890';
Random _rnd = Random();

//// The food List ...
Map<String,List<dynamic>> foodMap = {
  "snacks": [
    'Ice cream',
    'Cream',
    'Sandwich',
  ],
  "breakfast" : [
    'Cheese',
    'Egg',
    'Butter',
  ],
  "dinner" : [
    'Cheese',
    'Egg',
    'Butter',
    'Margarine',
    'Yogurt',
    'Cottage cheese'
  ],
  "mainDish" : [
    'Sausage',
    'Hamburger',
    'Hot dog',
    'Bread',
    'Pizza',
    'Steak',
    'Roast chicken',
    'Fish',
    'Seafood',
    'Ham',
    'Kebab',
    'Bacon',
    'Sour cream'
  ]
};


//////////////    Helper functions           ////////////////

//// A helper function, generates a  List of random indeces to pick from
randomIndexGenerator(int numberOfIndeces) {
  int counter = 0;

  List<int>? indeces = [];
  while (counter != numberOfIndeces) {
    indeces.add(_rnd.nextInt(_chars.length - 1));
    counter += 1;
  }
  return indeces;
}
//// A helper function to generate a random Date
generateRandomDate() {
  return '${_rnd.nextInt(28)}-${_rnd.nextInt(12)}-${_rnd.nextInt(20)+1990}';
}
//// Generates random Email or Name depends on the second Parameter.
nameEmailGenerator(int lenghtOfGenerated, bool emailMode) {
  List<int> indeces = randomIndexGenerator(lenghtOfGenerated);
  String randomBuilder = "";
  // Name Mode...
  if (emailMode == false) {
    for (var i in indeces) {
      randomBuilder = randomBuilder + _chars[i];
    }
    return randomBuilder;
  }
  // Email Mode
  else {
    for (var i in indeces) {
      randomBuilder = randomBuilder + _chars[i];
    }

    //whether or not to put an extenstion
    bool addExtenstion = _rnd.nextBool();
    String extenstion = addExtenstion == true ? "@gmail" : "";
    return randomBuilder + extenstion + '.com';
  }
}
//// Validates email once its passed
validateEmail(String email) {
  return RegExp(r"^[a-z0-9]+@[a-z0-9]+.com$").hasMatch(email);
}



//////////////    Main functions           ////////////////


//// Generate a list of meals for the given [numberOfDays]
generateDaysMeals(int numberOfDays){
  List<Map<String,dynamic>> myList = [];
  int counter = 0;
  while(counter<numberOfDays){
    myList.add(
    {
      "${generateRandomDate()}" : {
    "breakfast" : "${generateMeal(1,"breakfast")}",
    "dinner" : "${generateMeal(1,"dinner")}",
    "mainDish" : "${generateMeal(2,'mainDish')}",
    "snacks" : "${generateMeal(2,"snacks")}"
    }
    });
    counter++;
  }
  return myList;
}
/// Generates a Student with random Email , name, Age and absence dates + amount
userMealsSimulator(numberOfUsers,maxNumberOfDates) {
  int i = 0;
  List<Map<String, dynamic>>? myObjects = [];
  while (i != numberOfUsers) {
    Map<String,Map<String, dynamic>> new_map = {
      "User":{
        "email": nameEmailGenerator(10, true),
        "name": nameEmailGenerator(5, false),
        "password": nameEmailGenerator(10, false)
      },
      "Calender":{
          "meals" : generateDaysMeals(maxNumberOfDates)
      }
    };
    myObjects.add(new_map);
    i += 1;
  }
  return myObjects;
}
//// receives numberOfMeals and return random Meals with number [numberOfMeals]
generateMeal(int numberOfMeals,mealType) {
  List<Map<String,dynamic>>? listOfMeals = [];
  int counter = 0;
  while(numberOfMeals>counter){
    Map<String,dynamic> oneMeal = {
      "item $counter" : foodMap[mealType]![_rnd.nextInt(foodMap[mealType]!.length)]
    };
    listOfMeals.add(oneMeal);
    counter++;
  }
  return listOfMeals;
}


//// Testing function.
main(List<String> args) {
  List<Map<String, dynamic>>? myObjects = userMealsSimulator(2,5); //Generates 20 students
  print(myObjects);

  // print(generateMeal(3,'mainDish'));
  // print(generateDaysMeals(2));
}

