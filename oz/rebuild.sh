#!/usr/bin/env bash
echo 'set cwd..'
cd "$(dirname "$0")"
echo `pwd`
echo 'cleaning up contracts..'
rm -rf contracts
echo 'creating blank contracts directory...'
mkdir contracts
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
npx truffle-flattener contracts/CORE.sol >> oz/contracts/CORE.sol
echo 'flattening CoreVault...'
npx truffle-flattener contracts/CoreVault.sol >> oz/contracts/CoreVault.sol
echo 'flattening FeeApprover...'
npx truffle-flattener contracts/FeeApprover.sol >> oz/contracts/FeeApprover.sol
echo 'Removing contracts without logs...'
rm -rf contracts
echo 'Putting original contracts back...'
mv contracts.orig contracts
echo 'done!'
