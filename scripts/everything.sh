#! /bin/bash

echo '== Dota2 guides =='
lua pages/dotaalttab.lua

echo '== Dota 1 guides =='
lua pages/playdota_main.lua
lua pages/playdota.lua

echo '== Dota2 ingame builds =='
lua pages/recommended_items.lua
cd ../results
zip -r ii itembuilds
mv ii.zip dota2alttab/itembuilds.zip
cd ../lua
