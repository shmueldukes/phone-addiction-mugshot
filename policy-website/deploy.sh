#!/bin/bash

# Quick Deploy Script for GitHub Pages
# This script helps you deploy your policy website to GitHub Pages

echo "🚀 Phone Addiction Mugshot - Policy Website Deployment"
echo "======================================================="
echo ""

# Check if git is initialized
if [ ! -d ".git" ]; then
    echo "📦 Initializing git repository..."
    git init
    git branch -M main
fi

# Add all files
echo "📝 Adding files to git..."
git add .

# Commit
echo "💾 Creating commit..."
git commit -m "Update policy website - $(date +%Y-%m-%d)"

# Ask for GitHub repository URL
echo ""
echo "📍 Next steps:"
echo "1. Create a new repository on GitHub (if you haven't already)"
echo "2. Copy the repository URL (e.g., https://github.com/username/phone-addiction-policies.git)"
echo ""
read -p "Enter your GitHub repository URL: " REPO_URL

if [ -z "$REPO_URL" ]; then
    echo "❌ No repository URL provided. Exiting."
    exit 1
fi

# Check if remote exists
if git remote | grep -q "origin"; then
    echo "🔄 Updating remote origin..."
    git remote set-url origin "$REPO_URL"
else
    echo "➕ Adding remote origin..."
    git remote add origin "$REPO_URL"
fi

# Push to GitHub
echo "📤 Pushing to GitHub..."
git push -u origin main

echo ""
echo "✅ Deployment complete!"
echo ""
echo "📋 Final steps:"
echo "1. Go to your GitHub repository"
echo "2. Click on Settings → Pages"
echo "3. Under 'Source', select 'main' branch"
echo "4. Click 'Save'"
echo "5. Your site will be live at: https://YOUR_USERNAME.github.io/REPO_NAME/"
echo ""
echo "🔗 Use this URL in App Store Connect for your Privacy Policy!"
echo ""
