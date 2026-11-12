# Xiaomi 1S Standalone VESA Light Mount

[![License: CERN-OHL-S-2.0](https://img.shields.io/badge/License-CERN--OHL--S--2.0-blue.svg)](LICENSE)

面向小米米家屏幕挂灯 1S（MJGJD02YL）的独立 VESA 挂灯支架。该设计让原装挂灯底座直接夹住一块模拟显示器上沿的承托片，从而把挂灯安装到独立显示器支架的 VESA 75/100 接口上。

![Current standalone VESA light mount](assets/current-mount.png)

## Overview

本项目保留小米 1S 的原装磁吸底座、供电触点和调节结构，仅重新设计承载界面。打印件同时提供 VESA 安装板和一体承托臂，不修改灯具电路。

项目采用参数化 OpenSCAD 建模，并提供完整件、试片、交互 3D 预览和安装说明。

## Features

- 支持标准 VESA `75 × 75 mm` 和 `100 × 100 mm` 孔距
- VESA 板与承托臂一次打印成形
- 保留原装小米 1S 磁吸供电和调角结构
- 两侧挡肩限制底座横向移动
- 可单独打印承托片试片，降低尺寸验证成本
- 参数化 CAD，可按不同挂灯底座调整宽度和夹持深度

## Compatibility

| 项目 | 支持范围 |
|---|---|
| 挂灯 | 小米米家屏幕挂灯 1S，型号 `MJGJD02YL` |
| 原装底座 | 必须保留，不拆改供电和磁吸结构 |
| VESA | 75 × 75 mm / 100 × 100 mm |
| 安装方式 | 独立显示器支架或空闲 VESA 臂 |
| 承托片宽度 | `63 mm` |
| 承托片夹持深度 | `30 mm` |
| 承托片厚度 | `14 mm` |
| 挡肩内间距 | `55 mm` |

该支架面向独立挂灯工位设计，主安装路径不是把转接板夹在显示器与 VESA 臂之间。

## Specifications

| 参数 | 数值 |
|---|---:|
| VESA 板 | `120 × 120 × 6 mm` |
| VESA 通孔 | `Ø4.5 mm` |
| 整体包围盒 | `120 × 173.5 × 30 mm` |
| STL 体积 | 约 `192.25 cm³` |
| 网格 | 2156 triangles，manifold |
| 承托片 | `63 × 30 × 14 mm` |
| 防横移挡肩 | `4 × 12 mm` |

## Hardware

独立安装时，支架 VESA 头的 M4 螺丝穿过 VESA 臂板和打印转接板，在转接板背面用锁紧螺母固定。

| 零件 | 数量 | 说明 |
|---|---:|---|
| M4 螺丝 | 4 | 长度按 VESA 臂板、转接板、垫圈和螺母组合确定 |
| M4 平垫圈 | 8 | 每个通孔两侧各一片 |
| M4 尼龙锁紧螺母 | 4 | 安装在转接板背面 |
| USB-C 线夹 | 2–3 | 固定线缆并保留活动余量 |

完整清单见 [hardware/bom.md](hardware/bom.md)。

## Quick Start

1. 打印局部试片 [tx02_fit_test.stl](exports/tx02_fit_test.stl)。
2. 测量原装底座左右宽度和卡扣前后夹持深度。
3. 根据实测值修改 [tx02_integrated_mount.scad](cad/tx02_integrated_mount.scad) 顶部参数。
4. 在 OpenSCAD 中按 `F5` 检查预览，按 `F6` 完成渲染。
5. 确认试片夹持稳定后，再打印完整件 [tx02_integrated_mount.stl](exports/tx02_integrated_mount.stl)。

尺寸填写说明见 [docs/measurement-sheet.md](docs/measurement-sheet.md)。

## Build

需要 OpenSCAD 2026.10.11 或兼容版本。重新生成 STL 和几何摘要：

```sh
make cad
```

检查项目结构：

```sh
make check
```

交互 3D 装配图：[docs/tx02-vesa-cradle-r2.html](docs/tx02-vesa-cradle-r2.html)

### Opening the Model in OpenSCAD

OpenSCAD 不能像普通 CAD 软件那样直接打开 STL 作为可编辑设计文件。直接在 OpenSCAD 中打开 STL 会解析失败或显示空场景。

可使用以下任一方式：

1. 打开 [cad/tx02_integrated_mount.scad](cad/tx02_integrated_mount.scad)，然后按 `F5` 预览或 `F6` 渲染。
2. 打开 [exports/tx02_integrated_mount_stl_viewer.scad](exports/tx02_integrated_mount_stl_viewer.scad)。`tx02_integrated_mount.stl` 必须与查看器位于同一目录。
3. 新建 `.scad` 文件并导入 STL：

```scad
import("tx02_integrated_mount.stl", convexity=10);
```

如果模型已加载但界面中看不到，按 `Shift + Command + V` 执行 View All。STL 文件更适合用切片软件或独立 STL 查看器打开。

## Printing

- 试片建议使用 PETG，便于低成本验证装配尺寸。
- 正式承力件建议使用 PAHT-CF、PET-CF 或 MJF PA12。
- 普通 PLA 不适合长期承受灯条自重和夹紧载荷。
- 打印方向应使 VESA 板平放，立柱和承托臂向上生长。
- 完整打印前必须先验证承托片宽度、深度和挡肩间隙。

## Assembly

安装步骤见 [docs/installation.md](docs/installation.md)。VESA 通孔两侧均需使用平垫圈，背面使用 M4 尼龙锁紧螺母。

## Design Files

| 文件 | 用途 |
|---|---|
| [cad/tx02_integrated_mount.scad](cad/tx02_integrated_mount.scad) | 当前参数化主模型 |
| [exports/tx02_integrated_mount.stl](exports/tx02_integrated_mount.stl) | 完整打印件 |
| [exports/tx02_fit_test.stl](exports/tx02_fit_test.stl) | 承托片局部试片 |
| [exports/tx02_integrated_mount_stl_viewer.scad](exports/tx02_integrated_mount_stl_viewer.scad) | STL 查看包装文件 |
| [cad/vesa_mount.scad](cad/vesa_mount.scad) | 早期 VESA 概念模型 |
| [cad/pole_1qtr_head.scad](cad/pole_1qtr_head.scad) | 圆杆方案头部模型 |

## Documentation

- [Design brief](docs/design-brief.md)
- [Installation guide](docs/installation.md)
- [Measurement sheet](docs/measurement-sheet.md)
- [BOM](hardware/bom.md)
- [Sources and references](docs/sources.md)

## Limitations and Safety

- 当前尺寸是基于官方资料、实物照片和社区模型推算的原型参数，正式打印前必须通过试片验证。
- 本项目未进行正式结构认证，不适合作为未经检验的安全承力部件使用。
- 应定期检查 VESA 螺丝、垫圈、锁紧螺母和原装夹具是否松动。
- 灯条和底座应完整保留；不要绕过原装供电结构直接给灯条接线。

## Contributing

欢迎提交适配尺寸、兼容性报告、结构改进和文档修正。提交前请：

1. 说明挂灯型号和原装底座尺寸。
2. 附上试片装配结果或清晰照片。
3. 保持改动聚焦，不混入无关格式化或生成文件。
4. 运行 `make check`；涉及 CAD 的改动同时运行 `make cad`。

## Sources

产品规格、官方手册和社区参考的链接与使用边界见 [docs/sources.md](docs/sources.md)。

## License

本项目采用 [CERN Open Hardware Licence Version 2 - Strongly Reciprocal](LICENSE)（`CERN-OHL-S-2.0`）开源。

你可以在许可证条款下使用、研究、修改、制造和分发本设计及基于本设计制造的产品；分发修改版本时需要继续遵守 CERN-OHL-S-2.0 的 reciprocal 条款。

## Disclaimer

小米、米家及相关名称和商标归其权利人所有。本项目是独立的社区硬件设计，与小米公司无隶属、授权或背书关系。
