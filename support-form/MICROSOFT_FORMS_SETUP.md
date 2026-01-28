# Microsoft Forms Setup for Support Requests

## Overview

Since you have Office 365, you can use **Microsoft Forms** to handle support submissions. This is included with your O365 license and integrates seamlessly with your helpdesk@confluxsolutions.com email.

## Setup Steps

### 1. Create the Form

1. Go to [https://forms.office.com](https://forms.office.com)
2. Sign in with your Conflux Solutions O365 account
3. Click **+ New Form**
4. Name it: "Phone Addiction Mugshot - Support"

### 2. Add Form Questions

Add the following questions in order:

**Question 1: Name**
- Type: Text
- Required: Yes
- Subtitle: "Your full name"

**Question 2: Email**
- Type: Text
- Required: Yes
- Subtitle: "We'll use this to respond to you"

**Question 3: Request Type**
- Type: Choice (Dropdown)
- Required: Yes
- Options:
  - Bug Report
  - Feature Request
  - Technical Support
  - General Feedback
  - Other

**Question 4: Subject**
- Type: Text
- Required: Yes
- Subtitle: "Brief description of your issue"

**Question 5: Message**
- Type: Long Answer
- Required: Yes
- Subtitle: "Please provide as much detail as possible"

### 3. Customize the Theme

1. Click **Theme** at the top
2. Choose a color scheme (recommend purple/pink to match app)
3. Upload a header image (optional - could use app logo)
4. Click **Preview** to see how it looks

### 4. Configure Settings

1. Click the **⋯** (more options) button → **Settings**

2. Under **Who can fill out this form**:
   - Select **Anyone can respond** (allows users without O365 accounts)

3. Under **Response options**:
   - ✅ Check **Record name**
   - ✅ Check **One response per person** (optional)
   - ✅ Check **Accept responses**

4. Under **Thank you message**:
   ```
   Thank you for contacting us! 
   We'll respond within 24-48 hours to the email you provided.
   
   - Conflux Solutions Team
   ```

### 5. Set Up Email Notifications

**Option A: Get Email for Each Response**

1. In your form, click **⋯** → **Settings**
2. Scroll to **Get email notification of each response**
3. Toggle ON
4. This will send to your logged-in O365 account

**Option B: Use Power Automate (More Control)**

1. Click **⋯** → **Integrate** → **Create a flow**
2. Select template: **"Send an email when a new response is submitted"**
3. Configure:
   - Form ID: (automatically selected)
   - To: `helpdesk@confluxsolutions.com`
   - Subject: `New Support Request - Phone Addiction Mugshot`
   - Body: Include response details (use dynamic content)
4. Click **Create flow**

### 6. Get the Form URL

1. Click **Share** button at top right
2. Under **Send and collect responses**:
   - Copy the short URL (e.g., `https://forms.office.com/r/abc123xyz`)
3. **This is your support form URL!**

### 7. Update the iOS App

Update [SettingsView.swift](file:///Users/shmueldukes/Documents/Mobile%20App%20Dev%20Agentic%20Software%20Factory/PhoneAddictionMugshot/ios/PhoneAddictionMugshot/Views/SettingsView.swift#L167):

```swift
func openSupportForm() {
    // Open Microsoft Forms support form
    if let url = URL(string: "https://forms.office.com/r/YOUR_FORM_ID") {
        UIApplication.shared.open(url)
    }
}
```

Replace `YOUR_FORM_ID` with the ID from your form URL.

## Testing

1. Open the form URL in a browser
2. Fill out all fields with test data
3. Submit the form
4. Check `helpdesk@confluxsolutions.com` for the notification email
5. Test from iOS app:
   - Settings → Contact Support → Submit Support Form
   - Should open Microsoft Forms in Safari

## Viewing Responses

### In Microsoft Forms Dashboard

1. Go to [forms.office.com](https://forms.office.com)
2. Click on your support form
3. Click **Responses** tab
4. View individual responses or export to Excel

### Export to Excel

1. In Responses tab, click **Open in Excel**
2. Opens Excel Online with all responses
3. Download as `.xlsx` if needed for further analysis

## Advanced: Power Automate Integration

You can create more sophisticated workflows with Power Automate:

### Auto-Reply to User

1. Go to [Power Automate](https://make.powerautomate.com)
2. Create new flow: **When a new response is submitted**
3. Add action: **Send an email (V2)**
   - To: `Response submitter email`
   - Subject: `We received your support request`
   - Body: Custom thank you message

### Create Ticket in Microsoft Lists/Planner

1. Add action: **Create item** (Microsoft Lists)
2. Map form fields to list columns
3. Track support requests in SharePoint

### Notify Teams Channel

1. Add action: **Post message in a chat or channel**
2. Select your support team's channel
3. Include response details

## Benefits of Microsoft Forms

✅ **Included with O365** - No additional costs  
✅ **Professional Integration** - Works with Outlook, Teams, SharePoint  
✅ **Automatic Email** - Notifications to helpdesk@confluxsolutions.com  
✅ **Data Export** - Export to Excel for analysis  
✅ **Mobile Responsive** - Works great on all devices  
✅ **Secure** - Enterprise-grade Microsoft security  
✅ **Power Automate** - Advanced automation possibilities  
✅ **No Coding Required** - Point-and-click setup  

## Comparison: Microsoft Forms vs Formspree

| Feature | Microsoft Forms | Formspree |
|---------|----------------|-----------|
| **Cost** | Free (included with O365) | Free tier: 50/month |
| **Email Notifications** | ✅ Built-in | ✅ Built-in |
| **Data Storage** | ✅ Microsoft cloud | ❌ Formspree servers |
| **Excel Export** | ✅ Yes | ❌ CSV only (paid) |
| **Power Automate** | ✅ Advanced workflows | ❌ No |
| **Custom Branding** | ⚠️ Limited | ✅ Full control |
| **Setup Time** | ~5 minutes | ~2 minutes |

## Recommended Solution

**Use Microsoft Forms!** 

Since you already have O365:
1. No additional costs
2. Better integration with your business email
3. More powerful automation options
4. Enterprise-grade security and compliance
5. Professional appearance

The only downside is you can't customize the form's visual design as much as the custom HTML version, but Microsoft Forms looks professional and matches Microsoft's modern design language.
