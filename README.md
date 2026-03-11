<<<<<<< HEAD
# task_management_system

A new Flutter project.

## Getting Started

Flutter Framework

The application is developed using Flutter, a modern cross-platform framework.

Key Advantages:

Cross-platform: Single codebase runs on Android, iOS, and Web.

Fast Development: Hot reload enables rapid iteration and testing.

Customizable UI: Rich widget system allows fully flexible and attractive interfaces.

Multi-language & Theme Support: Supports Arabic and English, as well as light and dark modes.

Maintainable & Scalable: Clean architecture facilitates easy extension and maintenance.
Structure Overview

The project is divided into two main layers for clarity and maintainability:

Core Layer

Contains reusable and fundamental functionality:

Constants & Theme: Colors, fonts, styling.

Extensions: Dart extensions for utility functions.

Network & Data Layer: Handles API calls, data models, repositories, and shows the relationship between components clearly.

Utilities & Helpers: Shared validators, services, and functions.

Application Layer

Contains feature-specific code:

Organized into feature folders (e.g., login, dashboard, profile).

Each feature folder contains:

models/ – data models

screens/ – UI screens

widgets/ – feature-specific reusable widgets

controllers/ – business logic / state management

services/ – API calls or feature-specific services

Folder Structure Example:

lib/
├── core/
│   ├── constants/
│   ├── extensions/
│   ├── network/
│   └── utils/
└── application/
├── login/
│   ├── models/
│   ├── screens/
│   ├── widgets/
│   ├── controllers/
│   └── services/
├── dashboard/

Network/Data Layer is centralized to illustrate how the architecture components are connected and to organize data usage clearly.

State Management is applied inside screens when interacting with a real backend for responsive and maintainable updates.

Additional Features:

Dashboard Screen:

Added to provide a clear visual overview of task statuses.

Makes task monitoring easier and more engaging for users.

Theme Support:

Supports light and dark modes across both mobile and web platforms.

Provides a consistent and comfortable user experience.

Multi-language Support:

Fully supports Arabic and English, including layout adjustments for RTL (Right-to-Left).


Setup / Installation

Mobile APK : Download APP  https://drive.google.com/file/d/1AF0vlNYyaaaorJTcoKCrVTnjZqM5trbM/view?usp=sharing
Web App: Open Link https://raghadhamsho.github.io/task_management/
