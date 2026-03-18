
# Blueprint: Color Dash Blitz App

## Overview

This document outlines the plan and implementation details for a Flutter application called "Color Dash Blitz". The app is a simple, fast-paced game designed to test the player's reflexes and cognitive association.

## Current Plan: Initial Setup

### 1. Create the Game Widget

- **File:** `lib/color_dash_blitz.dart`
- **Widget:** `ColorDashBlitzGame` (StatefulWidget)
- **State:**
    - `_score`: Player's score.
    - `_timeLeft`: Game timer.
    - `_targetColorName`: The word to display (e.g., "Red").
    - `_targetColor`: The color the word is displayed in.
    - `_colors`: A list of colors for the game.
    - `_isGameRunning`: A boolean to track the game state.
- **UI:**
    - A `Text` widget to display the color name.
    - A `GridView` of `ElevatedButton` widgets for the color choices.
    - Text widgets for Score and Time Left.
    - A "Start Game" button.

### 2. Integrate into Main App

- **File:** `lib/main.dart`
- **Changes:**
    - Update `main.dart` to display the `ColorDashBlitzGame` widget as the home screen.
    - Change the app title to "Color Dash Blitz".

### 3. Styling and Design

- Use Material Design 3 principles.
- A vibrant color scheme will be used for the game elements.
- The layout will be clean and centered, focusing the user's attention on the game.
