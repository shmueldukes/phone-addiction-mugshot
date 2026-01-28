# Support Form Setup Guide

This directory contains a web-based support form for the Phone Addiction Mugshot app. Users can submit feedback, bug reports, and support requests through this form, which will be sent to **helpdesk@confluxsolutions.com**.

## Features

✅ Modern, responsive design matching the app's aesthetic  
✅ Multiple request types (Bug Report, Feature Request, Support, Feedback)  
✅ Automatic email notifications  
✅ Mobile-friendly interface  
✅ No backend setup required (uses Formspree)  

## Setup Instructions

### Option 1: Using Formspree (Recommended - Free & Easy)

1. **Create a Formspree Account**
   - Go to [https://formspree.io](https://formspree.io)
   - Sign up for a free account (supports 50 submissions/month on free tier)

2. **Create a New Form**
   - Click "New Form"
   - Set the email to: `helpdesk@confluxsolutions.com`
   - Give it a name like "Phone Addiction Mugshot Support"

3. **Get Your Form ID**
   - Copy the form endpoint URL (looks like: `https://formspree.io/f/xyzabc123`)
   - The form ID is the part after `/f/` (e.g., `xyzabc123`)

4. **Update the HTML File**
   - Open `index.html`
   - Find line 223: `<form id="supportForm" action="https://formspree.io/f/YOUR_FORM_ID" method="POST">`
   - Replace `YOUR_FORM_ID` with your actual form ID

5. **Deploy the Form**
   - See deployment options below

### Option 2: Using Netlify Forms

1. **Update the HTML**
   - Replace the `<form>` tag with:
   ```html
   <form id="supportForm" name="support" method="POST" data-netlify="true" netlify-honeypot="bot-field">
   ```
   - Add a hidden field after the opening form tag:
   ```html
   <input type="hidden" name="form-name" value="support" />
   ```

2. **Deploy to Netlify** (see deployment section)

3. **Configure Email Notifications**
   - In Netlify dashboard, go to Forms > Form notifications
   - Add an email notification to `helpdesk@confluxsolutions.com`

## Deployment Options

### Option A: GitHub Pages (Free)

1. Create a new repository or use existing one
2. Push the `support-form` folder contents
3. Enable GitHub Pages in repository settings
4. Your form will be at: `https://yourusername.github.io/repo-name/`

### Option B: Netlify (Free)

1. Install Netlify CLI: `npm install -g netlify-cli`
2. Navigate to the support-form directory
3. Run: `netlify deploy`
4. Follow the prompts to deploy
5. For production: `netlify deploy --prod`

### Option C: Vercel (Free)

1. Install Vercel CLI: `npm install -g vercel`
2. Navigate to the support-form directory
3. Run: `vercel`
4. Follow the prompts

## Updating the App

After deploying the form, update the URL in the iOS app:

1. Open `SettingsView.swift`
2. Find the `openSupportForm()` function
3. Update the URL to your deployed form URL:
   ```swift
   if let url = URL(string: "https://your-deployed-url.com") {
       UIApplication.shared.open(url)
   }
   ```

## Testing

1. Deploy the form using one of the methods above
2. Submit a test request through the web form
3. Check that the email arrives at `helpdesk@confluxsolutions.com`
4. Test from the iOS app by tapping Contact Support > Submit Support Form

## Email Functionality

The app also provides a **native email option** that:
- Opens the user's default mail app
- Pre-fills the recipient: `helpdesk@confluxsolutions.com`
- Includes a pre-populated subject line
- Adds device/app information automatically

This gives users flexibility to choose their preferred contact method.

## Customization

You can customize the form by editing `index.html`:

- **Colors**: Update the gradient colors in the `<style>` section
- **Fields**: Add/remove form fields as needed
- **Request Types**: Modify the `<select>` options for different categories
- **Branding**: Update the icon, title, and footer text

## Support

If you need help setting up the form:
- Check [Formspree documentation](https://help.formspree.io/)
- Check [Netlify Forms documentation](https://docs.netlify.com/forms/setup/)
- Email: helpdesk@confluxsolutions.com
