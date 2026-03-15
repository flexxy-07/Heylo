# Environment Configuration

This project uses environment variables to manage sensitive configuration like Firebase API keys.

## Setup Instructions

### 1. Create `.env` file

Copy the `.env.example` file to `.env`:

```bash
cp .env.example .env
```

### 2. Add Your API Keys

Open `.env` and replace the placeholder values with your actual Firebase configuration:

```env
# Firebase Configuration
FIREBASE_PROJECT_ID=your_project_id
FIREBASE_MESSAGING_SENDER_ID=your_messaging_sender_id
FIREBASE_STORAGE_BUCKET=your_storage_bucket
FIREBASE_AUTH_DOMAIN=your_auth_domain

# Firebase Android API Key
FIREBASE_ANDROID_API_KEY=your_android_api_key
FIREBASE_ANDROID_APP_ID=your_android_app_id

# Firebase iOS API Key
FIREBASE_IOS_API_KEY=your_ios_api_key
FIREBASE_IOS_APP_ID=your_ios_app_id
FIREBASE_IOS_BUNDLE_ID=your_ios_bundle_id

# Firebase Web API Key
FIREBASE_WEB_API_KEY=your_web_api_key
FIREBASE_WEB_APP_ID=your_web_app_id

# App Configuration
APP_NAME=Heylo
APP_VERSION=1.0.0
```

## Usage in Code

Use the `EnvConfig` class to access environment variables:

```dart
import 'package:heylo/config/env_config.dart';

// Access Firebase Android API Key
String apiKey = EnvConfig.firebaseAndroidApiKey;

// Access Firebase Project ID
String projectId = EnvConfig.firebaseProjectId;

// Access App Name
String appName = EnvConfig.appName;
```

## Important Security Notes

⚠️ **IMPORTANT**: 

- Never commit `.env` file to version control (it's already added to `.gitignore`)
- Always use `.env.example` as the template for new contributors
- Keep API keys confidential and never share them publicly
- Rotate API keys if they are accidentally exposed

## Files

- `.env` - Your actual environment variables (git-ignored, local only)
- `.env.example` - Template file showing the required variables
- `lib/config/env_config.dart` - Configuration class for accessing environment variables
