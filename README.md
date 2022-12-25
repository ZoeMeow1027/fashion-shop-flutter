# fashion-shop-flutter

My 6th project-based learning about Fashion Shop (Electronic Commerce).

## Requirements

- Flutter (currently developing this project in 3.3.10). Pre-activated Android, iOS, Windows.
- Visual Studio Code (optional, but recommend, have Flutter and Dart extensions installed).
- You will need Android/iOS/Windows SDK based on what you will build.

## How to run this app?

- Download and install Flutter. You can [get it here](https://flutter.dev/).
- Clone this project.

- For command line:
  - Open Terminal, cd to root project and type command (`flutter run` or `flutter build` based on your preferred - this command below is for powershell, so you need to change multiline char to your supported terminal multiline):
  - Note: For `flutter build` command, please follow flutter for more information.
```powershell
# For debug (just run):

flutter run ^
--dart-define PAYPAL_URL=https://api.sandbox.paypal.com ^
--dart-define PAYPAL_CLIENTID=[YOUR_CLIENT_ID] ^
--dart-define PAYPAL_CLIENTSECRET=[YOUR_CLIENT_SECRET] ^
```
```powershell
# For build (apk):

flutter build apk ^
--dart-define PAYPAL_URL=https://api.sandbox.paypal.com ^
--dart-define PAYPAL_CLIENTID=[YOUR_CLIENT_ID] ^
--dart-define PAYPAL_CLIENTSECRET=[YOUR_CLIENT_SECRET] ^
```

- For running on VS Code:
  - Add args with PAYPAL_URL, PAYPAL_CLIENTID, PAYPAL_CLIENTSECRET to launch.json and tasks.json. Remember to add args to all tasks. If already exist, just append, do not delete.
```json
// launch.json
...

    // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Launch (debug)",
            "request": "launch",
            "type": "dart",
            "flutterMode": "debug",
            "args": [
                "--dart-define",
                "PAYPAL_URL=https://api.sandbox.paypal.com",
                "--dart-define",
                "PAYPAL_CLIENTID=[YOUR_CLIENT_ID]",
                "--dart-define",
                "PAYPAL_CLIENTSECRET=[YOUR_CLIENT_SECRET]",
            ],
        },
...
```
```json
// tasks.json
...
		{
			"type": "flutter",
			"command": "flutter",
			"args": [
				"build",
				"apk",
                "--dart-define",
                "PAYPAL_URL=https://api.sandbox.paypal.com",
                "--dart-define",
                "PAYPAL_CLIENTID=[YOUR_CLIENT_ID]",
                "--dart-define",
                "PAYPAL_CLIENTSECRET=[YOUR_CLIENT_SECRET]",
			],
			"group": "build",
			"problemMatcher": [],
			"label": "Build APK",
			"detail": ""
		},
		{
			"type": "flutter",
...
```
- Just run (F5) or build (CTRL + SHIFT + B) when you're ready.

## What features am I done?

- You can track my progress in Project Issues tab.

## Credit

- Twitter and Instagram icons provided by icons8.com.
