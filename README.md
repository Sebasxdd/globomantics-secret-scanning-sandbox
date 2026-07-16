# Globomantics Secret Scanning Sandbox 🤖

> DevSecOps demonstration of GitHub Advanced Security secret scanning with custom patterns and automated response workflows.

<!-- TESTING: intentional high-entropy secret to trigger secret scanning alert -->
SLACK_WEBHOOK_TEST=https://hooks.slack.com/services/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

## Secret Scanning Flow

```mermaid
flowchart TD
    subgraph DevMachine["Developer's Machine"]
        A[Developer writes code] -->|Stages changes| B[Pre-commit Hook]
        B -->|Runs| C[TruffleHog Local Scan]
        C -->|Clean| D[Commit Allowed]
        C -->|Found Secrets| E[Commit Blocked]
        E -->|Fix| A
    end

    subgraph GitHub["GitHub Repository"]
        D -->|git push| F[Push Protection]
        F -->|Scan| G[GitHub Secret Scanning]
        
        subgraph SecretScanning["Secret Scanning Configuration"]
            H[Default Patterns]
            I[Custom Patterns]
            J[Partner Patterns]
        end

        G --> |Uses| SecretScanning
        
        G -->|Clean| K[Push Successful]
        G -->|Alert| L[Secret Found]
        
        subgraph Actions["GitHub Actions"]
            L -->|Triggers| M[Create Issue]
            M -->|Assigns| N[Security Team]
            M -->|Labels| O[Priority: High]
            M -->|Notifies| P[Slack/Email]
        end
    end
```

## Key Components

1. **[Custom Pattern](.github/workflows/test-globo-secret-pattern.yml)**: `gbot-(dev|prod)-[A-Fa-f0-9]{16}` - [See format doc](globomantics-robot-auth-token-formats.md)
2. **[Alert Handler](.github/workflows/secret-alert-handler.yml)**: Creates labeled issues with remediation steps
3. **[Pre-commit Hook](.hooks/pre-commit)**: Local TruffleHog scanning

## Quick Test

```bash
# Run the test suite
./run-secret-test.sh

# Or trigger manually
gh workflow run test-secret-alert.yml
```

## Alert Response

Automated issue creation with:
- 🏷️ Smart labels (`security`, `priority:high`, `globomantics`)
- 📋 Location and severity details
- ✅ Remediation checklist
- 🔔 Optional Slack notifications

## Learn More

- [Secret Scanning Docs](https://docs.github.com/code-security/secret-scanning)
- [Custom Pattern Guide](https://docs.github.com/code-security/secret-scanning/defining-custom-patterns-for-secret-scanning)
- [Pluralsight: GitHub Advanced Security](https://www.pluralsight.com/authors/tim-warner)

---
*For Pluralsight GitHub Advanced Security course materials*
