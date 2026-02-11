---
name: product-analysis
description: Perform comprehensive technical due diligence and software product analysis across Data Engineering, Coding, Design, and DevOps. Use when evaluating a codebase, infrastructure, or product architecture for scalability, technical debt, or investment readiness.
---

# Product Analysis

This skill provides a structured framework for technical product analysis and due diligence.

## Workflow

1.  **Define Scope**: Determine which domains (Data, Code, Design, DevOps) are most critical for the current analysis.
2.  **Audit**: Use the checklists in [references/framework.md](references/framework.md) to perform a systematic review of each domain.
3.  **Synthesize**: Map technical findings to business risks (e.g., "High technical debt in the API layer will delay the Q3 mobile launch").

## Guidelines

- **Zero Hallucination**: Always verify "latest" standards or market trends using `web_search`.
- **Business Logic First**: Technical flaws are only "risks" if they impact the business's ability to scale, secure, or sustain the product.
- **Concise Reporting**: Focus on the 20% of issues that cause 80% of the risk.
