package main

import (
	"fmt"
	conexao "imports/conexaoBD"
	"imports/routes"
	"log"
	"net/http"

	"github.com/gorilla/mux"
	_ "github.com/lib/pq"
)

func main() {
	defer conexao.CloseDB()

	rotas := mux.NewRouter().StrictSlash(true)

	routes.RegisterStoreRoutes(rotas)

	var port = "127.0.0.1:3000"
	fmt.Println("Server running in port:", port)

	http.Handle("/", rotas)

	log.Fatal(http.ListenAndServe(port, rotas))
}

func init() {
	conexao.InitBD()
}
