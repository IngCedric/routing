# 🎬 CineList

Application Flutter multi-écrans pour parcourir un catalogue de films, consulter leurs
détails et se constituer une watchlist personnelle.

Projet réalisé dans le cadre de l'exercice **« App multi-écrans avec navigation »**.

---

## ✨ Fonctionnalités

- **Catalogue de films** avec recherche par titre en temps réel et filtrage par genre
- **Fiche détaillée** de chaque film (genre, année, note, synopsis)
- **Watchlist personnelle** alimentée par un formulaire d'ajout
- **Formulaire validé** (titre, genre, note) avec messages d'erreur explicites
- **Thème clair / sombre** basculable depuis la barre d'application
- **Interface responsive** : liste verticale sur mobile, grille sur tablette

---

## 📱 Captures d'écran

| Accueil (thème clair) | Accueil (thème sombre) | Détail d'un film |
| :---: | :---: | :---: |
| ![Accueil en thème clair](screenshots/home_light.png) | ![Accueil en thème sombre](screenshots/home_dark.jpeg) | ![Écran de détail](screenshots/detail.jpeg) |

---

## 🗺️ Écrans et navigation

La navigation est gérée par [`go_router`](https://pub.dev/packages/go_router).

| Route | Écran | Rôle |
| --- | --- | --- |
| `/` | `HomeScreen` | Liste des films, recherche et filtres par genre |
| `/detail/:id` | `DetailScreen` | Détail d'un film, reçoit l'`id` en paramètre de route |
| `/add` | `AddMovieScreen` | Formulaire d'ajout d'un film à la watchlist |
| `/watchlist` | `WatchlistScreen` | Films ajoutés par l'utilisateur |

Le passage de paramètres se fait via l'URL : depuis l'accueil, un appui sur une carte
déclenche `context.push('/detail/${film.id}')`, et l'écran de détail relit cette valeur
avec `state.pathParameters['id']`.

---

## 🧩 Structure du projet

```
lib/
├── main.dart                     # Point d'entrée, MaterialApp.router et gestion du thème
├── data/
│   ├── movies_repository.dart    # Catalogue de films (source de données)
│   └── watchlist_repository.dart # Watchlist en mémoire + valeurs par défaut
├── models/
│   └── movie.dart                # Modèle Movie
├── router/
│   └── app_router.dart           # Configuration GoRouter
├── screens/
│   ├── HomeScreen.dart
│   ├── DetailScreen.dart
│   ├── AddMovieScreen.dart
│   └── WatchlistScreen.dart
├── theme/
│   └── app_theme.dart            # Thèmes clair et sombre
└── widgets/                      # Widgets réutilisables
    ├── movie_card.dart           # Carte d'un film
    ├── genre_chip.dart           # Puce de genre sélectionnable
    └── rating_stars.dart         # Notation en étoiles
```

**Séparation UI / données** : aucune donnée n'est écrite en dur dans les widgets.
Les films proviennent des repositories du dossier `data/`, et les écrans ne font
que les afficher ou transmettre la saisie de l'utilisateur.

---

## 🛠️ Technologies

| Outil | Version |
| --- | --- |
| Flutter | 3.44.8 (canal stable) |
| Dart | 3.12.2 |
| `go_router` | ^17.5.0 |
| `cupertino_icons` | ^1.0.8 |

Le SDK Dart minimum requis est déclaré dans `pubspec.yaml` : `^3.12.2`.

---

## 🚀 Instructions de lancement

### Prérequis

- [Flutter SDK](https://docs.flutter.dev/get-started/install) 3.44 ou supérieur
- Un émulateur Android / simulateur iOS, ou un appareil physique connecté
- Vérifier que l'environnement est prêt :

```bash
flutter doctor
```

### Installation

```bash
# 1. Cloner le dépôt
git clone https://github.com/<ton-utilisateur>/cinelist.git
cd cinelist

# 2. Installer les dépendances
flutter pub get
```

### Lancer l'application

```bash
# Lister les appareils disponibles
flutter devices

# Lancer sur l'appareil de son choix
flutter run -d <device-id>
```

Exemples :

```bash
flutter run -d emulator-5554   # émulateur Android
flutter run -d chrome          # navigateur web
flutter run -d windows         # application de bureau Windows
```

Pendant l'exécution, dans le terminal :

- `r` — hot reload (recharge le code modifié)
- `R` — hot restart (nécessaire après un changement de thème ou de structure de widget)
- `q` — quitter

### Démarrer un émulateur Android

```bash
flutter emulators                              # lister les émulateurs
flutter emulators --launch <emulator-id>       # en démarrer un
```

### Générer un APK

```bash
flutter build apk --release
```

L'APK est produit dans `build/app/outputs/flutter-apk/app-release.apk`.

### Vérifier le code

```bash
flutter analyze
```

---
