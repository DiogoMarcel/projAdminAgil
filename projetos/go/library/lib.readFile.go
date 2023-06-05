package library

import (
	"log"
	"os"
)

type AdminFiles struct{}

func (af *AdminFiles) AFReadFile(name string) []byte {
	arquivo, errFile := os.ReadFile(name)
	if errFile != nil {
		log.Fatal(errFile)
	}
	return arquivo
}

func (af *AdminFiles) AFFileCfgEmailExists() {
	// Here Stat() function returns file info and
	//if there is no file, then it will return an error

	myfile, e := os.Stat("cfgUserEmails.igo")
	if e != nil {

		// Checking if the given file exists or not
		// Using IsNotExist() function
		if os.IsNotExist(e) {
			log.Fatal("File not Found !!")
		}
	}
	log.Println("File Exist!!")
	log.Println("Detail of file is:")
	log.Println("Name: ", myfile.Name())
	log.Println("Size: ", myfile.Size())
}
