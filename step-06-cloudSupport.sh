#!/bin/sh
# ==============================================================================================================
# AWS: Install utilities to support connecting to AWS
# ==============================================================================================================
AWS_SUPPORT=(
	awscli
    aws-console
    serverless
)

echo "Installing AWS support packages..."

for val in "${AWS_SUPPORT[@]}"; do
    brew install $val || simpleError "$val"
done

echo "AWS support installed"

# ==============================================================================================================
# GCP: Install utilities to support connecting to GCP
# ==============================================================================================================

GCP_SUPPORT=(
	google-cloud-sdk
)

echo "GCP support packages..."

for val in "${GCP_SUPPORT[@]}"; do
    brew install --cask $val || simpleError "$val"
done

echo "GCP support installed"
