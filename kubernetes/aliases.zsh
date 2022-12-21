#!/bin/sh

alias kx='kubectx'
alias kn='kubens'

alias k='kubectl'
alias sk='kubectl -n kube-system'
alias ke='EDITOR=vim kubectl edit'
alias klbaddr="kubectl get svc -ojsonpath='{.status.loadBalancer.ingress[0].hostname}'"

alias kdebug='kubectl run -i -t debug --rm --image=caarlos0/debug --restart=Never'
alias knrunning='kubectl get pods --field-selector=status.phase!=Running'
alias kfails='kubectl get po -owide --all-namespaces | grep "0/" | tee /dev/tty | wc -l'
alias kimg="kubectl get deployment --output=jsonpath='{.spec.template.spec.containers[*].image}'"
alias kvs="kubectl view-secret"
alias kvc="kubectl view-configmap"
alias kvi="kubectl view-ingress"
alias kvcert="kubectl view-certificate"
alias kvcerts="kubectl view-certificates"
alias kvcertp="kubectl view-certificate -o jsonpath='{.spec.tls[0].hosts}'"
alias kvcertp2="kubectl view-certificate -o jsonpath='{.spec.tls[0].secretName}'"
alias kvcertp3="kubectl view-certificate -o jsonpath='{.spec.tls[0].hosts}' | sed 's/,/ /g' | xargs -I {} openssl s_client -showcerts -servername {} -connect {}:443 </dev/null 2>/dev/null | openssl x509 -outform PEM | openssl x509 -noout -text"
alias kvcertp4="kubectl view-certificate -o jsonpath='{.spec.tls[0].hosts}' | sed 's/,/ /g' | xargs -I {} openssl s_client -showcerts -servername {} -connect {}:443 </dev/null 2>/dev/null | openssl x509 -outform PEM | openssl x509 -noout -text | grep -A 1 'Subject Alternative Name' | tail -n 1 | sed 's/ //g' | sed 's/DNS://g' | sed 's/,/ /g'"

alias kget="kubectl get"
alias kgeta="kubectl get all"
alias kgetp="kubectl get pods"
alias kgetd="kubectl get deployments"
alias kgetds="kubectl get daemonsets"
alias kgetj="kubectl get jobs"
alias kgetc="kubectl get cronjobs"
alias kgeti="kubectl get ingress"
alias kgetcm="kubectl get configmaps"
alias kgets="kubectl get secrets"
alias kgetsa="kubectl get serviceaccounts"
alias kgetpv="kubectl get persistentvolumes"
alias kgetpvc="kubectl get persistentvolumeclaims"
alias kgetns="kubectl get namespaces"
alias kgetno="kubectl get nodes"
alias kgetrs="kubectl get replicasets"
alias kgetsc="kubectl get storageclasses"
alias kgethpa="kubectl get horizontalpodautoscalers"

alias kdesc="kubectl describe"
alias kdescp="kubectl describe pods"
alias kdescd="kubectl describe deployments"
alias kdescds="kubectl describe daemonsets"

alias kdel="kubectl delete"
alias kdelall="kubectl delete all --all"

alias klogs="kubectl logs"
alias klogsp="kubectl logs -f"
alias klogspc="kubectl logs -f --previous"
alias klogspod="kubectl logs -f -l app=pod"
alias klogspodc="kubectl logs -f -l app=pod --previous"
alias klogspod2="kubectl logs -f -l app=pod2"

alias kexec="kubectl exec"
alias kexeci="kubectl exec -it"
alias kexecp="kubectl exec -it -l app=pod"
alias kexecp2="kubectl exec -it -l app=pod2"

alias kport="kubectl port-forward"

kenc() {
	# shellcheck disable=SC2039
	echo -n "$@" | base64
}

kdec() {
	echo "$@" | base64 -D
}

# create new k3d test cluster
ktc() {
	k3d create --name test --wait 0
	export KUBECONFIG
	KUBECONFIG="$(k3d get-kubeconfig --name='test')"
}

# create new k3d test cluster and set up helm on it
ktch() {
	ktc
	kubectl create serviceaccount --namespace kube-system tiller
	kubectl create clusterrolebinding tiller-cluster-admin --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
	helm init --service-account tiller --upgrade --wait
}
