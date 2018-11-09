#!/usr/bin/env bash

export CA_CERT_URL=https://s3.us-east-2.amazonaws.com/dg-training-concourse/training-bosh.pem
export BOSH_CLIENT_SECRET=$(bosh int ~/creds.yml --path /admin_password)
export BOSH_DEPLOYMENT=${GITHUB_USERNAME}-nginx
export BOSH_DIRECTOR='https://10.4.1.4:25555'
export BOSH_ENVIRONMENT='training'
export BOSH_CLIENT=$(bosh int ~/creds.yml --path /username)

cd source-code/nginx_release

curl -LO ${CA_CERT_URL}
bosh alias-env ${BOSH_ENVIRONMENT} --ca-cert training-bosh.pem -e ${BOSH_DIRECTOR}
bosh login

bosh deploy --non-interactive manifests/manifest.yml
