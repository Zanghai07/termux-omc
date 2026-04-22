import { existsSync } from "node:fs"
import { join } from "node:path"
import { isTermux, getTermuxPrefix } from "../termux-detection"

const DEFAULT_ZSH_PATHS = ["/bin/zsh", "/usr/bin/zsh", "/usr/local/bin/zsh"]
const DEFAULT_BASH_PATHS = ["/bin/bash", "/usr/bin/bash", "/usr/local/bin/bash"]

function getTermuxShellPaths(shellName: string): string[] {
	const prefix = getTermuxPrefix()
	return [join(prefix, "bin", shellName)]
}

function getShellSearchPaths(shellName: string, defaultPaths: string[]): string[] {
	if (isTermux()) {
		return [...getTermuxShellPaths(shellName), ...defaultPaths]
	}
	return defaultPaths
}

function findShellPath(
	shellName: string,
	defaultPaths: string[],
	customPath?: string,
): string | null {
	if (customPath && existsSync(customPath)) {
		return customPath
	}

	const searchPaths = getShellSearchPaths(shellName, defaultPaths)
	for (const path of searchPaths) {
		if (existsSync(path)) {
			return path
		}
	}
	return null
}

export function findZshPath(customZshPath?: string): string | null {
	return findShellPath("zsh", DEFAULT_ZSH_PATHS, customZshPath)
}

export function findBashPath(): string | null {
	return findShellPath("bash", DEFAULT_BASH_PATHS)
}
