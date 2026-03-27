# PocketLog (SwiftUI + WidgetKit)

PocketLog is a high-contrast, minimal budgeting prototype focused on ultra-fast expense logging.

## Highlights
- App opens directly to a bold numeric keypad for instant amount entry.
- Widget includes an interactive **Quick Log $10** action using `AppIntent`.
- Shared `SwiftData` store via App Group: `group.com.example.pocketlog`.
- Daily local budget reminder notifications (scheduled for 8:00 PM by default).

## Build Setup
This repository includes an **XcodeGen** spec (`project.yml`) for generating the Xcode project.

```bash
xcodegen generate
open PocketLog.xcodeproj
```

Then, in Xcode:
1. Set your Apple Team in Signing for both targets.
2. Ensure App Group capability is enabled for both app and widget with the same identifier.
3. Build and run on iOS 17+ for interactive widget behavior.

## Important Disclaimer
This code is for educational purposes only. The developer is responsible for ensuring compliance with Apple App Store guidelines and local laws. Do not copy protected branding, proprietary UI, or assets from existing apps.
