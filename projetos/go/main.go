package main

import (
	conexao "imports/conexaoBD"
	"imports/library"
	"imports/routes"
	"log"
	"net/http"

	"github.com/gorilla/mux"
	_ "github.com/lib/pq"
	"github.com/rs/cors"
)

func main() {
	defer conexao.CloseDB()

	rotas := mux.NewRouter().StrictSlash(true)

	routes.RegisterStoreRoutes(rotas)

	var port = "127.0.0.1:3000"

	library.InfoLogger.Println("Server running in port:", port)

	http.Handle("/", rotas)

	handler := cors.AllowAll().Handler(rotas)
	log.Fatal(http.ListenAndServe(port, handler))
}

func init() {
	conexao.InitBD()

	var adminPass *library.AdminFiles
	adminPass.AFFileCfgEmailExists()
}
