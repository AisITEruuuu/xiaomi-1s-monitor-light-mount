# Printable exports

Generated from `cad/tx02_integrated_mount.scad` with OpenSCAD 2026.10.11.

## Files

- `tx02_integrated_mount.stl` - complete one-piece VESA adapter.
- `tx02_fit_test.stl` - 63 x 30 x 14 mm clamp-pad coupon with the 55 mm guide gap.
- `tx02_integrated_mount_preview.png` - quick OpenSCAD preview.
- `tx02_fit_test_preview.png` - quick OpenSCAD preview of the fit coupon.
- `tx02_integrated_mount_summary.json` - exported geometry summary.

## Verified geometry

- Bounding box: `120.0 x 173.5 x 30.0 mm`.
- VESA plate: `120 x 120 x 6 mm`.
- VESA patterns: 75 mm and 100 mm, `Ø4.5 mm` through holes.
- OpenSCAD result: manifold, `NoError`, 2,156 facets.
- STL volume: about `192.25 cm³`.

## Print order

1. Print `tx02_fit_test.stl` in PETG.
2. Check that the original Xiaomi base enters the 55 mm guide gap and the front/rear clamps still engage.
3. Measure the actual mount-head VESA spacing and screw depth.
4. Print the complete adapter in PAHT-CF, PET-CF or MJF PA12.

The default model has plain through holes and is intended for M4 screws with washers. Set `vesa_countersink_side` to `-1` or `1` before export if the final screw direction requires countersinks.
