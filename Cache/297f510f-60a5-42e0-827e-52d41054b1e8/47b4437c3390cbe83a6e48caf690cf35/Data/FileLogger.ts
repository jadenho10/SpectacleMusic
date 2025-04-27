/**
 * FileLogger utility for Spectacles
 * Handles writing logs to a file in the app's persistent storage
 */

export class FileLogger {
  private static instance: FileLogger;
  private logFilePath: string;
  private logBuffer: string[] = [];
  private bufferSize: number = 20; // Number of log entries to buffer before writing to file
  private isInitialized: boolean = false;

  private constructor() {
    // Get the Documents directory path in the app's persistent storage
    this.logFilePath = "LogFiles/SpectaclesLog.txt";
    this.initialize();
  }

  /**
   * Get the singleton instance
   */
  public static getInstance(): FileLogger {
    if (!FileLogger.instance) {
      FileLogger.instance = new FileLogger();
    }
    return FileLogger.instance;
  }

  /**
   * Initialize the logger and create log directory if needed
   */
  private initialize(): void {
    try {
      // Create directory if it doesn't exist
      global.PersistentStorageSystem.createDirectoryRecursively("LogFiles");
      
      // Check if file exists, create it if not
      if (!global.PersistentStorageSystem.fileExists(this.logFilePath)) {
        this.writeToFile(`=== Spectacles Log File Created: ${new Date().toISOString()} ===\n\n`);
      }
      
      this.isInitialized = true;
      this.log("FileLogger initialized successfully");
    } catch (error) {
      print(`Failed to initialize FileLogger: ${error}`);
    }
  }

  /**
   * Write content to the log file
   */
  private writeToFile(content: string): void {
    try {
      global.PersistentStorageSystem.writeToFile(this.logFilePath, content, true); // Append mode
    } catch (error) {
      print(`Failed to write to log file: ${error}`);
    }
  }

  /**
   * Log a message to the file with timestamp
   */
  public log(message: string, source: string = "DEFAULT"): void {
    if (!this.isInitialized) {
      this.initialize();
    }

    const timestamp = new Date().toISOString();
    const logEntry = `[${timestamp}][${source}] ${message}\n`;
    
    // Add to buffer
    this.logBuffer.push(logEntry);
    
    // Check if buffer should be flushed
    if (this.logBuffer.length >= this.bufferSize) {
      this.flush();
    }
  }

  /**
   * Flush buffer to file
   */
  public flush(): void {
    if (this.logBuffer.length === 0) {
      return;
    }
    
    try {
      const content = this.logBuffer.join("");
      this.writeToFile(content);
      this.logBuffer = [];
    } catch (error) {
      print(`Failed to flush log buffer: ${error}`);
    }
  }
  
  /**
   * Ensure all logs are written before app closes
   */
  public close(): void {
    this.flush();
  }
}
