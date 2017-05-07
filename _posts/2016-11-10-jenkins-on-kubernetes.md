---
layout: post
title: Jenkins on Kubernetes
date: 2016-11-10
tag: [rand]
twitter: starefossen
published: true
---

My recent adventures have lead me deep into the world of
[Kubernetes][kubernetes]. Kubernetes is an open-source system for automating
deployment, scaling, and management of containerized applications. What if we
could leverage our Kubenretes cluster to run our automated Jenkins builds as
well?! :bulb:

![Jenkins on Kubernetes](/uploads/2016/11/15/jenkins.png)

<!--more-->

The easiest way to get started with Kubernetes is using [minikube][minikube].
Minikube runs a single-node Kubernetes cluster inside a VM on your local
machine. The install of `minikube` is pretty straight forward, but for Windows
users I have created a [dedicated install guide][minikube-windows].

> Want to learn Kubernetes in a practical and hands on way? Check out my
> free [Kubernetes Workshop on GitHub][k8s-workshop].

## Deploy to Kubernetes

Now that we have `minikube` running, lets get on with deploying
[Jenkins][jenkins-ci] to our Kubernetes cluster. All of the configuration
necessary is avaiable from [Starefossen/jenkins-k8s-demo][jenkins-k8s-demo].

```
$ kubectl apply -f namespace.yaml
$ kubectl apply -f storage.yaml
$ kubectl apply -f service.yaml
$ kubectl apply -f deployment.yaml
```

We can inspect how the deployment is progressing by running the following two
commands - each in their own terminal window.

```
$ kubectl -n jenkins get deployments -w
$ kubectl -n jenkins get pods -w
```

## Setup Jenkins

Now that Jenkins is running, it is time to set it up. First we need to locate
the unique URL for our Jenkins master inside `minikube`. We can use the
`minikube service` command for that:

```
$ minikube service --url jenkins -n jenkins

http://172.16.10.138:31758
http://172.16.10.138:32632
```

The first URL is the Jenkins UI, the other is the slave connection port. But,
before we can go to it we need the temporary password Jenkins have created. Lets
get it from the logs:

```
$ kubectl logs jenkins-67105894-3c0gz -n jenkins

*************************************************************
*************************************************************
*************************************************************

Jenkins initial setup is required. An admin user has been created and a password
generated. Please use the following password to proceed to installation:

b54243cbd92349fea3f9fa05b709e715

This may also be found at: /var/jenkins_home/secrets/initialAdminPassword

*************************************************************
*************************************************************
*************************************************************
```

As you see, we could just as well have used the `kubectl exec` command to get
the temporary password from the `Pod`. Now we can procede with the insprocede
with the installation. You don't need to add any Plugins, we can add them later.

![Jenkins Installer](/uploads/2016/11/15/install.png)

## Required Pluggins



* Pipelines
* Kubernetes

[minikube]: https://github.com/kubernetes/minikube
[minikube-download]: https://github.com/kubernetes/minikube/releases/latest
[minikube-windows]: https://github.com/evry-bergen/kubernetes-workshop/wiki/Windows-Setup-Guide
[kubernetes]: http://kubernetes.io
[k8s-workshop]: https://github.com/evry-bergen/kubernetes-workshop
[jenkins-ci]: https://jenkins.io
[jenkins-docker-hub]: https://hub.docker.com/r/library/jenkins
[jenkins-k8s-demo]: https://github.com/Starefossen/jenkins-k8s-demo
[jenkins-k8s-plugin]: https://github.com/jenkinsci/kubernetes-plugin
[jenkins-k8s-pipeline]: https://github.com/fabric8io/jenkins-pipeline-library

[jenkins-k8s-jira]: https://issues.jenkins-ci.org/browse/JENKINS-38278?jql=project%20%3D%20JENKINS%20AND%20status%20in%20(Open%2C%20%22In%20Progress%22%2C%20Reopened)%20AND%20component%20%3D%20%27kubernetes-plugin%27
[fabric8-jenkins-k8s]: https://blog.fabric8.io/a-kubernetes-workflow-plugin-for-jenkins-b62110be03dc#.wkib69mxc
[jenkins-distributed-builds]: https://wiki.jenkins-ci.org/display/JENKINS/Distributed+builds
[github-podTemplate]: https://github.com/search?l=groovy&langOverride=&q=podTemplate&repo=&start_value=1&type=Code
[github-from-jenkins]: https://github.com/search?l=Dockerfile&q=FROM+jenkins&ref=searchresults&type=Code&utf8=%E2%9C%93
[jenkins-pipeline-input]: https://support.cloudbees.com/hc/en-us/articles/204986450-Pipeline-How-to-manage-user-inputs
[github-jenkind-docker]: https://github.com/dnABic/jenkins_k8s_aws/blob/master/Jenkinsfile
