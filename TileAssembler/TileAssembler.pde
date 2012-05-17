/**
Assembles tiles into a single image.
Enter the correct file base and number of tiles
Will stitch images with the following naming convention:
fileBase$X-$Y.png

Don't forget to increase max memory
*/

String fileBase = "keptile-";
String separator = "-";
String ext = ".png";
int xTiles = 8;
int yTiles = 8;

void setup()
{
  size(400, 400, P2D);
  String folder = selectFolder("where do tiles reside?");
  if( folder != null ){ folder = folder + "/"; }
  else{ exit(); }
  PImage sampleTile = loadImage( folder + fileBase + "0" + separator + "0" + ext );
  int tileWidth = sampleTile.width;
  int tileHeight = sampleTile.height;
  PGraphics output = createGraphics( tileWidth * xTiles, tileHeight * yTiles, P2D );
  for( int x = 0; x < xTiles; ++x )
  {
    for( int y = 0; y < yTiles; ++y )
    {
      PImage tile = loadImage( folder + fileBase + str(x) + separator + str(y) + ext );
      output.image( tile, x * tileWidth, y * tileHeight, tileWidth, tileHeight );
      println("Added tile " + x + ", " + y );
    }
  }
  println("Saving full image");
  output.save( "assembled/" + fileBase + "merged" + ext );
  println("All done");
  exit();
}
