# Mystory

**Mystory**  is an iOS app built for children on the **autism spectrum**. It helps parents and caregivers support their children in recognizing everyday social situations, understanding big feelings, and practicing appropriate responses to them — through short illustrated stories, gentle narration, and simple comprehension checks.

## Purpose

Children on the autism spectrum often benefit from clear, repeatable, visual guidance when learning social behavior and emotional regulation. Mystory turns common childhood moments — wanting to join other kids playing, feeling shy, feeling angry, seeing a friend who is sad — into short narrated stories the child can read (or listen to) at their own pace, followed by a simple quiz that reinforces the lesson. A short celebration animation rewards a correct answer; an encouraging "try again" screen follows an incorrect one, so there is no wrong way to engage.

The goal isn't to entertain — it's to give families a consistent, low-pressure tool they can use again and again to model appropriate behavior in situations that are often difficult to talk through in the moment.

## Key Features

- **Character selection** — the child picks a boy or girl avatar; the rest of the app mirrors content for that character.
- **Illustrated, narrated stories** — four scenarios per character (wanting to play, shyness, anger, comforting a sad friend), each a short two-page story with a matching background illustration and audio narration.
- **Listen / pause narration** — every story page can be read aloud, so the app works for children who read independently and those who don't yet.
- **Comprehension quiz** — after each story, a two-question quiz (multiple choice + true/false) checks whether the child recognized the right response.
- **Positive reinforcement** — a correct quiz answer leads to an animated celebration screen; an incorrect one leads to a supportive "try again" screen before returning to the quiz.
- **Create your own story** — a simple story editor lets a parent or child build a custom story (title, pages, photos) saved locally, kept separate per character.
- **Arabic-first, bilingual** — the app defaults to Arabic (with full English localization support), since it was built for Arabic-speaking families.
- **Light-mode only** — a deliberately calm, consistent visual presentation regardless of system appearance settings, which matters for children who are sensitive to visual changes.

## How It Works (User Flow)

1. **Splash** → animated welcome screen.
2. **Character Selection** → choose boy or girl.
3. **Home** → choose "Read a Story" or "Create a Story."
4. **Category** → pick a scenario: Play, Shy, Angry, or Sad.
5. **Story** → two narrated pages with a "Finish" button on the last page.
6. **Quiz** → two comprehension questions about the story just read.
7. **Celebration** or **Try Again** → based on the quiz result, then back to Home.

## Tech Stack

- **SwiftUI** for the entire UI
- **AVFoundation** for narration playback
- **AppStorage** for locally saved custom stories (separated per character)
- Targets **iOS 26.1+**, built with **Xcode 26.1**, **Swift 5**

## Project Structure

The codebase follows an **MVVM** layout:

```
Mystory/
  App/            App entry point
  Models/         Plain data types (Story, QuizScenario, StoryStyle, ...)
  ViewModels/      ObservableObject classes (audio playback, home/category state)
  Views/
    Splash/, CharacterSelection/, Home/, Story/, Quiz/, Celebration/, TryAgain/, CreateStory/, Shared/
  Resources/
    Audio/         Narration clips
  Assets.xcassets  Illustrations, colors, icons
  ar.lproj/, en.lproj/   Localized strings
```

All eight story screens (four per character) share a single reusable `BaseStoryView` template driven by data, and all four girl-character quizzes share a single `BaseQuizView` template — this keeps behavior consistent across characters while each scenario only supplies its own text, images, and audio.

## Getting Started

1. Open `Mystory.xcodeproj` in Xcode 26.1 or later.
2. Select the `Mystory` scheme.
3. Build and run on an iOS 26.1+ simulator or device.

No third-party dependencies or package managers are required.

## Localization

All user-facing text lives in `Localizable.strings` (`ar.lproj` / `en.lproj`). The app forces Arabic on first launch but fully supports English if the system language is changed.
