# health_tracker_mobile
WTC-AGHNQZ2B



Track 1: Mobile Development - Public Health Dashboard

Overview

This repository contains the Track 1 submission for the WeThinkCode_ Mobile Development elective. It is a Flutter client application designed to consume a custom local REST API (built as part of the Data Engineering submission).

Rather than relying on hardcoded or generic mock data, this frontend dynamically fetches, decodes, and displays real-world public health statistics from the South African Medical Research Council (SAMRC), specifically focusing on Western Cape mortality metrics.

Features

Asynchronous API Integration: Utilizes the http package to execute asynchronous GET requests to a local FastAPI backend.

JSON Serialization: Parses raw JSON payloads and maps them into structured Dart UI components.

Optimized UI Rendering: Implements ListView.builder for lazy-loaded, highly performant scrolling of data records, rather than rendering the entire dataset at once.

State Management: Handles UI state dynamically, toggling between loading indicators (CircularProgressIndicator) and the populated data view using setState.

Modular Architecture: Extracts UI elements into reusable, stateless components (DataSummaryHeader, MortalityCard) for clean, maintainable code.

Tech Stack

Framework: Flutter / Dart

Target Platform: Web (Chrome) / Mobile

Packages: http

Prerequisites

Before running this application, you must have the Data Engineering SAMRC API running locally on port 8000.

Ensure your backend container is active (Uvicorn running on http://127.0.0.1:8000).

Ensure the Flutter SDK is installed on your machine.

Setup and Execution

Clone the repository:

git clone https://github.com/ltshabalala39-blip/health_tracker_mobile/



Install dependencies:

flutter pub get


Launch the application:
Since the backend CORS is configured for local testing, launch the app using Chrome to view the responsive web build:

flutter run -d chrome****
