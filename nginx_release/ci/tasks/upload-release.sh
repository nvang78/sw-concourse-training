#!/usr/bin/env bash
set -x
#For the purpose of this tutorial, there are credentials being commited here.
#This is on purpose and will be covered in the security tutorial.
#The director is expected to be secured and only locally available for this lab session
#But this does not demonostrate a best practice

export CA_CERT_URL=https://unreal-snw.s3.amazonaws.com/training-bosh.pem
export BOSH_CLIENT_SECRET=$(bosh int ~/creds.yml --path /admin_password)
export BOSH_DEPLOYMENT=${GITHUB_USERNAME}-nginx
export BOSH_DIRECTOR='https://10.4.1.4:25555'
export BOSH_ENVIRONMENT='https://10.4.1.4:25555'
export BOSH_CLIENT=$(bosh int ~/creds.yml --path /username)

#export CA_CERT_URL=<S3_object_URL>
#export BOSH_CLIENT_SECRET=<bosh password>
#export BOSH_DEPLOYMENT=<deployment name>
#export BOSH_DIRECTOR=<bosh director url>
#export BOSH_ENVIRONMENT=<bosh director ip>
#export BOSH_CLIENT=<bosh user>

cd source-code/nginx_release

curl -LO ${CA_CERT_URL}
bosh alias-env ${BOSH_ENVIRONMENT} --ca-cert training-bosh.pem -e ${BOSH_DIRECTOR}

bosh login

bosh upload-release releases/release.gz
