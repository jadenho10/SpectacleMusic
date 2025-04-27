"use strict";
/**
 * FileLogger utility for Spectacles
 * Handles collecting and storing logs in memory
 * (Note: Actual file storage is simulated since direct file access is limited)
 */
Object.defineProperty(exports, "__esModule", { value: true });
exports.FileLogger = void 0;
class FileLogger {
    constructor() {
        this.logRecords = [];
        this.isInitialized = false;
        this.maxLogEntries = 1000; // Maximum number of log entries to keep in memory
        this.initialize();
    }
    /**
     * Get the singleton instance
     */
    static getInstance() {
        if (!FileLogger.instance) {
            FileLogger.instance = new FileLogger();
        }
        return FileLogger.instance;
    }
    /**
     * Initialize the logger
     */
    initialize() {
        try {
            const initMessage = `=== Spectacles Log Started: ${new Date().toISOString()} ===`;
            this.logRecords.push(initMessage);
            print(initMessage);
            this.isInitialized = true;
            this.log("FileLogger initialized successfully");
        }
        catch (error) {
            print(`Failed to initialize FileLogger: ${error}`);
        }
    }
    /**
     * Add logs to the in-memory storage
     */
    storeLog(content) {
        try {
            // Add to memory storage
            this.logRecords.push(content);
            // Trim the log if it gets too large
            if (this.logRecords.length > this.maxLogEntries) {
                this.logRecords = this.logRecords.slice(-this.maxLogEntries);
            }
        }
        catch (error) {
            print(`Failed to store log: ${error}`);
        }
    }
    /**
     * Log a message with timestamp
     */
    log(message, source = "DEFAULT") {
        if (!this.isInitialized) {
            this.initialize();
        }
        const timestamp = new Date().toISOString();
        const logEntry = `[${timestamp}][${source}] ${message}`;
        // Store in memory and print to console
        this.storeLog(logEntry);
        // Uncomment the next line if you want to see logs in the console
        // print(logEntry);
    }
    /**
     * Get all stored logs as a formatted string
     */
    getAllLogs() {
        return this.logRecords.join('\n');
    }
    /**
     * Export logs to the console
     */
    dumpLogsToConsole() {
        print("=== SPECTACLES LOG DUMP ===\n");
        for (const entry of this.logRecords) {
            print(entry);
        }
        print("\n=== END OF LOG DUMP ===");
    }
    /**
     * Get the last N log entries
     */
    getRecentLogs(count = 50) {
        return this.logRecords.slice(-Math.min(count, this.logRecords.length));
    }
}
exports.FileLogger = FileLogger;
//# sourceMappingURL=FileLogger.js.map