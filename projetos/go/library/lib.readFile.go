package library

import (
	"os"
)

type AdminFiles struct{}

func (af *AdminFiles) AFReadFile(name string) ([]byte, error) {
	arquivo, errFile := os.ReadFile(name)
	if errFile != nil {
		return nil, errFile
	}
	return arquivo, nil
}

func (af *AdminFiles) AFFileCfgEmailExists() {
	_, e := os.Stat(FILE_CFG_EMAIL_NAME)
	if e != nil {
		if os.IsNotExist(e) {
			WarningLogger.Println(MESSAGE_FILE_CFGEMAIL_NOTFOUND)
		}
	} else {
		InfoLogger.Println(MESSAGE_FILE_CFGEMAIL_EXISTS)
	}
}
