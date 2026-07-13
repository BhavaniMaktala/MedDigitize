# 🏥 MedDigitize

MedDigitize is an AI-powered healthcare application that converts handwritten medical prescriptions into digital Electronic Medical Records (EMRs). The application provides a simple and user-friendly interface for patients and healthcare professionals to securely scan, process, and manage prescription records.

---

## 📌 Features

- 👤 User Registration & Login
- 💾 Persistent Login using Shared Preferences
- 📷 Prescription Image Scanning
- 🤖 AI/OCR-Based Prescription Digitization
- 📄 Digital Electronic Medical Records (EMR)
- 🏥 Healthcare Dashboard
- 📱 Clean and Responsive Flutter UI

---

## 🛠️ Tech Stack

### Frontend
- Flutter
- Dart

### Backend
- Node.js
- Express.js

### AI / OCR
- Google ML Kit

### Database
- JSON (Current)
- MySQL (Planned)

### Authentication
- Shared Preferences

---

## 📂 Project Structure

```
MedDigitize/
│
├── android/
├── ios/
├── lib/
│   ├── main.dart
│   ├── login.dart
│   ├── register.dart
│   ├── home.dart
│   ├── scanner.dart
│   ├── prescription_scan.dart
│   ├── emr_screen.dart
│   ├── shared_prefs.dart
│   └── ...
│
├── backend/
│   ├── server.js
│   ├── emrParser.js
│   └── data/
│
├── assets/
├── web/
├── macos/
├── windows/
└── pubspec.yaml
```

---

## 🚀 Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/BhavaniMaktala/MedDigitize.git
```

### 2. Navigate to Project

```bash
cd MedDigitize
```

### 3. Install Flutter Dependencies

```bash
flutter pub get
```

### 4. Run the Flutter Application

```bash
flutter run
```

---

## Backend Setup

Navigate to the backend folder:

```bash
cd backend
```

Install dependencies:

```bash
npm install
```

Start the backend server:

```bash
node server.js
```

---

## Screens

- Splash Screen
- Welcome Screen
- Login
- Register
- Home
- Prescription Scanner
- EMR Screen
- User Profile

---

## Future Enhancements

- MySQL Database Integration
- Cloud Storage
- Doctor Dashboard
- Patient History
- PDF Report Generation
- AI-Based Medicine Recognition
- Appointment Scheduling
- Hospital Management Integration

---

## Author

**Bhavani Maktala**

- GitHub: https://github.com/BhavaniMaktala
- LinkedIn: www.linkedin.com/in/bhavani-maktala-a3042a2b8

---

## License

This project is intended for educational and learning purposes.
