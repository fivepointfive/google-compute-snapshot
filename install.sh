#!/bin/bash

echo -e "\e[94m _______  _______    _____"
echo -e "\e[94m(_______)(_______)  (____ \\"
echo -e "\e[94m ______   ______     _   \ \ ____ ____  ____ ____ ____  ___"
echo -e "\e[94m(_____ \ (_____ \   | |   | / _  ) _  |/ ___) _  ) _  )/___)"
echo -e "\e[94m _____) ) _____) )  | |__/ ( (/ ( ( | | |  ( (/ ( (/ /|___ |"
echo -e "\e[94m(______(_|______/   |_____/ \____)_|| |_|   \____)____|___/"
echo -e "\e[94m                                (_____|"
echo -e "\e[90mCopyright (C) 5.5 Degrees"
echo -e "\e[90mhttp://5andhalf.com/"
echo -e "\e[90m--------------------------"
echo -e "\e[97mInstalling auto gcloud compute snapshot tool\e[90m"

# set -x #echo commands

# Download main script
wget -P /opt/google-compute-snapshot/  https://raw.githubusercontent.com/fivepointfive/google-compute-snapshot/master/gcloud-snapshot.sh -q --show-progress

# Make script executeable
chmod +x /opt/google-compute-snapshot/gcloud-snapshot.sh

# Test Run
echo -e "\n\n\e[97mRunnig test. Please wait"
echo -e "\e[90m--------------------------"
sh /opt/google-compute-snapshot/gcloud-snapshot.sh
echo -e "\e[90m--------------------------"
echo -e "\e[97mTest finished\n"

# Validate by customer
echo -e "\e[93m\e[1mDid a new snapshot get created?\e[21m\e[39m"
read -p "Y(Yes) or N(No):" -n 1 -r
# Finalize
echo -e "\n"
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
  echo -e "\n\n\e[41m\e[93mSorry! please try to run the script manually and fix prompted error!\e[0m"
  echo -e "\e[31mMost of the time you just need to run \e[4mapt update && apt upgrade\e[0m"
  [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
fi

echo -e "\e[97mInstalling Cron"
crontab -l | { cat; echo "0 16 * * * /opt/google-compute-snapshot/gcloud-snapshot.sh -d 30 >/dev/null 2>&1"; } | crontab -
echo -e "\e[92m\e[1mAll done enjoy :)\e[49m"
