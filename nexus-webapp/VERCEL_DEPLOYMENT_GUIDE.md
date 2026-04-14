# Health Nexus - Vercel Deployment Guide

## Overview
This guide will help you deploy the Health Nexus web application to Vercel in a few simple steps.

## Prerequisites
- GitHub account with the Nexus-App repository
- Vercel account (free at https://vercel.com)
- Google Gemini API key (free at https://console.cloud.google.com/)

## Step 1: Prepare Your Repository
✅ Already Done! Your repository is pushed to GitHub with all necessary files:
- `nexus-webapp/` - Complete Next.js application
- `package.json` - All dependencies configured
- `next.config.ts` - Vercel-optimized configuration
- `.env.example` - Environment variables template
- `DEPLOYMENT.md` - Architecture documentation

## Step 2: Deploy to Vercel

### Option A: Using Vercel Dashboard (Recommended for Beginners)
1. Go to https://vercel.com/new
2. Click "Import Git Repository"
3. Sign in with GitHub and authorize Vercel
4. Select the **Shreyanshdixit6206/Nexus-App** repository
5. Click "Import"

### Option B: Using Vercel CLI
```bash
npm i -g vercel
cd nexus-webapp
vercel
```

## Step 3: Configure Environment Variables
1. Once imported, Vercel will show the project dashboard
2. Navigate to **Settings** → **Environment Variables**
3. Add the following variable:
   - **Key:** `GEMINI_API_KEY`
   - **Value:** Your actual Gemini API key from https://console.cloud.google.com/

## Step 4: Configure Database (Production)
For production deployment, you have two options:

### Option A: Vercel Postgres (Recommended)
1. In your Vercel Project Settings, go to **Storage**
2. Click **Create Database** → **Postgres**
3. Select a region close to your users
4. Vercel will auto-inject `POSTGRES_URL` environment variable
5. Update `src/lib/db.ts` to use @vercel/postgres:
```bash
npm install @vercel/postgres
```

Then modify `db.ts`:
```typescript
import { sql } from '@vercel/postgres';

export function getDb() {
  return sql;
}
```

### Option B: SQLite (Development/Testing Only)
- Current setup works for prototyping
- Data will be ephemeral (resets on deployments)
- Not recommended for production

## Step 5: Deploy
1. Once environment variables are set, Vercel will automatically deploy
2. You'll see a deployment URL: `https://your-project.vercel.app`
3. Visit the URL to see your live application!

## Step 6: Verify Deployment
- Navigate to your Vercel deployment URL
- Test the following features:
  - ✅ Home page loads
  - ✅ Aadhaar authentication works
  - ✅ Medicine search functions
  - ✅ AI prescription analysis (with GEMINI_API_KEY)
  - ✅ Cart functionality
  - ✅ Vault storage secure access

## Troubleshooting

### Issue: "Module not found: Can't resolve 'better-sqlite3'"
**Solution:** This is expected on Vercel's serverless environment. 
- Use Vercel Postgres instead (see Step 4, Option A)
- Or the application will use in-memory storage for that request

### Issue: "GEMINI_API_KEY is undefined"
**Solution:** 
1. Go to Vercel Project Settings → Environment Variables
2. Add `GEMINI_API_KEY` with your actual API key
3. Redeploy: Click "Deployment" → "Redeploy"

### Issue: "Deployment failed"
**Solution:**
1. Check Vercel Build Logs: Click deployment → "View Logs"
2. Ensure all dependencies are in `package.json`
3. Verify `next build` works locally: `npm run build`

## Environment Variables Reference

```
GEMINI_API_KEY=your_google_gemini_api_key_here
POSTGRES_URL=postgresql://... (optional, only if using Vercel Postgres)
```

## Performance Optimization Notes

1. **AI Caching:** The app caches Gemini responses to reduce API costs
2. **Token Limits:** Output limited to 600 tokens per response
3. **Model:** Using `gemini-2.0-flash` for optimal cost/performance

## Support & Documentation

- **Next.js Docs:** https://nextjs.org/docs
- **Vercel Docs:** https://vercel.com/docs
- **Gemini API:** https://console.cloud.google.com/
- **Vercel Postgres:** https://vercel.com/docs/storage/postgres

## After Deployment

### Enable Analytics
1. In Vercel Dashboard, go to **Analytics**
2. Click "Enable Web Analytics"
3. This shows real user monitoring data

### Configure Custom Domain
1. Go to **Settings** → **Domains**
2. Add your custom domain (e.g., health-nexus.com)
3. Update DNS records as instructed by Vercel

### Set Up CI/CD
- Vercel automatically redeploys when you push to GitHub
- No additional setup required!
- Each push to `main` branch triggers automatic deployment

## Rollback Previous Versions
If something breaks:
1. Go to **Deployments** tab
2. Click on any previous deployment
3. Click **Promote to Production**

---

**Your Health Nexus application is now production-ready!** 🚀

For questions or issues, check the deployment logs in Vercel or contact support.
