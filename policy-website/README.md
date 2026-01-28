# Phone Addiction Mugshot - Policy Website

Professional legal policy website for the Phone Addiction Mugshot iOS app.

## 🌐 Live URLs

Once deployed to GitHub Pages, your policies will be accessible at:
- **Privacy Policy**: `https://[your-username].github.io/[repo-name]/privacy-policy.html`
- **Terms of Service**: `https://[your-username].github.io/[repo-name]/terms-of-service.html`
- **EULA**: `https://[your-username].github.io/[repo-name]/eula.html`

## 📦 What's Included

- **index.html** - Landing page with links to all policies
- **privacy-policy.html** - Full Privacy Policy with 2026 AI disclosure
- **terms-of-service.html** - Complete Terms of Service
- **eula.html** - End User License Agreement
- **styles.css** - Modern, dark mode styling

## 🚀 Hosting Options

### Option 1: GitHub Pages (Recommended - FREE)

1. **Create a new GitHub repository**
   ```bash
   cd "/Users/shmueldukes/Documents/Mobile App Dev Agentic Software Factory/PhoneAddictionMugshot/policy-website"
   git init
   git add .
   git commit -m "Initial commit: Policy website"
   ```

2. **Push to GitHub**
   ```bash
   # Create a new repository on GitHub first, then:
   git remote add origin https://github.com/YOUR_USERNAME/phone-addiction-policies.git
   git branch -M main
   git push -u origin main
   ```

3. **Enable GitHub Pages**
   - Go to your repository on GitHub
   - Click **Settings** → **Pages**
   - Under "Source", select **main** branch
   - Click **Save**
   - Your site will be live at: `https://YOUR_USERNAME.github.io/phone-addiction-policies/`

### Option 2: Netlify (Also FREE)

1. **Install Netlify CLI** (optional)
   ```bash
   npm install -g netlify-cli
   ```

2. **Deploy via Drag & Drop**
   - Go to [Netlify Drop](https://app.netlify.com/drop)
   - Drag the entire `policy-website` folder
   - Get instant URL like: `https://your-site-name.netlify.app`

3. **Or deploy via CLI**
   ```bash
   cd "/Users/shmueldukes/Documents/Mobile App Dev Agentic Software Factory/PhoneAddictionMugshot/policy-website"
   netlify deploy --prod
   ```

### Option 3: Vercel (Also FREE)

1. **Install Vercel CLI**
   ```bash
   npm install -g vercel
   ```

2. **Deploy**
   ```bash
   cd "/Users/shmueldukes/Documents/Mobile App Dev Agentic Software Factory/PhoneAddictionMugshot/policy-website"
   vercel --prod
   ```

## 📱 Use in App Store Connect

Once deployed, use these URLs in App Store Connect:

1. **Privacy Policy URL**: `https://your-domain.com/privacy-policy.html`
2. **Support URL**: Use the main landing page `https://your-domain.com/`
3. **EULA URL**: `https://your-domain.com/eula.html`

## 🎨 Customization

### Update Colors

Edit `styles.css` and modify the CSS variables:

```css
:root {
    --accent-purple: #8b5cf6;
    --accent-pink: #ec4899;
    --bg-dark: #0a0a1a;
}
```

### Update Contact Info

All email addresses are already set to `@confluxsolutions.app`:
- `support@confluxsolutions.app`
- `privacy@confluxsolutions.app`
- `legal@confluxsolutions.app`

## 🧪 Local Testing

Open the files directly in your browser:

```bash
cd "/Users/shmueldukes/Documents/Mobile App Dev Agentic Software Factory/PhoneAddictionMugshot/policy-website"
open index.html
```

Or use a simple HTTP server:

```bash
# Python 3
python3 -m http.server 8000

# Then visit: http://localhost:8000
```

## ✅ Features

- ✨ **Modern Design**: Dark mode with gradient accents
- 📱 **Fully Responsive**: Works on all devices
- 🎯 **SEO Optimized**: Proper meta tags and semantic HTML
- 🖨️ **Print Friendly**: Special print styles for PDF generation
- ⚡ **Fast Loading**: No JavaScript, pure HTML/CSS
- 🎨 **Smooth Animations**: Hover effects and transitions

## 📄 File Structure

```
policy-website/
├── index.html              # Landing page
├── privacy-policy.html     # Privacy Policy
├── terms-of-service.html   # Terms of Service
├── eula.html              # EULA
├── styles.css             # Shared stylesheet
└── README.md              # This file
```

## 🔒 Compliance

All policies include:
- ✅ 2026 AI disclosure requirements
- ✅ GDPR compliance (EU rights)
- ✅ CCPA compliance (California rights)
- ✅ COPPA compliance (age restrictions)
- ✅ Proper effective dates

## 📞 Support

Conflux Solutions LLC
- Website: https://confluxsolutions.app
- Email: support@confluxsolutions.app

---

© 2026 Conflux Solutions LLC. All rights reserved.
