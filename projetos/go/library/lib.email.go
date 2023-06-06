package library

import (
	"encoding/json"
	"imports/entities"
	"net/smtp"
)

type ManageEmail struct {
	To       []string
	Messsage []byte
}

func (s *ManageEmail) checkConfiguration() (string, string, error) {
	var cfgUserEmail *entities.ConfiguracaoUsuarioEmail
	var adfiles *AdminFiles

	arquivo, errFile := adfiles.AFReadFile(FILE_CFG_EMAIL_NAME)
	if errFile != nil {
		return "", "", errFile
	}

	errJson := json.Unmarshal(arquivo, &cfgUserEmail)
	if errJson != nil {
		return "", "", errJson
	}

	return cfgUserEmail.From, cfgUserEmail.Password, nil
}

func (s *ManageEmail) SendEmail() error {
	from, password, errCheck := s.checkConfiguration()

	if errCheck != nil {
		return errCheck
	}

	// Create authentication
	smtpHost := "smtp.gmail.com"
	smtpPort := "587"
	auth := smtp.PlainAuth("", from, password, smtpHost)

	// Send actual message
	err := smtp.SendMail(smtpHost+":"+smtpPort, auth, from, s.To, s.Messsage)
	if err != nil {
		return err
	}

	return nil
}
