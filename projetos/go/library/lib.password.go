package library

import (
	"math/rand"
	"sync"
)

type Password struct {
	password string
}

func (p *Password) GeneratePassword(wg *sync.WaitGroup) {
	defer func() {
		wg.Done()
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

	p.password = string(buf)
}

func (p *Password) GetPassword() string {
	return p.password
}
