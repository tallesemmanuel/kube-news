## Deployment projeto Kubenews em kubernetes

## Requisitos - Ter instalado os seguintes serviços.

- Kubectl - https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/
- Kind - https://kind.sigs.k8s.io/
- Docker - https://docs.docker.com/engine/install/ubuntu/

## Como iniciar com esse projeto

Download do projeto.

```bash
https://github.com/tallesemmanuel/kube-news.git
```

- Iniciar um cluster.

No meu caso, estou subindo um cluster com 3 agents e 3 servers, analise se para você da certo o total de nós.
Também neste comando, estou especificando a porta da aplicação "8080", mapeando localmente uma porta "30000" para o loadbalancer, caso tenha muitos pods e seja escalável.

```bash
kind create cluster
```

- Para realizar o deployment da aplicação, se da necessário rodar apenas um comando.

```bash
kubectl apply -f k8s/deployment.yml
```

- Você pode acompanhar os serviços com o comando.
Nele você consegue ver todos os "pods", "services", "replicateSets", "deployments" e etc.

```bash
kubectl get all
```

Saída do comando.

```bash
NAME                            READY   STATUS    RESTARTS      AGE
pod/kubenews-577bc74574-mk5v7   1/1     Running   2 (11m ago)   11m
pod/postgres-547d6d59c5-f6hqr   1/1     Running   0             11m

NAME                 TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
service/kubenews     NodePort    10.96.225.242   <none>        81:30000/TCP   15m
service/kubernetes   ClusterIP   10.96.0.1       <none>        443/TCP        31m
service/postgres     ClusterIP   10.96.125.31    <none>        5432/TCP       16m

NAME                       READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/kubenews   1/1     1            1           16m
deployment.apps/postgres   1/1     1            1           16m

NAME                                  DESIRED   CURRENT   READY   AGE
replicaset.apps/kubenews-577bc74574   1         1         1       11m
replicaset.apps/kubenews-6dc7bc659b   0         0         0       16m
replicaset.apps/postgres-547d6d59c5   1         1         1       11m
replicaset.apps/postgres-7d6d9c465c   0         0         0       16m
```

- Realizando um port-forward para acessar a aplicação.

```sh
kubectl port-forward pods/kubenews-577bc74574-mk5v7 80:8080
```

Saída do comando:

```sh
Forwarding from 127.0.0.1:80 -> 8080
Forwarding from [::1]:80 -> 8080
```

Acesse no seu navegador "http://localhost" ou com o curl.

```sh
curl localhost
```

Saída do curl:

```sh
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="/assets/dist/css/bootstrap.min.css" rel="stylesheet">
        <title>KubeBlog</title>
</head>
<body class="m-0 p-0">
    <div class="container-fluid m-0 p-0">
                <!-- navbar -->
        <div>
            <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
                <div class="container-fluid">
                    <a class="navbar-brand text-warning" href="/">KubeNews</a>
                    <ul class="nav">
                        <li class="nav-item">
                          <a class="nav-link active" style="color: #ffc105;" aria-current="page" href="/post">Novo Post</a>
                        </li>                       
                      </ul>
                </div>
            </nav>
        </div>
        <!-- News  -->
        <div>
            <div>
                <div class="row m-3" id="newsType">
                    <h4></h4>
                </div>
                <div class="row me-2 ms-2" id="newsdetails">
                    
                        <h3>Ainda não temos nenhum post, que tal você criar um ?</h3>
                                       
                </div>
            </div>
        </div>
    </div>
    <script src="/assets/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>%                                
```

### Contribuindo com o projeto.

Faça todo passo acima.
Commit suas mudanças (git commit -am 'Add some fooBar')
Push sua branch (git push origin feature/fooBar)
Crie uma nova Pull Request.