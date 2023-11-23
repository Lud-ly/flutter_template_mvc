library tools;

import 'package:flutter/material.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart' as gmap;

bool APP_IS_INITIALISED = false;

double SCREEN_HEIGHT(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double SCREEN_WIDTH(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

Color LIGHT_GREY = const Color.fromRGBO(237, 237, 237, 1);

Color GREY = const Color.fromRGBO(247, 247, 247, 1);

Color DARK_GREY = const Color.fromRGBO(59, 59, 59, 1);

Color COLOR_PRIMARY(BuildContext context) {
  return Theme.of(context).colorScheme.primary;
}

Color COLOR_SECONDARY(BuildContext context) {
  return Theme.of(context).colorScheme.secondary;
}

Color COLOR_TERTIARY(BuildContext context) {
  return Theme.of(context).colorScheme.tertiary;
}

const String TEXTE_ALEATOIRE =
    "Haec igitur Epicuri non probo, inquam. De cetero vellem equidem aut ipse doctrinis fuisset instructior est enim, quod tibi ita videri necesse est, non satis politus iis artibus, quas qui tenent, eruditi appellantur aut ne deterruisset alios a studiis. quamquam te quidem video minime esse deterritum.";
const String TEXTE_ALEATOIRE2 =
    "Accedat huc suavitas quaedam oportet sermonum atque morum, haudquaquam mediocre condimentum amicitiae. Tristitia autem et in omni re severitas habet illa quidem gravitatem, sed amicitia remissior esse debet et liberior et dulcior et ad omnem comitatem facilitatemque proclivior.";
const String TEXTE_ALEATOIRE3 =
    "Hoc inmaturo interitu ipse quoque sui pertaesus excessit e vita aetatis nono anno atque vicensimo cum quadriennio imperasset. natus apud Tuscos in Massa Veternensi, patre Constantio Constantini fratre imperatoris, matreque Galla sorore Rufini et Cerealis, quos trabeae consulares nobilitarunt et praefecturae.";

//const gmap.LatLng POSITION_MONTPELLIER = gmap.LatLng(43.610769, 3.876716,);


