.PHONY: check list preview cad

REQUIRED := \
	README.md \
	docs/design-brief.md \
	docs/measurement-sheet.md \
	docs/measurement-sheet.csv \
	docs/installation.md \
	docs/sources.md \
	docs/tx02-vesa-cradle.html \
	docs/tx02-vesa-cradle-r2.html \
	hardware/bom.md \
	cad/README.md \
	cad/tx02_integrated_mount.scad \
	cad/vesa_mount.scad \
	cad/pole_1qtr_head.scad \
	exports/README.md \
	exports/tx02_integrated_mount.stl \
	exports/tx02_fit_test.stl \
	assets/concept.png \
	assets/concept.svg

check:
	@for f in $(REQUIRED); do test -s "$$f" || { echo "missing: $$f"; exit 1; }; done
	@grep -q "monitor_top_to_vesa_center" cad/vesa_mount.scad
	@grep -q "original Xiaomi magnetic/power base" cad/vesa_mount.scad
	@grep -q "explode-view" docs/tx02-vesa-cradle-r2.html
	@grep -q "Original 1S clamp" docs/tx02-vesa-cradle-r2.html
	@grep -q "VESA 位于立柱右侧" docs/tx02-vesa-cradle-r2.html
	@grep -q "承托片落在左右受力面之间" docs/tx02-vesa-cradle-r2.html
	@grep -q "vesa_plate_width = 120" cad/tx02_integrated_mount.scad
	@grep -q "vesa_hole_diameter = 4.5" cad/tx02_integrated_mount.scad
	@grep -q "guide_inner_gap = 55" cad/tx02_integrated_mount.scad
	@echo "project structure ok"

cad:
	@mkdir -p exports
	@openscad --export-format binstl --summary all --summary-file exports/tx02_integrated_mount_summary.json -o exports/tx02_integrated_mount.stl cad/tx02_integrated_mount.scad
	@openscad --export-format binstl --summary all --summary-file exports/tx02_fit_test_summary.json -D 'part="fit_test"' -o exports/tx02_fit_test.stl cad/tx02_integrated_mount.scad

list:
	@find . -maxdepth 3 -type f | sort

preview:
	@open docs/tx02-vesa-cradle.html

