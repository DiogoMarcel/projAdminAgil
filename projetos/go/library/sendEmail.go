package library

import (
	"encoding/json"
	"fmt"
	"log"
	"math/rand"
	"net/smtp"
	"os"
	"sync"
)

type cfgUserEmail struct {
	From     string `json:"from"`
	Password string `json:"password"`
}

type SendEmail struct {
	To    []string
	senha string
	wg    sync.WaitGroup
}

func (s *SendEmail) PegarSenha() string {
	return s.senha
}

func (s *SendEmail) SendEmail() {

	fmt.Println("1")

	s.wg.Add(1)

	fmt.Println("2 go")

	go s.GerarSenhaRandom()

	fmt.Println("3")

	arquivo, errFile := os.ReadFile("cfgUserEmail.igo")
	if errFile != nil {
		log.Fatal(errFile)
	}
	var cfgUserEmail *cfgUserEmail

	errJson := json.Unmarshal(arquivo, &cfgUserEmail)
	if errJson != nil {
		log.Fatal(errJson)
	}

	message := []byte(fmt.Sprintf("To: %s \r\n"+
		"Subject: Sua autenticação de usuário\r\n\r\n"+
		"Olá, tudo bem? \r\n\r\n"+
		"Sua senha foi gerada automaticamente, utilize-a para conectar ao sistema.\r\n\r\n"+
		"Chave: %s", s.To, s.senha))

	// Create authentication
	smtpHost := "smtp.gmail.com"
	smtpPort := "587"
	auth := smtp.PlainAuth("", cfgUserEmail.From, cfgUserEmail.Password, smtpHost)

	fmt.Println("4 - waite")

	s.wg.Wait()

	fmt.Println("5 - send")

	// Send actual message
	err := smtp.SendMail(smtpHost+":"+smtpPort, auth, cfgUserEmail.From, s.To, message)
	if err != nil {
		log.Fatal(err)
	}
}

func (s *SendEmail) GerarSenhaRandom() {
	defer func() {
		s.wg.Done()
	}()
	digits := "0123456789"
	specials := "~=+%^*/()[]{}/!@#$?|"
	all := "ABCDEFGHIJKLMNOPQRSTUVWXYZ" +
		"abcdefghijklmnopqrstuvwxyz" +
		digits + specials
	length := 8
	buf := make([]byte, length)
	buf[0] = digits[rand.Intn(len(digits))]
	buf[1] = specials[rand.Intn(len(specials))]
	for i := 2; i < length; i++ {
		buf[i] = all[rand.Intn(len(all))]
	}
	rand.Shuffle(len(buf), func(i, j int) {
		buf[i], buf[j] = buf[j], buf[i]
	})
	s.senha = string(buf)
}
