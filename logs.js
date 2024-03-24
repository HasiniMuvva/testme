import fs from "fs";
import Logger from 'node-json-logger';

const logFilePath = '/var/log/google-cloud-ops-agent/myapp.log';
const logStream = fs.createWriteStream(logFilePath, { flags: 'a' });

const logger = new Logger({ level: 'info', timestamp: true, stdout: logStream });

function logMessage(severity, message) {
    const logEntry = {severity: severity, message: message}; // Include severity in the log message JSON payload
    fs.promises.appendFile(logFilePath, JSON.stringify(logEntry) + '\n')
        .then(() => {
            console.log('Log entry appended successfully.');
        })
        .catch((err) => {
            console.error('Error appending to log file:', err);
        });
    logger.info(logEntry); // Log the message with severity included in the JSON payload
}

export default {
    info: function(message) {
        logMessage('info', message);
    },
    warn: function(message) {
        logMessage('warn', message);
    },
    error: function(message) {
        logMessage('error', message);
    },
    debug: function(message) {
        logMessage('debug', message);
    },
    fatal: function(message) {
        logMessage('fatal', message);
    }
};
