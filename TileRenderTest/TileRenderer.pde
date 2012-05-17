/**
 A very simple tile renderer
 Outputs tiles that can be assembled using TileAssembler.
 Might change to do assembly automatically, though that would
 have higher memory usage requirements.
 
 Inspiration from Cinder::TileRender and unlekkerlib
 Assumes that you aren't calling camera() yourself
 
 Example usage:
 TileRenderer renderer( 8, "path/to/filebase-" ); // 8x size
 while( renderer.next() )
 {
 renderScene(); // draw your content
 }
 
 */

class TileRenderer
{
  String fileBase;
  int scaleFactor;
  int x, y;
  float fov = 60.0f;
  float mod = 1.0f / 10.0f;
  float cameraZ;
  PImage output;

  TileRenderer(int aScaleFactor, String aFileBase)
  {
    this( aScaleFactor, aFileBase, false );
  }

  /**
   Construct a TileRenderer
   @param aScaleFactor the scale of the render, as in '4 times as big'
   @param aFileBase the base file name (and path) for saving
   @param aCompositeOutput true if we should output the composite image, false if you want tiles
   Setting to false may allow you to export larger images for stitching later.
   */
  TileRenderer(int aScaleFactor, String aFileBase, boolean aCompositeOutput )
  {
    fileBase = aFileBase;
    scaleFactor = aScaleFactor;
    x = -1;
    y = 0;
    cameraZ = (height / 2.0f) / tan(PI * fov / 360.0f);
    if (aCompositeOutput)
    {
      // output = createImage( width * scaleFactor, height * scaleFactor, RGB );
    }
  }

  /**
   Set the display matrices for rendering the next tile
   */
  boolean next()
  {
    // save the previous region
    if ( x != -1 )
    { 
      storePixels();
    }
    // move to the next tile
    incrementTile();
    if ( y < scaleFactor )
    { // not done yet
      setFrustum();
      println( "Setting frustum for " + (y * scaleFactor + x + 1) + " of " + (scaleFactor * scaleFactor) );
      return true;
    }
    else
    { // all finished
      unsetFrustum();
      return false;
    }
  }

  private void incrementTile()
  {
    if ( ++x >= scaleFactor )
    {
      x = 0;
      ++y;
    }
  }

  private void setFrustum()
  {
    camera(  width / 2.0f, height / 2.0f, cameraZ, 
    width / 2.0f, height / 2.0f, 0, 0, 1, 0);

    frustum(width * (x / (float)scaleFactor - 0.5f) * mod, 
    width * ((x + 1) / (float)scaleFactor - 0.5f) * mod, 
    height * (y / (float)scaleFactor - 0.5f) * mod, 
    height * ((y + 1) / (float)scaleFactor - 0.5f) * mod, 
    cameraZ*mod, 10000);
  }

  void unsetFrustum()
  {
    camera(width / 2.0f, height / 2.0f, cameraZ, 
    width / 2.0f, height / 2.0f, 0, 0, 1, 0);

    frustum(-(width / 2) * mod, (width / 2) * mod, 
    -(height / 2) * mod, (height / 2) * mod, 
    cameraZ * mod, 10000);
  }

  private void storePixels()
  {
    if ( output != null )
    { // copy pixels from screen to output
    }
    else
    { 
      save(fileBase + x + "-" + (scaleFactor - (y + 1)) + ".png");
    }
  }
}

