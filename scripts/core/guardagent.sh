#!/bin/bash
# Factory Guardagent (v1.0)
# Part of the Agent Factory Template Orchestration
# Purpose: Validate workspace changes against architectural standards

echo "🛡️ [Factory Guardagent] Commencing architectural audit..."

# 1. Check for project context
if [ ! -f "AGENTS.md" ]; then
    echo "❌ CRITICAL: AGENTS.md missing. Project context is required for agentic workflows."
    exit 1
fi

# 2. Scan for "Dirty" CI/Dev patterns
echo "🔍 Checking for technical debt patterns..."
patterns=("legacy-peer-deps" "|| true")

for pattern in "${patterns[@]}"; do
    if grep -r "$pattern" . --exclude-dir=node_modules --exclude-dir=.git --exclude-dir=scripts/core > /dev/null; then
        echo "⚠️ WARNING: '$pattern' detected. This violates the 'Endless Perfection' protocol."
    fi
done

# 3. Verify Quality Tooling existence
if [ ! -d ".github/workflows" ]; then
    echo "⚠️ WARNING: GitHub Actions workflows missing."
fi

# 4. Git Integrity
if [[ $(git status --short) ]]; then
    echo "📝 NOTE: Local workspace has uncommitted changes."
fi

echo "✅ [Factory Guardagent] Audit complete."
