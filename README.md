# Phone Addiction Mugshot

**See Your Phone Addiction. Literally.**

A native iOS app that makes phone addiction visible through hourly selfie "mugshots" based on your actual screen time.

**Developed by Conflux Solutions LLC**

---

## 📱 What It Does

Phone Addiction Mugshot tracks your daily screen time and prompts you to take a selfie after each hour of phone usage. Watch your collection of "mugshots" grow throughout the day - a visceral, visual reminder of how much time you're spending on your phone.

### Key Features

- ✅ **Real Screen Time Tracking**: Integrates with iOS Screen Time API
- 📸 **Hourly Selfie Reminders**: Automatic prompts after each hour of usage
- 🖼️ **Mugshot Gallery**: View all your daily addiction photos in one place
- 🔗 **Social Sharing**: Share your mugshots for accountability
- 🌙 **Premium Dark Mode**: Beautiful glassmorphic UI with gradient accents
- 🔒 **Privacy First**: All photos stored locally on your device
- 📊 **Weekly Insights**: Track your screen time patterns (future feature)

---

## 🛠 Build Requirements

- **Xcode**: 15.0 or later
- **iOS Deployment Target**: 17.0+
- **Language**: Swift 5.9+
- **Framework**: SwiftUI

### Required Frameworks

- `SwiftUI` - UI framework
- `FamilyControls` - Screen Time API access
- `DeviceActivity` - Activity monitoring
- `ManagedSettings` - Settings management
- `AVFoundation` - Camera capture
- `UIKit` - Native iOS components

---

## 🚀 Getting Started

### 1. Clone/Open the Project

```bash
cd "/Users/shmueldukes/Documents/Mobile App Dev Agentic Software Factory/PhoneAddictionMugshot"
open ios/PhoneAddictionMugshot.xcodeproj
```

### 2. Configure Signing

1. Open the project in Xcode
2. Select the `PhoneAddictionMugshot` target
3. Go to **Signing & Capabilities**
4. Select your **Team** (Apple Developer account)
5. Ensure **Bundle Identifier** is unique: `app.confluxsolutions.phoneaddictionmugshot`

### 3. Add Required Capabilities

The following capabilities should be enabled:
- [x] Family Controls (for Screen Time API)
- [x] Background Modes (for activity monitoring)

### 4. Configure Entitlements

Ensure your entitlements file includes:
```xml
<key>com.apple.developer.family-controls</key>
<true/>
```

### 5. Build and Run

**Simulator:**
```bash
# Build for simulator
⌘ + B

# Run on simulator
⌘ + R
```

**Physical Device:**
1. Connect your iPhone via USB
2. Select your device from the device menu
3. Build and run (⌘ + R)
4. **Important**: You must grant Screen Time and Camera permissions

---

## 📋 Testing the App

### First Launch Flow

1. **Screen Time Permission**: Grant access when prompted
2. **Camera Permission**: Allow camera access for mugshot capture
3. **Home Screen**: See your current screen time stats
4. **Capture Mugshot**: Tap "Take Mugshot Now" to test the camera
5. **Gallery**: View captured mugshots in the gallery tab
6. **Share**: Test sharing from the detail view

### Testing Screen Time Triggers

Since Screen Time data is cumulative throughout the day, testing hourly triggers requires:
- Simulating usage (not easily testable)
- Using the manual "Take Mugshot Now" button
- Testing on a device you actively use

---

## 📦 Project Structure

```
PhoneAddictionMugshot/
├── ios/
│   ├── PhoneAddictionMugshot/
│   │   ├── PhoneAddictionMugshotApp.swift    # App entry point
│   │   ├── Info.plist                         # Permissions & config
│   │   ├── Views/
│   │   │   ├── ContentView.swift              # Main tab view
│   │   │   ├── HomeView.swift                 # Home screen
│   │   │   ├── MugshotCaptureView.swift       # Camera capture
│   │   │   ├── GalleryView.swift              # Photo gallery
│   │   │   └── SettingsView.swift             # Settings
│   │   └── Managers/
│   │       ├── ScreenTimeManager.swift        # Screen Time API
│   │       ├── CameraManager.swift            # Camera handling
│   │       ├── MugshotStorageManager.swift    # Photo persistence
│   │       └── AnalyticsManager.swift         # Analytics hooks
│   └── PhoneAddictionMugshot.xcodeproj/
├── assets/
│   ├── AppIcon.png                            # 1024x1024 app icon
│   └── screenshot_*.png                       # App Store screenshots (5)
├── legal/
│   ├── PRIVACY_POLICY.md                      # Privacy policy with 2026 AI disclosure
│   ├── EULA.md                                # End User License Agreement
│   └── TERMS_OF_SERVICE.md                    # Terms of Service
├── store-metadata/
│   └── APP_STORE_METADATA.md                  # App Store listing content
└── README.md                                   # This file
```

---

## 🎨 Design System

### Color Palette

