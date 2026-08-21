# Mobile Application Development - Week 3

A simple **Dart TODO Console Application** developed for the Mobile Application Development course.

This project consists of a Dart frontend application and a JSON Server backend. The frontend communicates with the backend through a REST API, while task data is stored in `db.json`.

## How to Clone and Run

### Requirements

Make sure the following are installed:

* Git
* Dart SDK
* Node.js
* npm

Check your installations:

```bash
git --version
dart --version
node --version
npm --version
```

### 1. Clone the Repository

```bash
git clone https://github.com/Meawdam/Mobile-Application-Development-Week-3.git
cd Mobile-Application-Development-Week-3
```

### 2. Setup the Backend

Open a terminal and run:

```bash
cd backend
npm install
npx json-server db.json
```

The backend will run at:

```text
http://localhost:3000
```

The TODO API is available at:

```text
http://localhost:3000/todo
```

**Keep this terminal running.**

### 3. Setup the Frontend

Open a **new terminal** and run:

```bash
cd Mobile-Application-Development-Week-3/frontend
dart pub get
dart run
```

Alternatively:

```bash
dart run bin/frontend.dart
```

### Quick Setup

If you have already cloned the repository, you can run the project using two terminals.

**Terminal 1 - Backend**

```bash
cd Mobile-Application-Development-Week-3/backend
npm install
npx json-server db.json
```

**Terminal 2 - Frontend**

```bash
cd Mobile-Application-Development-Week-3/frontend
dart pub get
dart run
```

Both terminals need to remain open while using the application.

---

## Features

* View all tasks
* Add a new task
* Delete a task
* Edit a task
* Toggle task completion status
* Search tasks
* Exit the application

## Technologies

### Frontend

* Dart
* HTTP
* REST API
* JSON

### Backend

* Node.js
* JSON Server
* JSON

## Project Structure

```text
Mobile-Application-Development-Week-3/
│
├── backend/
│   ├── db.json
│   ├── package.json
│   ├── package-lock.json
│   └── .gitignore
│
├── frontend/
│   ├── bin/
│   │   └── frontend.dart
│   ├── lib/
│   │   ├── logic.dart
│   │   └── model.dart
│   ├── test/
│   ├── pubspec.yaml
│   ├── pubspec.lock
│   └── analysis_options.yaml
│
└── Readme.md
```

## Application Menu

The application provides the following menu:

```text
======== Menu ========
1. View Tasks
2. Add New Task
3. Delete Task
4. Toggle Task Status
5. Edit Task
6. Search Task
7. Exit
```

Select an option by entering its corresponding number.

## Task Model

Each task contains three main properties:

```text
id
title
complete
```

Example:

```json
{
  "id": "1",
  "title": "Study Dart",
  "complete": false
}
```

## Backend API

The Dart application communicates with JSON Server using HTTP requests.

The API base URL is:

```text
http://localhost:3000/todo
```

### Get Tasks

```http
GET /todo
```

### Add Task

```http
POST /todo
```

Example request body:

```json
{
  "title": "Study Dart",
  "complete": false
}
```

### Edit Task

```http
PATCH /todo/:id
```

### Toggle Task Status

```http
PATCH /todo/:id
```

### Delete Task

```http
DELETE /todo/:id
```

## Application Architecture

The frontend separates the model and API logic.

### `bin/frontend.dart`

Responsible for:

* Console user interface
* Displaying the menu
* Receiving user input
* Calling application functions

### `lib/model.dart`

Contains the `Task` model and handles conversion between Dart objects and JSON.

### `lib/logic.dart`

Contains the `Connector` class, which handles communication with the REST API.

The general flow is:

```text
User
 │
 ▼
frontend.dart
 │
 ▼
Connector
 │
 │ HTTP Request
 ▼
JSON Server
 │
 ▼
db.json
```

## Troubleshooting

### Cannot connect to the API

Make sure JSON Server is running:

```bash
cd backend
npx json-server db.json
```

Then verify that the API is available at:

```text
http://localhost:3000/todo
```

### Dart dependencies are missing

Run:

```bash
cd frontend
dart pub get
```

### `npm` command is not found

Install Node.js and make sure `npm` is available in your system PATH.

### `dart` command is not found

Install the Dart SDK and make sure Dart is available in your system PATH.

## Learning Objectives

This project demonstrates:

* Dart programming
* Classes and objects
* Object-oriented programming
* JSON encoding and decoding
* HTTP requests
* REST APIs
* CRUD operations
* Async/Await
* Futures
* Client-server communication
* Separation of application logic and models

## Author

**Meawdam**

Mobile Application Development - Week 3
