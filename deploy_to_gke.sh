#!/usr/bin/env bash
SHA=$(git rev-parse main)
kubectl set image deployments/wrapper wrapper=aleczheng/tool-wrapper:$SHA


