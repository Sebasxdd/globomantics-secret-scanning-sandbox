#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${YELLOW}🔬 Globomantics Secret Scanning Demo${NC}"
echo -e "${YELLOW}=================================${NC}\n"

# Create a new branch for testing
BRANCH_NAME="demo/secret-scanning-test-$(date +%s)"
echo -e "🌿 Creating test branch: ${GREEN}$BRANCH_NAME${NC}"
git checkout -b "$BRANCH_NAME"

# Create test files with "secrets"
echo -e "\n📝 Creating test files with example tokens..."

# Test file 1: Globomantics Robot Token
echo -e "${YELLOW}Creating development token file...${NC}"
echo "API_KEY=gbot-dev-1234567890abcdef" > globo-dev-config.txt
echo "Created globo-dev-config.txt"

# Test file 2: Production Token
echo -e "${YELLOW}Creating production token file...${NC}"
echo "PROD_KEY=gbot-prod-fedcba0987654321" > globo-prod-config.txt
echo "Created globo-prod-config.txt"

# Test file 3: Multiple tokens
echo -e "${YELLOW}Creating mixed configuration file...${NC}"
cat << EOF > globo-config.json
{
  "development": {
    "auth": "gbot-dev-aaaaaaaabbbbcccc",
    "backup": "gbot-dev-ddddeeeeffffgggg"
  },
  "production": {
    "auth": "gbot-prod-1111222233334444",
    "backup": "gbot-prod-5555666677778888"
  }
}
EOF
echo "Created globo-config.json"

# Stage the files
echo -e "\n📦 Staging test files..."
git add globo-*-config.txt globo-config.json

# Attempt to commit
echo -e "\n🚀 Attempting to commit (this should trigger alerts)..."
git commit -m "test: demonstrate secret scanning with example tokens"

# Push to remote
echo -e "\n⬆️ Pushing to remote..."
git push origin "$BRANCH_NAME"

echo -e "\n${GREEN}✅ Demo complete!${NC}"
echo -e "${YELLOW}Now check:${NC}"
echo "1. The Security tab for new alerts"
echo "2. The Issues tab for automatically created issues"
echo "3. The Actions tab to see the workflow runs"

# Cleanup instructions
echo -e "\n${YELLOW}To clean up after testing:${NC}"
echo "git checkout main"
echo "git branch -D $BRANCH_NAME"
echo "git push origin --delete $BRANCH_NAME" 