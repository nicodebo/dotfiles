#!/usr/bin/env bash
sed -i "s@currentdirectory@$(pwd)@g" docker-compose.yml || exit 1
