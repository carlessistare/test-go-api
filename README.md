# Hello GeoIP API on GKE with NGINX Ingress & GeoIP2 Headers

This project sets up a simple **Golang HTTP API** behind an **NGINX Ingress Controller** on **Google Kubernetes Engine (GKE)**, with GeoIP headers injected using **MaxMind's GeoLite2 database**.

---

## 🔧 Stack

- **Golang** (`hello-api`) — simple web server printing request headers
- **NGINX Ingress Controller** (via Helm)
- **GeoIP2** support with `distroless` + `mmdb` database
- **Terraform** — for GCP project, cluster, and networking (optional)
- **Podman** — to build/push OCI images
- **GKE Autopilot** — cluster mode (with limitations bypassed)

---

## 🚀 Setup Steps

### 1. Install prerequisites

```bash
brew install --cask google-cloud-sdk
brew install kubectl
brew install podman
brew install helm
```

### 2. Authenticate with GCP

```bash
gcloud auth login
gcloud auth application-default login
gcloud config set project <YOUR_PROJECT_ID>
```

### 3. Create GKE Autopilot cluster

```bash
gcloud container clusters create-auto geoip-cluster \
  --region europe-west1
```

Get credentials
```bash
gcloud container clusters get-credentials geoip-cluster \
  --region europe-west1
```

### 4. Install ingress-nginx via Helm
```bash
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update

helm upgrade --install ingress-nginx ingress-nginx/ingress-nginx \
  --namespace ingress-nginx --create-namespace \
  -f helm/ingress/values.yaml
```

### 5. Build & push your Go app
```bash
podman build -t gcr.io/YOUR_PROJECT_ID/hello-api:latest .
podman push gcr.io/YOUR_PROJECT_ID/hello-api:latest
```

### 6. Deploy the Go API
```bash
kubectl apply -f k8s/deployment.yaml
```

### 7. Create Ingress resource
```bash
kubectl apply -f k8s/ingress.yaml
```

### 8. Test your deployment
Get the IP:
```bash
kubectl get ingress hello-api-ingress
```
Test
```bash
curl -H "Host: hello.local" http://<LB_IP>
```

### 9. Troubleshooting
* View Ingress Logs
```bash
kubectl logs -n ingress-nginx -l app.kubernetes.io/component=controller -f
```

* Inspect Mounted geoip db files
```bash
kubectl exec -n ingress-nginx <pod> -c controller -- ls /etc/ingress-controller/geoip
```

* Get pod id's
```bash
kubectl get pods -n ingress-nginx
```

* Restart instances
```bash
kubectl rollout restart deployment ingress-nginx-controller -n ingress-nginx
```

* Connect to bash pod
```bash
kubectl exec -n ingress-nginx -it <pod> -c controller -- /bin/bash
```

