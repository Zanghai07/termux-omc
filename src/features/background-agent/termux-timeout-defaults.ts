import { isTermux } from "../../shared/termux-detection"

const TERMUX_STALE_TIMEOUT_MS = 300_000
const TERMUX_MESSAGE_STALENESS_TIMEOUT_MS = 600_000
const TERMUX_SESSION_GONE_TIMEOUT_MS = 30_000
const TERMUX_TASK_TTL_MS = 15 * 60 * 1000
const TERMUX_DEFAULT_CONCURRENCY = 3

export interface TermuxTimeoutOverrides {
	staleTimeoutMs: number
	messageStalenessTimeoutMs: number
	sessionGoneTimeoutMs: number
	taskTtlMs: number
	defaultConcurrency: number
}

let cachedOverrides: TermuxTimeoutOverrides | null = null

export function getTermuxTimeoutOverrides(): TermuxTimeoutOverrides | null {
	if (cachedOverrides !== null) return cachedOverrides
	if (!isTermux()) {
		cachedOverrides = null
		return null
	}

	cachedOverrides = {
		staleTimeoutMs: TERMUX_STALE_TIMEOUT_MS,
		messageStalenessTimeoutMs: TERMUX_MESSAGE_STALENESS_TIMEOUT_MS,
		sessionGoneTimeoutMs: TERMUX_SESSION_GONE_TIMEOUT_MS,
		taskTtlMs: TERMUX_TASK_TTL_MS,
		defaultConcurrency: TERMUX_DEFAULT_CONCURRENCY,
	}
	return cachedOverrides
}
