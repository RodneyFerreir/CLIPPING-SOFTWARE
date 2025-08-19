# ClipSync AI

Automatically generate viral short-form clips (TikTok, Reels, Shorts) from URL submissions with AI-powered editing and optimization.

## 🚀 Project Overview

ClipSync AI is a SaaS platform that transforms any video URL into engaging short-form content. The system uses AI to:

- **Transcribe** videos with Faster-Whisper
- **Detect highlights** with BART summarization
- **Generate clips** with FFmpeg processing
- **Apply viral styles** with automated effects
- **Auto-post** to multiple platforms

## 🏗️ Architecture

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Next.js Web   │    │  Express API    │    │  Python ML      │
│   (Frontend)    │◄──►│   (Backend)     │◄──►│   Engine        │
└─────────────────┘    └─────────────────┘    └─────────────────┘
         │                       │                       │
         ▼                       ▼                       ▼
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Supabase      │    │   Supabase      │    │   Supabase      │
│   (Auth)        │    │   (Database)    │    │   (Storage)     │
└─────────────────┘    └─────────────────┘    └─────────────────┘
```

## 🛠️ Tech Stack

- **Frontend**: Next.js 14 (App Router), TailwindCSS, shadcn/ui
- **Backend**: Node.js (Express), TypeScript
- **ML Engine**: Python (FastAPI), Faster-Whisper, BART, FFmpeg
- **Database**: Supabase (PostgreSQL with RLS)
- **Auth**: Supabase Auth (JWT)
- **Storage**: Supabase Storage
- **Payments**: Stripe (subscriptions + credits)
- **Deploy**: Vercel (web), Railway/Render (API + ML)

## 📁 Project Structure

```
clipsync-ai/
├── apps/
│   ├── web/                 # Next.js frontend
│   ├── api/                 # Express backend
│   └── ml-engine/           # Python ML service
├── packages/
│   ├── ui/                  # Shared UI components
│   └── utils/               # Shared utilities & types
├── supabase/                # Database schema & migrations
├── turbo.json               # Turborepo configuration
└── package.json             # Root package.json
```

## 🚀 Quick Start

### Prerequisites

- Node.js 18+ 
- Python 3.11+
- FFmpeg installed
- Supabase account

### 1. Clone & Install

```bash
git clone <repository-url>
cd clipsync-ai
npm install
```

### 2. Environment Setup

```bash
cp env.example .env
# Edit .env with your configuration
```

### 3. Supabase Setup

1. Create a new Supabase project
2. Run the schema: `supabase/schema.sql`
3. Get your project URL and keys
4. Update `.env` with Supabase credentials

### 4. Start Development

```bash
# Start all services
npm run dev

# Or start individually:
npm run dev --workspace=@clipsync/web      # Frontend (port 3000)
npm run dev --workspace=@clipsync/api      # Backend (port 3001)
npm run dev --workspace=@clipsync/ml-engine # ML Engine (port 8000)
```

## 🔧 Development

### Frontend (Next.js)

```bash
cd apps/web
npm run dev
```

- **Port**: 3000
- **Features**: Landing page, auth, dashboard
- **Tech**: Next.js 14, TailwindCSS, shadcn/ui

### Backend (Express)

```bash
cd apps/api
npm run dev
```

- **Port**: 3001
- **Features**: REST API, auth routes, video management
- **Tech**: Express, TypeScript, Supabase

### ML Engine (Python)

```bash
cd apps/ml-engine
pip install -r requirements.txt
python -m uvicorn src.main:app --reload
```

- **Port**: 8000
- **Features**: Transcription, highlight detection, video rendering
- **Tech**: FastAPI, Faster-Whisper, BART, FFmpeg

## 📊 Database Schema

### Core Tables

- **users**: User accounts and plans
- **videos**: Source videos and processing status
- **clips**: Generated clips with metadata
- **subscriptions**: Stripe subscription data
- **accounts**: Social media platform connections
- **credits**: Usage tracking and limits

### Security

- Row Level Security (RLS) enabled on all tables
- Users can only access their own data
- JWT-based authentication via Supabase Auth

## 🧪 Testing

```bash
# Run all tests
npm run test

# Test specific packages
npm run test --workspace=@clipsync/web
npm run test --workspace=@clipsync/api
npm run test --workspace=@clipsync/ml-engine
```

## 🚀 Deployment

### Frontend (Vercel)

```bash
cd apps/web
vercel --prod
```

### Backend (Railway/Render)

```bash
cd apps/api
# Deploy to Railway or Render
```

### ML Engine (Railway/Render)

```bash
cd apps/ml-engine
# Deploy to Railway or Render with Docker
```

## 📈 Phase Roadmap

### ✅ Phase 1: Monorepo & Auth
- [x] Turborepo setup
- [x] Supabase integration
- [x] Auth system
- [x] Basic dashboard

### 🔄 Phase 2: URL Ingestion
- [ ] Video URL submission
- [ ] Metadata extraction
- [ ] Processing queue

### ⏳ Phase 3: AI Clipping Core
- [ ] Faster-Whisper transcription
- [ ] BART highlight detection
- [ ] FFmpeg clip generation

### ⏳ Phase 4: Viral Styles
- [ ] Caption generation
- [ ] Effect application
- [ ] Style presets

### ⏳ Phase 5: Dashboard & Management
- [ ] Clip management UI
- [ ] Performance tracking
- [ ] Analytics dashboard

### ⏳ Phase 6: Monetization
- [ ] Stripe integration
- [ ] Credit system
- [ ] Plan gating

### ⏳ Phase 7: Social Integration
- [ ] Platform OAuth
- [ ] Manual posting
- [ ] Account management

### ⏳ Phase 8: Auto-Posting
- [ ] Scheduling system
- [ ] Optimal timing
- [ ] Retry logic

### ⏳ Phase 9: ML Feedback Loop
- [ ] Performance tracking
- [ ] Auto-improvement
- [ ] A/B testing

### ⏳ Phase 10: YouTube Channel Watching
- [ ] Channel monitoring
- [ ] Auto-clipping
- [ ] Auto-posting

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests
5. Submit a pull request

## 📄 License

This project is proprietary software. All rights reserved.

## 🆘 Support

For support and questions:
- Create an issue in the repository
- Contact the development team
- Check the documentation

## 🔒 Security

- All API endpoints are rate-limited
- Input validation with Zod schemas
- Row-level security in database
- JWT token authentication
- CORS protection enabled

---

**Built with ❤️ by the ClipSync AI Team**

