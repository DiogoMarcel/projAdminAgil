package library

import (
	"log"
	"os"
)

var (
	WarningLogger *log.Logger
	InfoLogger    *log.Logger
	ErrorLogger   *log.Logger
)

func init() {
	os.Remove(FILE_LOGGER)

	fl, err := os.OpenFile(FILE_LOGGER, os.O_APPEND|os.O_CREATE|os.O_WRONLY, 0666)
	if err != nil {
		log.Fatal(err)
	}

	InfoLogger = log.New(fl, "INFO: ", log.Ldate|log.Ltime|log.Lshortfile)
	WarningLogger = log.New(fl, "WARNING: ", log.Ldate|log.Ltime|log.Lshortfile)
	ErrorLogger = log.New(fl, "ERROR: ", log.Ldate|log.Ltime|log.Lshortfile)
}

/*
   InfoLogger.Println("Starting the application...")
   InfoLogger.Println("Something noteworthy happened")
   WarningLogger.Println("There is something you should know about")
   ErrorLogger.Println("Something went wrong")
*/
