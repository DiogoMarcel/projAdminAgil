package entities

import "time"

type Sprint struct {
	Id_Sprint  int64     `json:"id_sprint"`
	DataInicio time.Time `json:"datainicio"`
	DataFinal  time.Time `json:"datafinal"`
	Nome       string    `json:"nome"`
}
