#!/bin/bash -e

ffprofile=dp1jio86.dev-edition-default
ffpath="/Users/andrew/Library/Application Support/Firefox/Profiles/$ffprofile/extensions"
mkdir -p "$ffpath"

# HTTPS Everywhere
id=https-everywhere@eff.org
curl -sSfLO https://www.eff.org/files/https-everywhere-latest.xpi
mkdir -p "$ffpath"/$id/
unzip https-everywhere-latest.xpi -d "$ffpath"/$id/

# Adblock Edge
id={fe272bd1-5f76-4ea4-8501-a05d35d823fc}
curl -sSfLO https://bitbucket.org/adstomper/adblockedge/downloads/adblockedge-2.1.8.xpi
mkdir -p "$ffpath"/$id/
unzip adblockedge-2.1.8.xpi -d "$ffpath"/$id/

# Random Agent Spoofer
id=id1-AVgCeF1zoVzMjA@jetpack
curl -sSfLO https://github.com/dillbyrne/random-agent-spoofer/releases/download/0.9.5.1/random-agent-spoofer.xpi
cp random-agent-spoofer.xpi "$id".xpi

# uBlock
id={2b10c1c8-a11f-4bad-fe9c-1c11e82cac42}
curl -sSfLO https://github.com/gorhill/uBlock/releases/download/0.8.8.2-dev.0/uBlock.firefox.xpi
cp random-agent-spoofer.xpi "$id".xpi
