import { existsSync } from "node:fs"
import { join } from "node:path"

const DEFAULT_TERMUX_PREFIX = "/data/data/com.termux/files/usr"

let cachedIsTermux: boolean | null = null

export function isTermux(): boolean {
	if (cachedIsTermux !== null) return cachedIsTermux

	if (process.env.TERMUX_VERSION) {
		cachedIsTermux = true
		return true
	}

	const prefix = process.env.PREFIX
	if (prefix && prefix.includes("com.termux")) {
		cachedIsTermux = true
		return true
	}

	if (process.platform === ("android" as NodeJS.Platform)) {
		cachedIsTermux = true
		return true
	}

	cachedIsTermux = false
	return false
}

export function getTermuxPrefix(): string {
	return process.env.PREFIX || DEFAULT_TERMUX_PREFIX
}

export function resolveTermuxBinaryPath(binaryName: string): string | null {
	const prefix = getTermuxPrefix()
	const termuxPath = join(prefix, "bin", binaryName)
	if (existsSync(termuxPath)) {
		return termuxPath
	}
	return null
}

export function getTermuxTmpDir(): string {
	return process.env.TMPDIR || join(getTermuxPrefix(), "tmp")
}

export function isLinuxLikePlatform(): boolean {
	return process.platform === "linux" || process.platform === ("android" as NodeJS.Platform)
}
