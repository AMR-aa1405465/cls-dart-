// Stds
// name, email, age, upsent
// 5 Students

// 1- Validation for each email ( @, .com, lower case, white spaces )
// 2- validation if upsent > 5 : remove student
// 3- validation if upsent > 3 : add warning field into his map
// 4- avg students ages > reduce

import 'dart:math';

const _chars = 'AaBbCcdefghijklmnopqrstuvwxyz1234567890';
Random _rnd = Random();

/// Generates a Student with random Email , name, Age and absence dates + amount
studentsGenerator(numberOfStudents) {
  int i = 0;
  List<Map<String, dynamic>>? myObjects = [];
  while (i != numberOfStudents) {
    Map<String, dynamic> new_map = {
      "email": nameEmailGenerator(10, true),
      "name": nameEmailGenerator(5, false),
      "Age": _rnd.nextInt(_chars.length - 1),
      "absent": randomAbsentGenerator(4)
    };
    myObjects.add(new_map);
    i += 1;
  }
  return myObjects;
}

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
  return '${_rnd.nextInt(28)}-${_rnd.nextInt(12)}-${_rnd.nextInt(2021)}';
}

//// A function to generate random absences in a list.
randomAbsentGenerator(int maxAbsensec) {
  int _localCounter = 0;
  List<String> myList = [];
  int numberToGenerte = _rnd.nextInt(maxAbsensec) + 1; //At least one
  while (_localCounter != numberToGenerte) {
    myList.add(generateRandomDate());
    _localCounter += 1;
  }
  return myList;
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

mainCaller(List students) {
  // Validates the students ...
  // students =
  //     students.where((element) => validateEmail(element['email'])).toList();

  // First validation ... Not sure whether to remove Non-validated or not...

  students.forEach((element) {
    print(element['email'].toString() +
        "\t" +
        validateEmail(element['email']).toString());
  });

  //Second & Third validation
  students.forEach((element) {
    int numberOfAbsences = element['absent'].length;
    if (numberOfAbsences > 5) {
      students.remove(element);
    } else if (numberOfAbsences > 3) {
      element['warning'] = "Warning! Student has More than 3 absences!";
    }
  });
  print("Student after filtering: $students");

  //Final task , calculating the average
  double avg = students
      .map((e) => e['Age']) //To get the list of Ages
      .reduce(
          (value, element) => value + element / students.length); //Moving avg.

  print(avg);
}

main(List<String> args) {
  List myObjects = studentsGenerator(20); //Generates 20 students
  // print(myObjects);
  mainCaller(myObjects); // calls your validations..
}
