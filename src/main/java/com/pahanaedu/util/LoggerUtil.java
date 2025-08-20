package com.pahanaedu.util;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.logging.FileHandler;
import java.util.logging.Logger;
import java.util.logging.SimpleFormatter;

public class LoggerUtil {
    private static Logger logger = Logger.getLogger(LoggerUtil.class.getName());
    private static boolean isInitialized = false;

    public static Logger getLogger() {
        if (!isInitialized) {
            try {
                String userHome = System.getProperty("user.home");
                String logDir = userHome + "/pahanaedu_logs";

                Files.createDirectories(Paths.get(logDir));

                String logFile = logDir + "/pahanaedu.log";

                FileHandler fileHandler = new FileHandler(logFile, true);
                fileHandler.setFormatter(new SimpleFormatter());

                logger.addHandler(fileHandler);
                logger.setUseParentHandlers(true);

                isInitialized = true;
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return logger;
    }
}
