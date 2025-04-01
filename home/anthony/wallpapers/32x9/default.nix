# Find new wallpapers at https://www.reddit.com/r/WidescreenWallpaper/?f=flair_name%3A%2232%3A9%22
let
  mkWallpaper = path: path;
in
{
  space-colonization = mkWallpaper ./space_colonization-wallpaper-5120x1440.jpg;
  fantasy-forest-floor = mkWallpaper ./fantasy-forest-floor.png;
  misty-forest = mkWallpaper ./misty-forest.jpg;
}