- **Primary Gradient**: Purple (#8b5cf6) to Pink (#ec4899)
- **Accent Red**: #e94560 to #ff6b9d
- **Backgrounds**: 
  - Dark Navy: #1a1a2e
  - Deep Blue: #16213e
  - Darker Blue: #0f3460
- **Text**: White with varying opacity (100%, 80%, 60%)

### Typography

- **Font**: SF Pro Rounded (system rounded)
- **Sizes**: 
  - Titles: 36-42pt
  - Stats: 72pt
  - Body: 16-18pt
  - Captions: 13-14pt

### UI Style

- Glassmorphism with `Color.white.opacity(0.08)` backgrounds
- Rounded corners (16-24px)
- Subtle borders with white opacity
- Shadow effects for depth
- Smooth gradients for CTAs

---

## 🔧 Configuration

### Analytics Integration

The app includes placeholders for PostHog or Mixpanel analytics. To enable:

1. Choose your analytics provider (PostHog or Mixpanel)
2. Update `AnalyticsManager.swift` with your API key:

```swift
static func initialize() {
    // PostHog
    PostHog.setup(withApiKey: "YOUR_API_KEY", host: "https://app.posthog.com")
    
    // OR Mixpanel
    Mixpanel.initialize(token: "YOUR_PROJECT_TOKEN")
}
```

3. Install the SDK via Swift Package Manager

### Deep Linking

The app supports the URL scheme: `phoneaddictionmugshot://`

Test deep linking:
```bash
xcrun simctl openurl booted phoneaddictionmugshot://share
```

---

## 📱 App Store Submission

### Pre-Submission Checklist

- [ ] App icon added to Assets.xcassets
- [ ] Screenshots uploaded (5 required for 6.7" display)
- [ ] Privacy Policy URL live
- [ ] Support email functional (support@confluxsolutions.app)
- [ ] Terms of Service URL live
- [ ] Age rating set to 12+
- [ ] Privacy nutrition label completed
- [ ] Review notes provided

### Submission Process

Refer to the `/appstore-publish` workflow for detailed submission steps:

```bash
# In Xcode
1. Product > Archive
2. Distribute App > App Store Connect
3. Upload build
4. Go to App Store Connect
5. Fill in metadata from store-metadata/APP_STORE_METADATA.md
6. Submit for review
```

**Important Files for Submission:**
- `assets/AppIcon.png` - App icon
- `assets/screenshot_*.png` - 5 App Store screenshots
- `store-metadata/APP_STORE_METADATA.md` - Complete metadata
- `legal/PRIVACY_POLICY.md` - Required privacy policy

---

## 📊 Post-Launch Operations

### Analytics Monitoring

Once analytics are integrated, monitor:
- **DAU/MAU**: Daily and monthly active users
- **Retention**: D1, D7, D30 retention rates
- **Mugshot Capture Rate**: How often users capture mugshots
- **Sharing Rate**: Percentage of users who share
- **Screen Time Correlation**: Usage patterns vs. mugshot frequency

### Feedback Collection

**In-App Support:**
- Settings > Contact Support opens email client
- Monitor support@confluxsolutions.app

**App Store Reviews:**
- Check App Store Connect > Ratings & Reviews
- Respond to user feedback within 48 hours

### Categorizing Feedback

Use this template to organize user feedback:

#### Technical Debt
- Bugs and crashes
- Performance issues
- UI/UX glitches

#### Feature Requests
- New functionality users want
- Improvements to existing features
- Integration requests

#### Bug Reports
- Reproducible issues
- Edge cases
- Permission problems

### Iteration Roadmap

**Version 1.1 - Bug Fixes & Polish** (2-4 weeks post-launch)
- Fix any critical bugs
- Performance optimizations
- Minor UI improvements

**Version 1.5 - Enhanced Features** (2-3 months)
- Weekly insights view
- Comparison with previous weeks
- Custom reminder schedules
- Widget support

**Version 2.0 - Social Features** (6 months)
- Group challenges
- Leaderboards
- Community sharing
- Streaks and achievements

---

## 🔒 Privacy & Compliance

### Data Collection

**What We Collect:**
- Screen time usage (locally stored)
- Selfie photos (locally stored)
- Anonymized analytics (crash reports, usage stats)

**What We DON'T Collect:**
- Personal identification
- Location data
- Contact information
- Photos uploaded to servers

### 2026 Compliance

- ✅ **AI Disclosure**: App does NOT use AI (stated in Privacy Policy)
- ✅ **CCPA Compliance**: California privacy rights documented
- ✅ **GDPR Compliance**: EU/EEA rights documented
- ✅ **Age Rating**: 12+ due to user-generated content

---

## 🆘 Troubleshooting

### Screen Time Permission Not Working
- Go to Settings > Screen Time > Family Sharing
- Ensure Screen Time is enabled
- Re-grant permission to the app

### Camera Not Capturing
- Check Settings > Privacy & Security > Camera
- Ensure app has camera permission
- Restart the app

### Mugshots Not Saving
- Check device storage space
- Verify app permissions in Settings
- Check for iOS security restrictions

### Build Errors
- Clean build folder (⇧⌘K)
- Delete derived data
- Restart Xcode
- Verify entitlements are correctly configured

---

## 📞 Support

**Conflux Solutions LLC**

- Email: support@confluxsolutions.app
- Legal: legal@confluxsolutions.app
- Privacy: privacy@confluxsolutions.app
- Website: https://confluxsolutions.app

---

## 📄 License

© 2026 Conflux Solutions LLC. All rights reserved.

This project is proprietary software. See [EULA.md](legal/EULA.md) for license terms.

---

## 🙏 Credits

**Developed by Conflux Solutions LLC**  
*Making phone addiction visible, one mugshot at a time.*

**Technology Stack:**
- Swift & SwiftUI
- iOS Screen Time API (FamilyControls framework)
- AVFoundation for camera capture
- Analytics: PostHog / Mixpanel

---

**Ready to publish?** Use the `/appstore-publish` workflow for step-by-step App Store submission guidance.
