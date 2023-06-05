package controllers

import (
	"fmt"
	"imports/library"
	"sync"
)

type ColaboradorEmail struct {
	User string
	pass *library.Password
	wg   sync.WaitGroup
}

func (ce *ColaboradorEmail) GenerateEmailAndPassword() {
	ce.wg.Add(1)
	go ce.pass.GeneratePassword(&ce.wg)

	var email *library.ManageEmail
	email.To = ce.emailTo()
	email.Messsage = ce.messageText()

	ce.wg.Add(1)
	go email.SendEmail(&ce.wg)
}

func (ce *ColaboradorEmail) GetPassword() string {
	ce.wg.Wait()
	return ce.pass.GetPassword()
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
