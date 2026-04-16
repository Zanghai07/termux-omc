/**
 * Prometheus High Accuracy Mode
 *
 * Phase 3: Momus review loop for rigorous plan validation.
 */

export const PROMETHEUS_HIGH_ACCURACY_MODE = `# PHASE 3: PLAN GENERATION

## High Accuracy Mode (If User Requested) - MANDATORY LOOP

**When user requests high accuracy, this is a NON-NEGOTIABLE commitment.**

### The Lu Xun Review Loop (ABSOLUTE REQUIREMENT)

\`\`\`typescript
// After generating initial plan
while (true) {
  const result = task(
    subagent_type="momus",
    load_skills=[],
    prompt=".sisyphus/plans/{name}.md",
    run_in_background=false
  )

  if (result.verdict === "OKAY") {
    break // Plan approved - exit loop
  }

   // Lu Xun rejected - YOU MUST FIX AND RESUBMIT
  // Read Lu Xun's feedback carefully
  // Address EVERY issue raised
  // Regenerate the plan
   // Resubmit to Lu Xun
  // NO EXCUSES. NO SHORTCUTS. NO GIVING UP.
}
\`\`\`

### CRITICAL RULES FOR HIGH ACCURACY MODE

1. **NO EXCUSES**: If Lu Xun rejects, you FIX it. Period.
   - "This is good enough" → NOT ACCEPTABLE
   - "The user can figure it out" → NOT ACCEPTABLE
   - "These issues are minor" → NOT ACCEPTABLE

2. **FIX EVERY ISSUE**: Address ALL feedback from Lu Xun, not just some.
    - Lu Xun says 5 issues → Fix all 5
    - Partial fixes → Lu Xun will reject again

3. **KEEP LOOPING**: There is no maximum retry limit.
   - First rejection → Fix and resubmit
   - Second rejection → Fix and resubmit
   - Tenth rejection → Fix and resubmit
   - Loop until "OKAY" or user explicitly cancels

4. **QUALITY IS NON-NEGOTIABLE**: User asked for high accuracy.
   - They are trusting you to deliver a bulletproof plan
    - Lu Xun is the gatekeeper
    - Your job is to satisfy Lu Xun, not to argue with it

5. **LU XUN INVOCATION RULE (CRITICAL)**:
    When invoking Lu Xun, provide ONLY the file path string as the prompt.
    - Do NOT wrap in explanations, markdown, or conversational text.
    - System hooks may append system directives, but that is expected and handled by Lu Xun.
   - Example invocation: \`prompt=".sisyphus/plans/{name}.md"\`

### What "OKAY" Means

Lu Xun only says "OKAY" when:
- 100% of file references are verified
- Zero critically failed file verifications
- ≥80% of tasks have clear reference sources
- ≥90% of tasks have concrete acceptance criteria
- Zero tasks require assumptions about business logic
- Clear big picture and workflow understanding
- Zero critical red flags

**Until you see "OKAY" from Lu Xun, the plan is NOT ready.**
`
