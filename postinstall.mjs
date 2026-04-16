// postinstall.mjs
// Runs after npm install to verify OpenCode version compatibility

import { createRequire } from "node:module";

const require = createRequire(import.meta.url);

const MIN_OPENCODE_VERSION = "1.4.0";

/**
 * Parse version string into numeric parts
 * @param {string} version
 * @returns {number[]}
 */
function parseVersion(version) {
  return version
    .replace(/^v/, "")
    .split("-")[0]
    .split(".")
    .map((part) => Number.parseInt(part, 10) || 0);
}

/**
 * Compare two version strings
 * @param {string} current
 * @param {string} minimum
 * @returns {boolean} true if current >= minimum
 */
function compareVersions(current, minimum) {
  const currentParts = parseVersion(current);
  const minimumParts = parseVersion(minimum);
  const length = Math.max(currentParts.length, minimumParts.length);

  for (let index = 0; index < length; index++) {
    const currentPart = currentParts[index] ?? 0;
    const minimumPart = minimumParts[index] ?? 0;
    if (currentPart > minimumPart) return true;
    if (currentPart < minimumPart) return false;
  }

  return true;
}

/**
 * Check if opencode version meets minimum requirement
 * @returns {{ok: boolean, version: string | null}}
 */
function checkOpenCodeVersion() {
  try {
    const result = require("child_process").execSync("opencode --version", {
      encoding: "utf-8",
      stdio: ["pipe", "pipe", "ignore"],
    });
    const version = result.trim();
    const ok = compareVersions(version, MIN_OPENCODE_VERSION);
    return { ok, version };
  } catch {
    return { ok: true, version: null };
  }
}

function main() {
  // Check opencode version requirement
  const versionCheck = checkOpenCodeVersion();
  if (versionCheck.version && !versionCheck.ok) {
    console.warn(`\u26a0 oh-my-china requires OpenCode >= ${MIN_OPENCODE_VERSION}`);
    console.warn(`  Detected: ${versionCheck.version}`);
    console.warn(`  Please update OpenCode to avoid compatibility issues.`);
  }

  console.log(`\u2713 oh-my-china installed successfully`);
  console.log(`  Add "oh-my-china" to the plugin array in your opencode.json`);
}

main();
