#!/bin/sh
NAMESPACE="vault"
POD="hashicorp-vault-0"
kubectl exec -n $NAMESPACE $POD -- vault operator unseal "CbwR1oMtmSZkWRXpmo1NsUtfISJy1aJXV+2Iksz5x+3v"
kubectl exec -n $NAMESPACE $POD -- vault operator unseal "NP7DpyqcIwucsxKt4qeGEZWh1OMn2hh2LUcEnqHvKP5F"
kubectl exec -n $NAMESPACE $POD -- vault operator unseal "bz1ScZHW+uMYiyWDwdJfeevqEpfGfsg0xbOJmWto+7fe"

kubectl exec -n $NAMESPACE -i -t $POD -- sh -c '
  export VAULT_TOKEN="hvs.fLVtEZ4pscvuqFKX0hbx2cSC"
  vault write auth/kubernetes/config \
    token_reviewer_jwt="$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)" \
    kubernetes_host="https://${KUBERNETES_PORT_443_TCP_ADDR}:443" \
    kubernetes_ca_cert=@/var/run/secrets/kubernetes.io/serviceaccount/ca.crt
'