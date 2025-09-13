---
description: Analyze Dependabot security advisory and provide resolution strategy
---

## Context

Dependabot URL (GitHub Security Advisory or PR URL): {{ dependabot_url }}

## Your task

Analyze Dependabot security advisory and provide resolution strategy.

### Step 1: Gather Advisory Information

Execute the following commands to collect information:

**Query Dependabot Information:**
First, determine the URL type and use appropriate command:
- If URL contains `/security/dependabot/[number]`: Use `gh api /repos/[owner]/[repo]/dependabot/alerts/[number]`
- If URL contains `/pull/`: Use `gh pr view {{ dependabot_url }} --json title,body,commits`
- If URL contains GitHub Security Advisory ID (GHSA-xxxx): Use `gh api /advisories/[GHSA-ID]`

**Important**: Only execute the command that matches the provided URL type to avoid 404 errors.

**Check Current Project Status:**
- git status
- pnpm list --depth=0 (check direct dependencies)
- If vulnerable package found: pnpm why [package-name]

**Verify Actual Usage (to avoid cache issues):**
- grep -r "[package-name]" package.json pnpm-lock.yaml (check if package exists in lock files)
- If package not found in lock files: likely already resolved or cache issue

### Step 2: Dependency Analysis

Analyze the vulnerable package as follows:

1. **Check Direct vs Indirect Dependency**
   - Check if the package exists in package.json
   - If yes: Direct dependency
   - If no: Indirect dependency

2. **Analyze Dependency Tree**
   - Analyze pnpm why [package-name] results
   - Identify which parent packages depend on this package

### Step 3: Resolution Strategy

**For Direct Dependencies:**
# Update the package directly
pnpm update [package-name]
# Or modify package.json version then
pnpm install

**For Indirect Dependencies:**
1. **Analyze Parent Package Update Requirements**
   # Check what version of parent package would resolve the vulnerability
   pnpm info [parent-package-name] versions --json
   # Check current version in package.json
   cat package.json | grep [parent-package-name]

2. **Resolution Options Analysis**
   - Check if parent package update is **minor/patch** (low risk) or **major** (high risk)
   - For minor/patch updates: Recommend direct parent package update
   - For major updates: Provide both options with trade-off analysis

3. **Option A: Update Parent Package (Recommended for minor/patch)**
   pnpm update [parent-package-name]@[specific-version]

4. **Option B: Use Overrides (Recommended for major updates)**
   // Add to package.json
   {
     "pnpm": {
       "overrides": {
         "[package-name]": "^[safe-version]"
       }
     }
   }

### Step 4: Generate Analysis Report

Present the analysis results in the following format:

```
## 🚨 Dependabot Advisory Analysis

**Reference URL**: {{ dependabot_url }}

### Vulnerable Package
- **Package Name**: [package-name] ([direct/indirect dependency])
- **Current Version**: [current-version] → **Recommended**: [recommended-version]
- **Severity**: [severity-level]

### 🔧 Resolution Strategy
**For indirect dependencies, include this analysis:**
- **Parent Package**: [parent-package] ([current] → [required version])
- **Update Level**: [Major/Minor/Patch]
- **Recommended Method**: [Parent package update/Use overrides]
- **Reason**: [Major update has breaking changes risk/Minor update has minimal impact, etc.]

[Specific resolution steps]

### 📋 Checklist
- [ ] Verify if only pnpm-lock.yaml changed without package.json changes
- [ ] For indirect dependencies, dependency source identified
- [ ] Package actually exists in lock files (not stale cache)
- [ ] Breaking changes reviewed
```

**Execute all commands and provide comprehensive analysis results in the above format.**
