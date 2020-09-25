#!/usr/bin/env bash
echo 'set cwd..'
cd "$(dirname "$0")"
echo `pwd`
echo 'cleaning up flattened_contracts..'
rm -rf flattened_contracts
echo 'creating blank flattened_contracts directory...'
mkdir flattened_contracts
echo 'moving to contract build root...'
cd ..
echo 'Cleaning up compiler cache...'
rm -rf cache
rm -rf artifacts
rm -rf contracts.orig
echo 'Making a backup of the contracts...'
cp -R contracts contracts.orig
echo 'Removing log lines...'
yarn run buidler remove-logs
echo 'flattening CORE...'
npx truffle-flattener contracts/CORE.sol >> oz/flattened_contracts/CORE.sol
echo 'flattening CoreVault...'
npx truffle-flattener contracts/CoreVault.sol >> oz/flattened_contracts/CoreVault.sol
echo 'flattening FeeApprover...'
npx truffle-flattener contracts/FeeApprover.sol >> oz/flattened_contracts/FeeApprover.sol
echo 'Removing contracts without logs...'
rm -rf contracts
echo 'Putting original contracts back...'
mv contracts.orig contracts
echo 'done!'
