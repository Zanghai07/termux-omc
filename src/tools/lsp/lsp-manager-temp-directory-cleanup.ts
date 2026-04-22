import { tmpdir } from "node:os"

type ManagedClientForTempDirectoryCleanup = {
	refCount: number
	client: {
		stop: () => Promise<void>
	}
}

const TEMP_DIR_PREFIXES = ["/tmp/", "/var/folders/"]

function getTempDirPrefixes(): string[] {
	const systemTmpDir = tmpdir()
	const prefixes = [...TEMP_DIR_PREFIXES]
	if (!prefixes.some((p) => systemTmpDir.startsWith(p.slice(0, -1)))) {
		prefixes.push(systemTmpDir.endsWith("/") ? systemTmpDir : `${systemTmpDir}/`)
	}
	return prefixes
}

function isTempDirectory(dirPath: string): boolean {
	const prefixes = getTempDirPrefixes()
	return prefixes.some((prefix) => dirPath.startsWith(prefix))
}

export async function cleanupTempDirectoryLspClients(
	clients: Map<string, ManagedClientForTempDirectoryCleanup>
): Promise<void> {
	const keysToRemove: string[] = []
	for (const [key, managed] of clients.entries()) {
		if (isTempDirectory(key) && managed.refCount === 0) {
			keysToRemove.push(key)
		}
	}

	for (const key of keysToRemove) {
		const managed = clients.get(key)
		if (managed) {
			clients.delete(key)
			try {
				await managed.client.stop()
			} catch {}
		}
	}
}
