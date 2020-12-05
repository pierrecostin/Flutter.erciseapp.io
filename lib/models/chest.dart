class Chest {
  final String name, imagePath, equipmentNeeded, description;

  Chest({this.name, this.imagePath, this.equipmentNeeded, this.description});
}

final chest = [
  Chest(
    name: "CHEST PRESS",
    imagePath: "images/chestPress.jpg",
    equipmentNeeded: "Required: Bench Press",
    description:
        "Position yourself on the bench with your feet firmly on the ground and your back flat (the bar should be directly over your eyes, and your head, shoulders, and buttocks should be on the bench).",
  ),
  Chest(
    name: "CABLE PULL",
    imagePath: "images/chestCable.jpg",
    equipmentNeeded: "Required: Cable Set",
    description:
        "Make your movements slow and controlled — no jerking — as you bring your hands together and extend your arms. For a wider arc and more resistance, move your arms down first and then in toward each other to cross one hand over",
  ),
  Chest(
    name: "CHEST CURL",
    imagePath: "images/chestCurl.jpg",
    equipmentNeeded: "Required: Dumb Bells",
    description:
        "Press your shoulders, back, head, and buttocks to the bench. Position the dumbbells near your chest and armpits with your palms facing inward. Keep your wrists straight.",
  ),
];
