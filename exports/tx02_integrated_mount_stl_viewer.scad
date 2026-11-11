// Viewer-only wrapper for the exported printable STL.
// Open this file in OpenSCAD and press F5 (Preview) or F6 (Render).
// The imported STL is the actual print geometry; this wrapper does not modify it.

color("#3f9bd8")
  import("tx02_integrated_mount.stl", convexity=10);
