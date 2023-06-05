package library

import (
	"encoding/json"
	"imports/entities"
	"log"
	"net/smtp"
	"sync"
)

type ManageEmail struct {
	To       []string
	Messsage []byte
}

func (s *ManageEmail) checkConfiguration() (string, string) {
	var cfgUserEmail *entities.ConfiguracaoUsuarioEmail
	var adfiles *AdminFiles
	arquivo := adfiles.AFReadFile("cfgUserEmail.igo")
	errJson := json.Unmarshal(arquivo, &cfgUserEmail)

	if errJson != nil {
		log.Fatal(errJson)
	}

	return cfgUserEmail.From, cfgUserEmail.Password
}

func (s *ManageEmail) SendEmail(wg *sync.WaitGroup) {
	defer func() {
		wg.Done()
	}()
	from, password := s.checkConfiguration()

	// Create authentication
	smtpHost := "smtp.gmail.com"
	smtpPort := "587"
	auth := smtp.PlainAuth("", from, password, smtpHost)

	// Send actual message
	err := smtp.SendMail(smtpHost+":"+smtpPort, auth, from, s.To, s.Messsage)
	if err != nil {
		log.Fatal(err)
	}
}
