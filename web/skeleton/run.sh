#!/bin/bash
set -eux

npm run dist
node server.js
