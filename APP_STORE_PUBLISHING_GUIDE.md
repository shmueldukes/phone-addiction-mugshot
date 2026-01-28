# Phone Addiction Mugshot - App Store Publishing Guide

**Complete step-by-step guide to publish your app to the Apple App Store**

---

## ✅ Prerequisites Checklist

Before you begin, ensure you have:

- [ ] **Apple Developer Program membership** ($99/year) - [Enroll here](https://developer.apple.com/programs/)
- [ ] **Apple ID** with App Store Connect access
- [ ] **Xcode 15.0+** installed on your Mac
- [ ] **Mac** running macOS Sonoma or later
- [ ] **Privacy Policy URL** where you'll host the legal/PRIVACY_POLICY.md file

> **Note**: If you need help setting up credentials, see the `/credentials-setup` workflow.

---

## 📋 Step-by-Step Publishing Process

### Step 1: Configure Apple Developer Credentials

1. **Verify your Apple Developer account**:
   - Go to [Apple Developer Portal](https://developer.apple.com/account)
   - Ensure your membership is active ($99/year)

2. **Get your Team ID**:
   - In Apple Developer Portal, go to **Membership**
   - Copy your **Team ID** (10-character code)

3. **Enable App Store Connect access**:
   - Go to [App Store Connect](https://appstoreconnect.apple.com)
   - Sign in with your Apple ID
   - Accept any agreements if prompted

---

### Step 2: Open Xcode Project

1. **Navigate to your project**:
   ```bash
   cd "/Users/shmueldukes/Documents/Mobile App Dev Agentic Software Factory/PhoneAddictionMugshot/ios"
   open PhoneAddictionMugshot.xcodeproj
   ```

2. **Wait for Xcode to open and index the project**

---

### Step 3: Configure App Signing in Xcode

1. **Select your project** in the left navigator
2. **Select the `PhoneAddictionMugshot` target** (not the project)
3. **Go to "Signing & Capabilities" tab**
4. **Configure signing**:
   - **Team**: Select your Apple Developer Team from dropdown
   - **Bundle Identifier**: Should be `app.confluxsolutions.phoneaddictionmugshot`
   - ✅ Enable "**Automatically manage signing**"

5. **Verify capabilities are enabled**:
   - ✅ Family Controls (for Screen Time API)
   - ✅ Background Modes (if needed)

> **Troubleshooting**: If you see signing errors, ensure your Apple ID is added in Xcode > Settings > Accounts.

---

### Step 4: Add App Icon to Xcode

The app icon was generated and saved to `assets/AppIcon.png`. Now add it to Xcode:

1. **In Xcode, open `Assets.xcassets`**
2. **Click on "AppIcon"** in the left sidebar
3. **Drag and drop** `PhoneAddictionMugshot/assets/AppIcon.png` onto the **1024x1024** slot
4. Xcode will automatically generate all required sizes

> **Verify**: All icon slots should now be filled automatically.

---

### Step 5: Create App in App Store Connect

1. **Go to [App Store Connect](https://appstoreconnect.apple.com)**
2. **Click "My Apps"** → **"+" button** → **"New App"**
3. **Fill in the form**:

   | Field | Value |
   |-------|-------|
   | **Platform** | iOS |
   | **Name** | Phone Addiction Mugshot |
   | **Primary Language** | English (U.S.) |
   | **Bundle ID** | Select `app.confluxsolutions.phoneaddictionmugshot` |
   | **SKU** | `phoneaddictionmugshot-v1` |
   | **User Access** | Full Access |

4. **Click "Create"**

---

### Step 6: Upload App Metadata to App Store Connect

Now fill in all the app information using the metadata we generated:

#### 6.1 App Information Tab

**Name & Subtitle:**
- **Name**: `Phone Addiction Mugshot`
- **Subtitle**: `Daily screen time photo tracker`

**Category:**
- **Primary**: Health & Fitness
- **Secondary**: Lifestyle

**Privacy Policy URL:**
- Upload `legal/PRIVACY_POLICY.md` to a public website, OR
- Use a Conflux Solutions URL: `https://confluxsolutions.app/privacy/phoneaddictionmugshot`

#### 6.2 Pricing and Availability

- **Price**: Select **Tier 2** ($1.99) or **Tier 3** ($2.99)
  - *Recommendation: $1.99 for launch, can increase later*
- **Availability**: Select **All Territories**

#### 6.3 App Privacy

Fill out the **App Privacy** questionnaire:

**Data Types Collected:**
- **Diagnostics** → Crash Data, Performance Data (Not Linked to You)

**What we DON'T collect:**
- ❌ Contact Info
- ❌ Location
- ❌ Photos (stored locally only)
- ❌ User Content uploaded to servers
- ❌ Identifiers for tracking

> **Reference**: See `store-metadata/APP_STORE_METADATA.md` for the complete privacy nutrition label.

#### 6.4 App Store Tab - Screenshots

**Upload Screenshots** (6.7" Display):

1. Click **+** under "iPhone 6.7" Display"
2. Upload these 5 screenshots in order:
   - `assets/screenshot_1_home_*.png`
   - `assets/screenshot_2_capture_*.png`
   - `assets/screenshot_3_gallery_*.png`
   - `assets/screenshot_4_share_*.png`
   - `assets/screenshot_5_stats_*.png`

> **Important**: Use the exact screenshots from the `assets/` folder to maintain visual consistency.

#### 6.5 App Store Tab - Description

**Copy from `store-metadata/APP_STORE_METADATA.md`:**

**Description** (the main text starting with "See Your Phone Addiction. Literally..."):
```
See Your Phone Addiction. Literally.

Ever wonder what you look like after 5 hours of scrolling? Phone Addiction Mugshot shows you the truth - one selfie at a time.

HOW IT WORKS:
📱 Tracks your actual screen time using iOS Screen Time API
📸 Prompts you for a selfie after each hour of phone use
😱 Watch your "mugshot" collection grow throughout the day
📊 See the visual proof of how much time you're really spending on your phone

[... continue with full description from metadata file]
```

**Keywords** (comma-separated):
```
screen time,phone addiction,digital wellbeing,mugshot,selfie tracker,productivity,focus,habit tracker,self control,mindfulness
```

**Support URL**:
```
https://confluxsolutions.app/support/phone-addiction-mugshot
```

**Marketing URL** (optional):
```
https://confluxsolutions.app/apps/phone-addiction-mugshot
```

**Promotional Text** (appears at top of description):
```
NEW: See the face of phone addiction - yours! Track screen time with hourly selfies. Make your phone usage visible. Get your mugshot gallery started today.
```

**Copyright**:
```
© 2026 Conflux Solutions LLC
```

#### 6.6 Age Rating

1. Click **"Edit"** next to Age Rating
2. Answer the questionnaire:
   - **Cartoon or Fantasy Violence**: No
   - **Realistic Violence**: No
   - **Sexual Content or Nudity**: No
   - **Profanity or Crude Humor**: No
   - **Alcohol, Tobacco, or Drug Use**: No
   - **Mature/Suggestive Themes**: **Infrequent/Mild** (user-generated selfies)
   - **Horror/Fear Themes**: No
   - **Gambling**: No
   - **Contests**: No

3. **Expected Rating**: **12+**

---

### Step 7: Build App Archive in Xcode

1. **In Xcode, select build destination**:
   - Click the device selector in toolbar
   - Select **"Any iOS Device (arm64)"**
   - ⚠️ Do NOT select a simulator

2. **Clean build folder** (recommended):
   - Go to **Product** → **Clean Build Folder** (or press ⇧⌘K)

3. **Create archive**:
   - Go to **Product** → **Archive**
   - Wait 1-3 minutes for build to complete
   - **Xcode Organizer** will open automatically

> **Troubleshooting**: If archive fails, check:
> - Signing is configured correctly
> - No build errors (⌘B to build first)
> - Deployment target is iOS 17.0+

---

### Step 8: Upload to App Store Connect

**In Xcode Organizer** (should open automatically after archiving):

1. **Select your archive** from the list
2. **Click "Distribute App"**
3. **Select "App Store Connect"** → Click **Next**
4. **Select "Upload"** → Click **Next**
5. **Signing Options**:
   - ✅ **Automatically manage signing** (recommended)
   - ✅ **Upload your app's symbols to receive symbolicated reports**
   - ✅ **Manage Version and Build Number** (optional)
6. **Click "Upload"**
7. **Wait for validation** (2-5 minutes)
8. **Wait for upload** (5-15 minutes depending on connection)

**You'll receive an email when processing is complete** (usually 10-30 minutes after upload).

---

### Step 9: Submit for Review

**Back in App Store Connect:**

1. **Refresh the page** and go to your app
2. **Go to "App Store" tab**
3. **Under "Build"**, click **"+"** and select your uploaded build
   - Should see version 1.0 with a build number

4. **"What's New in This Version"** - paste from metadata:
   ```
   🎉 Welcome to Phone Addiction Mugshot!

   Phone addiction just got real - and visible.

   What's in v1.0:
   • Screen Time integration for accurate usage tracking
   • Hourly mugshot reminders after each hour on your phone  
   • Beautiful dark mode gallery to review your daily addiction
   • Share your mugshots for social accountability
   • Premium UI built with iOS 17+ in mind
   • Privacy-first: all photos stored locally

   Make your phone usage visible. Start your mugshot collection today.
   ```

5. **App Review Information**:
   - **Sign-in required**: No
   - **Contact Information**:
     - First Name: `[Your name]`
     - Last Name: `[Your last name]`
     - Email: `support@confluxsolutions.app`
   - **Notes** (for reviewers):
     ```
     Testing Notes:
     
     1. Grant Screen Time permission when prompted on first launch
     2. Grant Camera permission when capturing a mugshot
     3. Tap "Take Mugshot Now" on home screen to test camera
     4. View captured photos in the Gallery tab
     5. Test sharing from the detail view
     
     All photos are stored locally on device only.
     No account creation required.
     ```

6. **Export Compliance**:
   - Does your app use encryption? **No** (or **Yes** for standard HTTPS - select "No" for exemption)

7. **Content Rights**:
   - ✅ Check the box confirming you have rights to use app content

8. **Click "Submit for Review"**

---

## 📊 Step 10: Monitor Review Status

**Review Timeline:**
- **Initial Processing**: 10-30 minutes after upload
- **Waiting for Review**: Can be a few hours to 2 days
- **In Review**: Typically 24-48 hours
- **Total time**: Usually 1-3 days

**Check status at**: [App Store Connect](https://appstoreconnect.apple.com)

### Review Statuses Explained

| Status | Meaning | Action |
|--------|---------|--------|
| **Prepare for Submission** | Not yet submitted | Complete metadata and submit |
| **Waiting for Review** | In queue | No action needed |
| **In Review** | Being tested by Apple | No action needed |
| **Pending Developer Release** | ✅ **APPROVED!** | You control release timing |
| **Ready for Sale** | ✅ **LIVE!** | App is on App Store |
| **Rejected** | ❌ Needs changes | Read feedback, fix issues, resubmit |

---

## 🔧 Troubleshooting Common Issues

### Issue: "Invalid Bundle Identifier"
**Solution:**
- Ensure bundle ID in Xcode matches App Store Connect exactly
- Should be: `app.confluxsolutions.phoneaddictionmugshot`
- Check for typos, extra spaces, or incorrect capitalization

### Issue: "Missing Compliance"
**Solution:**
- If app uses HTTPS, answer Export Compliance questions
- For standard HTTPS networking, select "No" (it's exempt)

### Issue: "Missing Privacy Policy"
**Solution:**
- Upload `legal/PRIVACY_POLICY.md` to a public URL
- Enter the URL in App Store Connect > App Privacy > Privacy Policy URL

### Issue: "Screenshot Size Mismatch"
**Solution:**
- Use the exact screenshots from `assets/` folder
- They are already sized correctly at 1290x2796px

### Issue: "App Icon Missing"
**Solution:**
- Verify AppIcon.png is added to Assets.xcassets in Xcode
- The 1024x1024 slot must be filled

### Issue: "Signing Failed"
**Solution:**
- Ensure Team is selected in Signing & Capabilities
- Verify your Apple Developer account is active
- Try disabling and re-enabling "Automatically manage signing"

---

## 🎉 Post-Approval: Your App is Live!

### Release Your App

Once approved, you have two options:

1. **Manual Release**:
   - App Store Connect > Select your app > "Release This Version"
   - You control exact release time

2. **Automatic Release**:
   - Set in App Store Connect > Version Info
   - App goes live immediately after approval

### Share Your Launch

Once live, your App Store URL will be:
```
https://apps.apple.com/app/phone-addiction-mugshot/id[APP_ID]
```

Share it on:
- Social media
- Product Hunt
- Reddit (r/productivity, r/iosapps)
- Your website

---

## 📈 Post-Launch Monitoring

### Analytics to Track

Using the integrated analytics (PostHog/Mixpanel):
- **Downloads**: Track from App Store Connect Analytics
- **Active Users**: DAU/MAU from analytics
- **Mugshot Capture Rate**: How many users take photos
- **Retention**: D1, D7, D30 retention rates
- **Sharing**: % of users who share mugshots

### Gather Feedback

**Monitor these channels:**
- App Store reviews and ratings
- support@confluxsolutions.app email
- Social media mentions
- Analytics crash reports

### Respond to Reviews

- Respond to reviews within 48 hours
- Thank positive reviewers
- Address negative feedback constructively
- Update FAQ based on common questions

---

## 🔄 Releasing Updates

When you want to release version 1.1:

1. **Update version in Xcode**:
   - Increment version number (1.0 → 1.1)
   - Increment build number

2. **Make your code changes**

3. **Archive and upload** (repeat Steps 7-9)

4. **Create new version in App Store Connect**:
   - App Store Connect > "+" → "New Version"
   - Enter version number
   - Update "What's New" text

5. **Submit for review**

---

## 📞 Support Resources

### Conflux Solutions

- **Support**: support@confluxsolutions.app
- **Legal**: legal@confluxsolutions.app
- **Website**: https://confluxsolutions.app

### Apple Resources

- [App Store Connect](https://appstoreconnect.apple.com)
- [Apple Developer Portal](https://developer.apple.com/account)
- [App Store Review Guidelines](https://developer.apple.com/app-store/review/guidelines/)
- [App Privacy Details](https://developer.apple.com/app-store/app-privacy-details/)
- [TestFlight Beta Testing](https://developer.apple.com/testflight/)

---

## ✅ Quick Reference Checklist

Use this checklist to ensure you've completed everything:

- [ ] Apple Developer membership active
- [ ] Xcode project opens without errors
- [ ] Team selected in Signing & Capabilities
- [ ] App icon added to Assets.xcassets
- [ ] App created in App Store Connect
- [ ] All metadata uploaded (description, keywords, screenshots)
- [ ] Privacy policy URL configured
- [ ] Age rating set to 12+
- [ ] Pricing configured ($1.99 - $2.99)
- [ ] App archived successfully
- [ ] Build uploaded to App Store Connect
- [ ] Build selected in App Store tab
- [ ] "What's New" text added
- [ ] Review notes provided
- [ ] Submitted for review

---

**🎉 Congratulations! Your app is now submitted to the App Store!**

You'll receive an email from Apple when the review is complete. Typical approval time is 24-48 hours.

---

**Developed by Conflux Solutions LLC**  
*Making phone addiction visible, one mugshot at a time.* 📸

© 2026 Conflux Solutions LLC
