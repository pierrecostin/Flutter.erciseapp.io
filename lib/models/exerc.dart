class Exerc {
  final String exercPart, name, imagePath, kiloCaloriesBurnt, timeDone;

  Exerc(
      {this.exercPart,
      this.name,
      this.imagePath,
      this.kiloCaloriesBurnt,
      this.timeDone});
}

final exerc = [
  Exerc(
    exercPart: "UPPER BODY",
    name: "Shoulder",
    kiloCaloriesBurnt: "230",
    timeDone: "20mins",
    imagePath: "images/shoulderPhoto.jpg",
  ),
  Exerc(
    exercPart: "MID SECTION",
    name: "Chest",
    kiloCaloriesBurnt: "210",
    timeDone: "40mins",
    imagePath: "images/chestPhoto.jpg",
  ),
  Exerc(
    exercPart: "LOWER BODY",
    name: "Legs",
    kiloCaloriesBurnt: "170",
    timeDone: "50mins",
    imagePath: "images/legPhoto.jpg",
  ),
];
