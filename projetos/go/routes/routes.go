package routes

import (
	"imports/controllers"
	"net/http"

	"github.com/gorilla/mux"
)

var RegisterStoreRoutes = func(router *mux.Router) {
	router.HandleFunc("/equipe", controllers.EquipeInserir).Methods(http.MethodPost)
	router.HandleFunc("/equipe", controllers.EquipeAlterar).Methods(http.MethodPatch)
	router.HandleFunc("/equipe", controllers.EquipeDeletar).Methods(http.MethodDelete)
	router.HandleFunc("/equipe", controllers.EquipePegarTodos).Methods(http.MethodGet)

	router.HandleFunc("/cargo", controllers.CargoInserir).Methods(http.MethodPost)
	router.HandleFunc("/cargo", controllers.CargoAlterar).Methods(http.MethodPatch)
	router.HandleFunc("/cargo", controllers.CargoDeletar).Methods(http.MethodDelete)
	router.HandleFunc("/cargo", controllers.CargoPegarTodos).Methods(http.MethodGet)

	router.HandleFunc("/empresa", controllers.EmpresaInserir).Methods(http.MethodPost)
	router.HandleFunc("/empresa", controllers.EmpresaAlterar).Methods(http.MethodPatch)
	router.HandleFunc("/empresa", controllers.EmpresaDeletar).Methods(http.MethodDelete)
	router.HandleFunc("/empresa", controllers.EmpresaPegarTodos).Methods(http.MethodGet)

	router.HandleFunc("/funcao", controllers.FuncaoInserir).Methods(http.MethodPost)
	router.HandleFunc("/funcao", controllers.FuncaoAlterar).Methods(http.MethodPatch)
	router.HandleFunc("/funcao", controllers.FuncaoDeletar).Methods(http.MethodDelete)
	router.HandleFunc("/funcao", controllers.FuncaoPegarTodos).Methods(http.MethodGet)

	router.HandleFunc("/colaborador", controllers.ColaboradorInserir).Methods(http.MethodPost)
	router.HandleFunc("/colaborador", controllers.ColaboradorAlterar).Methods(http.MethodPatch)
	router.HandleFunc("/colaborador", controllers.ColaboradorDeletar).Methods(http.MethodDelete)
	router.HandleFunc("/colaborador", controllers.ColaboradorPegarTodos).Methods(http.MethodGet)

	router.HandleFunc("/pesquisa", controllers.PesquisaInserir).Methods(http.MethodPost)
	router.HandleFunc("/pesquisa", controllers.PesquisaAlterar).Methods(http.MethodPatch)
	router.HandleFunc("/pesquisa", controllers.PesquisaDeletar).Methods(http.MethodDelete)
	router.HandleFunc("/pesquisa", controllers.PesquisaPegarTodos).Methods(http.MethodGet)

	router.HandleFunc("/sprint", controllers.SprintInserir).Methods(http.MethodPost)
	router.HandleFunc("/sprint", controllers.SprintAlterar).Methods(http.MethodPatch)
	router.HandleFunc("/sprint", controllers.SprintDeletar).Methods(http.MethodDelete)
	router.HandleFunc("/sprint", controllers.SprintPegarTodos).Methods(http.MethodGet)
}
