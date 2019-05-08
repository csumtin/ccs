#!/bin/bash
set -eux

npm install
npm run dist
node server.js
