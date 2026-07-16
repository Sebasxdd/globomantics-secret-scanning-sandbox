# Understanding the Secret Scanning Workflows

This guide explains the GitHub Actions workflows in this repository, designed to demonstrate real-world secret scanning practices.

## 1. Secret Alert Handler Workflow

📄 **File**: `.github/workflows/secret-alert-handler.yml`

### What it Does

This workflow combines two essential security functions:
1. **TruffleHog Scanning**: Performs deep secret scanning on repository content
2. **Alert Management**: Creates trackable issues for secret scanning alerts

### Key Components

#### TruffleHog Job
```yaml
trufflehog-scan:
  steps:
    - name: TruffleHog OSS
      uses: trufflesecurity/trufflehog@main
      with:
        extra_args: --only-verified
```
- Scans entire repository history
- Only reports verified secrets
- Runs on pushes and pull requests

#### Alert Issue Creation
```yaml
create-alert-issue:
  if: github.event_name == 'repository_dispatch' && github.event.action == 'secret_scanning_alert'
```
- Creates detailed GitHub issues for alerts
- Includes remediation steps
- Automatically assigns to repository owner

### Learning Points

1. **Event Triggers**:
   - Push events
   - Pull requests
   - Manual workflow dispatch
   - Repository dispatch for alerts

2. **Permissions**:
   ```yaml
   permissions:
     issues: write
     security-events: read
   ```
   - Minimal required permissions
   - Security best practice

3. **Alert Handling**:
   - Fetches alert details via GitHub API
   - Creates standardized issues
   - Includes best practices

## 2. Custom Pattern Testing

📄 **File**: `.github/workflows/test-globo-secret-pattern.yml`

Tests Globomantics-specific token patterns:
```regex
gbot-(dev|prod)-[A-Fa-f0-9]{16}
```

### Features
- Pattern validation
- Sample token testing
- Automated verification

## Best Practices Demonstrated

1. **Immediate Detection**:
   - TruffleHog scanning on every push
   - Custom pattern validation
   - Push protection

2. **Automated Response**:
   - Issue creation
   - Clear remediation steps
   - Assigned ownership

3. **Documentation**:
   - Linked resources
   - Step-by-step guides
   - Best practices

## Setting Up in Your Environment

1. **Enable Required Features**:
   ```bash
   gh api -X PATCH repos/YOUR-ORG/REPO \
     -f security_and_analysis.secret_scanning=enabled \
     -f security_and_analysis.secret_scanning_push_protection=enabled
   ```

2. **Configure Webhook** (for alert handling):
   - Add repository dispatch webhook
   - Set secret for authentication
   - Point to your repository

3. **Customize Patterns**:
   - Edit `globomantics-robot-auth-token-formats.md`
   - Update test cases
   - Run validation workflow

## Common Teaching Scenarios

1. **Demo Secret Detection**:
   ```bash
   # DON'T actually commit this!
   echo "gbot-dev-1234567890abcdef" > test.txt
   git add test.txt
   git commit -m "test"  # Should be blocked
   ```

2. **Show Alert Handling**:
   - Trigger an alert
   - Watch issue creation
   - Review remediation steps

3. **Pattern Customization**:
   - Modify token format
   - Run tests
   - Review results

## Additional Resources

- [GitHub Secret Scanning Documentation](https://docs.github.com/code-security/secret-scanning)
- [TruffleHog Documentation](https://github.com/trufflesecurity/trufflehog)
- [GitHub Actions Documentation](https://docs.github.com/actions)

---

> 📝 **Note for Pluralsight Students**: This repository is designed as a learning tool. Feel free to fork it and experiment with the workflows in your own environment. 