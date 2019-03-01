# Spring Hello World on Kubernetes

Not only can you run Spring Cloud Hello World on Kubernetes, but with the `spring-cloud-kubernetes` integrations you can have it dynamically load application properties from a `configmap` or `secret`.

## Quick Start w/ minikube

Clone down the git repository:

```console
git clone https://github.com/paulczar/spring-helloworld
cd spring-hello-world
```

Start Minikube:

```console
$ minikube start --extra-config=apiserver.authorization-mode=RBAC
😄  minikube v0.34.1 on linux (amd64)
...
...
💗  kubectl is now configured to use "minikube"
🏄  Done! Thank you for using minikube!

$ kubectl version
Client Version: version.Info{Major:"1", Minor:"13", GitVersion:"v1.13.2", GitCommit:"cff46ab41ff0bb44d8584413b598ad8360ec1def", GitTreeState:"clean", BuildDate:"2019-01-10T23:35:51Z", GoVersion:"go1.11.4", Compiler:"gc", Platform:"linux/amd64"}
Server Version: version.Info{Major:"1", Minor:"13", GitVersion:"v1.13.3", GitCommit:"721bfa751924da8d1680787490c54b9179b1fed0", GitTreeState:"clean", BuildDate:"2019-02-01T20:00:57Z", GoVersion:"go1.11.5", Compiler:"gc", Platform:"linux/amd64"}
```

Use minikube's Docker daemon to avoid needing to use a registry:

```
$ eval `minikube docker-env`
$ docker images
REPOSITORY                                 TAG                 IMAGE ID            CREATED             SIZE
k8s.gcr.io/kube-controller-manager         v1.13.3             0482f6400933        3 weeks ago         146MB
k8s.gcr.io/kube-apiserver                  v1.13.3             fe242e556a99        3 weeks ago         181MB
```

Build the spring-hello image:

```console
$ docker build -t paulczar/spring-hello:0.0.1 .
...
...
```

Run spring-hello:

```console
$ kubectl create namespace hello
namespace/hello created

$ kubectl apply -n hello -f deploy
configmap/hello created
deployment.extensions/hello created
role.rbac.authorization.k8s.io/hello created
rolebinding.rbac.authorization.k8s.io/hello created

$ minikube service hello --url
http://192.168.99.103:32334
```

That last command gets the URL for the nodeport of your service. You should be able to use `curl` against the provided URL:

```console
$ curl http://192.168.99.103:32334
Hello World
```

This `Hello World` message is pulled from our configmap in `deploy/configmap.yaml` which has the key `message: Hello World` in it's data. We can change the value and see how our Application dynamically refreshes to use this new configuration:

```console
$ k apply -f deploy/configmaps/hello-i-love-you.yaml
configmap/hello configured

$ curl http://192.168.99.103:32334
Hello World, I LOVE YOU!%
```

Pretty cool yeah?