/**
Compute a gaussian kernel and save it as an image
Ensures the outer edge is pure black
*/

int kernelSize = 1024;
PImage kernel;

void setup()
{
  size( 512, 512 );
  kernel = createImage( kernelSize, kernelSize, PGraphics.ARGB );
  int kCenter = kernelSize / 2;
  float maxDist = kCenter;  // radius is center location
  float maxGauss = gaussian( 0, 1.0 );
  kernel.loadPixels();
  for ( int x = 0; x != kernelSize; x++ )
  {
    for ( int y = 0; y != kernelSize; y++ )
    {  // scale by some distance where we're close enough to zero
      float loc = 3.325 * dist( kCenter, kCenter, x, y ) / maxDist;
      float gauss = gaussian( loc, 1.0 );
      kernel.pixels[ y * kernelSize + x ] = color( 255 * gauss / maxGauss );
    }
  }
  kernel.updatePixels();
  kernel.save( "kernel.png" );
  noLoop();
}

void draw()
{
  background( 0 );
  image( kernel, 0, 0, width, height );
}

float gaussian( float loc, float variance )
{ 
  variance *= variance;
  float a = loc * loc / ( 2.0 * variance );
  float b = exp( -a );
  float c = sqrt( PI * 2.0 * variance );
  return b / c;
}
