#!/bin/bash
set -euo pipefail
# Factory Mission Control (v1.0)
# Orchestrates the handoff between specialized sub-agents

MISSION_NAME=${1:-"GENERIC_FEATURE"}
echo "🚀 [Mission Control] Initializing Mission: $MISSION_NAME"

# PHASE 1: RECON (Architecture Review)
echo "🔍 [Phase 1: RECON] Running Guardagent to locate project boundaries..."
./scripts/core/guardagent.sh

# PHASE 2: FORGE (Development)
# This phase typically involves calling the Developer sub-agent or executing local scripts
echo "🛠️ [Phase 2: FORGE] Executing feature development for: $MISSION_NAME"
# [Template Placeholder: Call /new-feature or specific build scripts here]

# PHASE 3: VERIFY (Testing)
echo "🧪 [Phase 3: VERIFY] Validating changes with Quality Checks..."
if [ -f "package.json" ]; then
    npm run lint
    npm run typecheck
    npm run test
    npm run format:check
fi

# PHASE 4: CRITIQUE (Final Review)
echo "⚖️ [Phase 4: CRITIQUE] Final Architectural Audit..."
./scripts/core/guardagent.sh

echo "🏁 [Mission Control] Mission: $MISSION_NAME - STATUS: COMPLETED"
