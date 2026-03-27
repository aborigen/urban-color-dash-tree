# Color Dash Blitz

## Overview

A fun and fast-paced color matching game built with Flutter and integrated with Yandex Games using `js_interop`.

## Features

*   **Gameplay:** Match the color name to the correct color swatch.
*   **Scoring:** Increase your score with each correct match.
*   **Levels:** The game gets progressively harder as you level up.
*   **Timer:** A countdown timer adds to the excitement.
*   **High Score:** 
    *   The player's high score is fetched from the Yandex Games leaderboard upon game start.
    *   The game keeps track of the session's high score.
    *   New high scores are submitted to the Yandex Games leaderboard at the end of a game.
*   **Yandex Games Integration:** 
    *   The game is initialized with the Yandex Games SDK.
    *   Interstitial ads are shown at the beginning of each game.
    *   High scores are fetched from and submitted to the 'high_scores' leaderboard.
*   **JS Interop:** The project now uses `js_interop` to directly interact with the Yandex Games SDK in JavaScript, replacing the previous `flutter_yandex_games` package.
