package controllers

import (
	"fmt"
	"imports/library"
)

type ColaboradorEmail struct {
	User     string
	password library.Password
}

func (ce *ColaboradorEmail) GenerateEmailAndPassword() error {
	ce.password.GeneratePassword()

	email := library.ManageEmail{To: ce.emailTo(), Messsage: ce.messageText()}

	return email.SendEmail()
}

func (ce *ColaboradorEmail) GetPassword() string {
	return ce.password.GetPassword()
}

func (ce *ColaboradorEmail) emailTo() []string {
	return []string{ce.User}
}

func (ce *ColaboradorEmail) messageText() []byte {
	return []byte(fmt.Sprintf("To: %s \r\n"+
		"Subject: Sua autenticação de usuário\r\n\r\n"+
		"Olá, tudo bem? \r\n\r\n"+
		"Sua senha foi gerada automaticamente, utilize-a para conectar ao sistema.\r\n\r\n"+
		"Chave: %s",
		ce.emailTo(),
		ce.GetPassword()))
}
