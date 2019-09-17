import 'package:flutter/material.dart';
import 'package:stop_smog/Blog/Models/Post.dart';

// zrobić odczyt z bazy

const SampleDataBlog = const [
  Post(
    id: 1, 
    title:'Artykuł 1', 
    author: 'Grzegorz Wojnarowski', 
    color: Colors.lime,
    content: "Po trzech meczach w wielkiej hali w Rotterdamie na kolejne dwa spotkania Biało-Czerwoni przenieśli się do holenderskiej stolicy. Do większego miasta, ale obiektu, który przy Ahoy Arenie wygląda jak łupina pana Maluśkiewicza przy transatlantyku. W zaledwie 2,5 tysięcznej Sporthallen Zuid siłą rzeczy było też mniej polskich kibiców - ci wypełnili trybuny mniej więcej w dwóch trzecich. Amsterdam i okolice zamieszkuje podobno mniej naszych rodaków, a powód jest prosty - życie jest tu zdecydowanie droższe. Bilety na spotkanie z Czarnogórą drogie jednak nie były - te na wtorkowy mecz piłkarskiej Ligi Mistrzów pomiędzy Ajaksem a francuskim Lille kosztują ponoć 20 razy więcej - a patrząc na grę swojej siatkarskiej reprezentacji polscy fani mogli poczuć się jak bogacze, którym inni zazdroszczą fortuny.",
    keyWords: {"Sport","Siatkowka","Zdrowie"},
  ),

  Post(
    id: 2, 
    title:'Artykuł 2', 
    author: 'Marek Matacz', 
    color: Colors.orangeAccent,
    content: "Inżynierowie z holenderskiej Envinity Group niedawno zaprezentowali „odkurzacz” do powietrza. Siedmiometrowe urządzenie przypominające kuchenny wyciąg ma zasysać powietrze w promieniu 300 m, oczyszczając 800 tys. metrów sześciennych w ciągu godziny. Takie filtry miałyby być montowane na dachach budynków. I choć pomysł ten może wydawać się absurdalny, być może zostanie wkrótce zrealizowany.",
    keyWords: {"Smog","Zdrowie"},
  ),

    Post(
    id: 3, 
    title:'Artykuł 3', 
    author: 'Jan Nowak', 
    color: Colors.deepPurple,
    content: "Bank wywiesił na swojej stronie komunikat, w którym przeprasza za utrudnienia i dziękuje za cierpliwość. W związku z pracami technicznymi mogą występować chwilowe utrudnienia w zalogowaniu się do serwisu transakcyjnego Volkswagen Banku - czytamy w komunikacie. W trosce o jak najwyższą jakość świadczonych usług, dokładamy wszelkich starań, aby jak najszybciej zakończyć prace techniczne i przywrócić pełną funkcjonalność systemu - napisano",
    keyWords: {"Bank","Ekonomia"},
  ),

    Post(
    id: 4, 
    title:'Artykuł 4', 
    author: 'Grzegorz Wojnarowski', 
    color: Colors.red,
    content: "Zacznijmy od pierwszego zapowiedzianego wynalazku – nowego smartwatcha z wbudowanymi elektrodami czytającymi EKG. Apple ogłaszając go wchodzi na rynek usług medycznych, ponieważ połączone z urządzenie aplikacje będą mogły w razie wskazujących na niebezpieczeństwo odczytów powiadamiać pogotowie. Pomysł wart uwagi, ale z pewnością nie pojawiający się po raz pierwszy. Zegarkami monitorującymi naszą pracę serca chwaliła się wcześniej już marka Cronovo, a w 2009 na rynku pojawił się Heart Beat Watch. Od tego czasu specjalnych opasek monitorujących EKG na rynku pojawiło się bardzo wiele." ,
    keyWords: {"Technologia","Ekonomia"},
  ),

    Post(
    id: 5, 
    title:'Artykuł 5', 
    author: 'Hanna Gadomska', 
    color: Colors.cyanAccent,
    content: "W mediach pojawił się głos dietetyczki Chelsey Amer, która broni tezy największych łasuchów: pizza na śniadanie jest zdrowsza niż większość płatków śniadaniowych.- Przeciętny kawałek pizzy i miska płatków śniadaniowych z pełnym mlekiem zawierają mniej więcej tyle samo kalorii. Przy czym pizza to porządna dawka protein, która zapewni uczucie sytości przez cały ranek - mówi dietetyczka w rozmowie z The Daily Meal.Za jej tezą stoi fakt, że wiele produktów zbożowych sprzedawanych w sklepach to praktycznie sam cukier.  - Płatki śniadaniowe zawierają zazwyczaj tyle cukru, ile przeciętny batonik - zauważa dietetyczka. Mleczny posiłek ze słodzonymi płatkami w roli głównej może zaspokoić nasze zapotrzebowanie na cukier, a to przecież dopiero początek dnia... ",
    keyWords: {"Jedzenie ","Zdrowie"},
  ),
  
];