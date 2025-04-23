package main

import (
	"encoding/json"
	"net/http"
)

func helloHandler(w http.ResponseWriter, r *http.Request) {
	// Flatten headers into a map[string]string for easy JSON output
	headers := map[string]string{}
	for name, values := range r.Header {
		if len(values) > 0 {
			headers[name] = values[0]
		}
	}

	// Set response content type
	w.Header().Set("Content-Type", "application/json")

	// Encode headers to JSON and write to response
	json.NewEncoder(w).Encode(headers)

}

func main() {
	http.HandleFunc("/", helloHandler)
	http.ListenAndServe(":8080", nil)
}
