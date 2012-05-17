
ArrayList<PVector> vertices;

void setup()
{
  size( 800, 800, P3D );
  smooth();

  vertices = new ArrayList<PVector>();
  for ( int i = 0; i < 1000; ++i )
  {
    float theta = random(TWO_PI);
    float distance = random(width/2);
    float x = width/2 + cos(theta) * distance;
    float y = height/2 + sin(theta) * distance;
    vertices.add( new PVector( x, y ) );
  }
}

void draw()
{
  render();
}

void render()
{
  background(0);
  beginShape(TRIANGLES);
  noFill();
  stroke(255);
  strokeWeight(2);
  for ( PVector p : vertices )
  {
    vertex( p.x, p.y );
  }
  endShape();
}

void keyPressed()
{
  if ( key == 's' )
  {
    TileRenderer r = new TileRenderer(8, "tiles/mess-");
    while ( r.next () )
    {
      render();
    }
    render();
    save("tiles/preview.png");
  }
}

