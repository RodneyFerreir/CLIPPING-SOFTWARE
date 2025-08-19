# ClipSync Endpoint Testing Guide

This guide explains how to test all the endpoints in your ClipSync system to ensure everything is working correctly.

## 🚀 Quick Start

### Option 1: Run All Services Test (Recommended)
```bash
# Windows (Command Prompt)
test-all-services.bat

# Windows (PowerShell)
.\test-all-services.ps1

# Linux/Mac
node test-all-services.js
```

### Option 2: Test Individual Services
```bash
# Test API only
cd apps/api
npm test

# Test Download Service only
cd apps/download-service
npm run test
```

## 📋 Prerequisites

Before running tests, ensure you have:

1. **Node.js** (v16 or higher) installed
2. **npm** installed
3. **Both services running**:
   - API Service on port 3002
   - Download Service on port 15000

## 🔧 Starting Services

### Start API Service
```bash
cd apps/api
npm install
npm run dev
```

### Start Download Service
```bash
cd apps/download-service
npm install
npm run dev
```

### Start Both Services (from root)
```bash
# Windows
start-services.bat

# Linux/Mac
./start-services.sh
```

## 🧪 Test Coverage

### API Service Tests (Port 3002)
- ✅ **Health Check** - `/health`
- ✅ **User Registration** - `POST /api/auth/register`
- ✅ **User Login** - `POST /api/auth/login`
- ✅ **Get Current User** - `GET /api/auth/me`
- ✅ **Video Ingestion** - `POST /api/videos/ingest`
- ✅ **Get User Videos** - `GET /api/videos`
- ✅ **Get Video by ID** - `GET /api/videos/:id`
- ✅ **Get Video Status** - `GET /api/videos/:id/status`
- ✅ **Update Video Status** - `PATCH /api/videos/:id/status`
- ✅ **Token Refresh** - `POST /api/auth/refresh`
- ✅ **User Logout** - `POST /api/auth/logout`
- ✅ **Error Handling** - 401, 404, validation errors
- ✅ **Rate Limiting** - 100 requests per 15 minutes
- ✅ **Performance** - Response time < 1 second

### Download Service Tests (Port 15000)
- ✅ **Health Check** - `/health`
- ✅ **Service Status** - `GET /status`
- ✅ **Get Available Clips** - `GET /clips`
- ✅ **Download Queue Status** - `GET /download/queue`
- ✅ **Add Download Job** - `POST /download`
- ✅ **Generate Clips** - `POST /generate-clips`
- ✅ **Error Handling** - 404 for invalid endpoints
- ✅ **Performance** - Response time < 1 second

### Integration Tests
- ✅ **Concurrent Requests** - 20 simultaneous requests
- ✅ **Cross-Service Communication** - API triggers ML processing
- ✅ **Authentication Flow** - Complete user lifecycle
- ✅ **Error Scenarios** - Invalid data, unauthorized access

## 📊 Test Results

Tests generate detailed results including:

- **Pass/Fail Status** for each endpoint
- **Response Times** for performance validation
- **Error Details** for failed tests
- **Success Rate** percentage
- **Total Execution Time**

Results are displayed in the console and can be saved to files for analysis.

## 🐛 Troubleshooting

### Common Issues

#### 1. Connection Refused
```
❌ API server is not running or not accessible
```
**Solution**: Start the API service with `npm run dev`

#### 2. Missing Dependencies
```
❌ Failed to install dependencies
```
**Solution**: Run `npm install` in the service directory

#### 3. Port Conflicts
```
❌ EADDRINUSE: address already in use
```
**Solution**: Check if another service is using the port, or change the port in config

#### 4. Authentication Errors
```
❌ Unauthorized Access to API
```
**Solution**: Ensure the user registration and login flow works correctly

### Debug Mode

For detailed debugging, you can modify the test scripts:

```javascript
// In test files, change TEST_TIMEOUT to a higher value
const TEST_TIMEOUT = 60000; // 60 seconds

// Add more detailed logging
console.log('Request details:', { method, url, data, headers });
```

## 🔍 Manual Testing

### Test Individual Endpoints

#### Health Check
```bash
curl http://localhost:3002/health
curl http://localhost:15000/health
```

#### User Registration
```bash
curl -X POST http://localhost:3002/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{"email":"test@example.com","password":"TestPass123!"}'
```

#### Video Ingestion
```bash
curl -X POST http://localhost:3002/api/videos/ingest \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"url":"https://www.youtube.com/watch?v=dQw4w9WgXcQ"}'
```

#### Generate Clips
```bash
curl -X POST http://localhost:15000/generate-clips \
  -H "Content-Type: application/json" \
  -d '{"youtubeUrl":"https://www.youtube.com/watch?v=dQw4w9WgXcQ","maxClips":2}'
```

## 📈 Performance Benchmarks

### Expected Response Times
- **Health Checks**: < 100ms
- **Authentication**: < 500ms
- **Video Operations**: < 2000ms
- **Clip Generation**: < 30000ms (30 seconds)

### Load Testing
The test suite includes concurrent request testing (10-20 simultaneous requests) to ensure your services can handle multiple users.

## 🚨 Security Testing

### Authentication
- ✅ Validates JWT tokens
- ✅ Rejects expired tokens
- ✅ Proper 401 responses for unauthorized access

### Input Validation
- ✅ Rejects invalid email formats
- ✅ Rejects weak passwords
- ✅ Sanitizes video URLs
- ✅ Prevents SQL injection

### Rate Limiting
- ✅ Limits to 100 requests per 15 minutes
- ✅ Returns 429 status for exceeded limits

## 📝 Customizing Tests

### Add New Endpoints
1. Create a new test function in the appropriate test file
2. Add it to the `runAllTests()` function
3. Update the test count and summary

### Modify Test Data
```javascript
// Change test video URL
const testVideoUrl = 'https://www.youtube.com/watch?v=YOUR_VIDEO_ID';

// Modify test user credentials
let testUser = {
  email: `custom-test-${Date.now()}@example.com`,
  password: 'CustomPassword123!'
};
```

### Environment-Specific Testing
```javascript
// Test against different environments
const BASE_URL = process.env.TEST_API_URL || 'http://localhost:3002';
const DOWNLOAD_URL = process.env.TEST_DOWNLOAD_URL || 'http://localhost:15000';
```

## 🎯 Continuous Integration

### GitHub Actions Example
```yaml
name: Test Endpoints
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: actions/setup-node@v2
        with:
          node-version: '18'
      - run: npm install
      - run: node test-all-services.js
```

### Pre-commit Hook
```bash
#!/bin/sh
# .git/hooks/pre-commit
echo "Running endpoint tests..."
node test-all-services.js
if [ $? -ne 0 ]; then
  echo "Tests failed. Commit aborted."
  exit 1
fi
```

## 📚 Additional Resources

- **API Documentation**: Check the route files in `apps/api/src/routes/`
- **Download Service**: See `apps/download-service/src/index.ts`
- **Error Logs**: Check console output and service logs
- **Database**: Ensure Supabase is properly configured

## 🆘 Getting Help

If you encounter issues:

1. **Check the logs** - Both services provide detailed logging
2. **Verify configuration** - Check environment variables and config files
3. **Test manually** - Use curl or Postman to test individual endpoints
4. **Check dependencies** - Ensure all packages are properly installed
5. **Review error messages** - The test suite provides detailed error information

---

**Happy Testing! 🎉**

Your ClipSync system should now be thoroughly tested and ready for production use.
