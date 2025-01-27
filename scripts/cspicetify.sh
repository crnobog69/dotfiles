#!/bin/bash

cd ~/.config/spicetify/Themes

git clone --depth=1 https://github.com/spicetify/spicetify-themes.git

cd spicetify-themes

# Copy all files and directories recursively from current directory
# to the Spicetify themes folder
cp -r * ~/.config/spicetify/Themes

# Go to the Spicetify themes folder
cd ~/.config/spicetify/Themes

# Delete everything except the 'text' and 'Marketplace' folders
find . -maxdepth 1 ! -name 'text' ! -name 'Marketplace' ! -name '.' -exec rm -rf {} +

# Clean up the cloned repository
rm -rf ~/.config/spicetify/Themes/spicetify-themes

cd ~/.config/spicetify/Themes

spicetify config current_theme text

spicetify config color_scheme CatppuccinMocha

cd ~/.config/spicetify/Extensions

curl -O https://raw.githubusercontent.com/rxri/spicetify-extensions/main/adblock/adblock.js

spicetify config extensions adblock.js

# Apply the changes
spicetify apply