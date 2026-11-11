# CAD

## 文件

- `vesa_mount.scad`：早期 VESA 仿屏幕上沿概念支架，保留作为结构参考，不是当前 TX02 一体承托臂正式模型。
- `tx02_integrated_mount.scad`：当前正式参数模型，`120 × 120 × 6 mm` VESA 板、真实 Ø4.5 mm 通孔，以及一体立柱、承力腹板、承托片和挡肩。
- `pole_1qtr_head.scad`：早期 1/4 英寸圆杆头部概念，后续需要改成与承托片匹配的接口。

当前 TX02 VESA / 承托臂一体件参数和三维关系先记录在 [`docs/tx02-vesa-cradle-r2.html`](../docs/tx02-vesa-cradle-r2.html)。VESA 转接板也是本项目自行打印的零件，与立柱和承托臂在同一实体内。三维模型按 1S 的顶部横条、前卡扣、后弧形压脚和弹簧铰链绘制原装夹具。每个挂灯型号只需实测原装底座左右宽度和卡扣前后夹持深度，再把承托片 `63 × 30 × 14 mm` 和接口固化为新的 OpenSCAD 参数。

## 使用方式

1. 先完成 `docs/measurement-sheet.csv`。
2. 打开 `tx02_integrated_mount.scad`。
3. 修改文件顶部的 `USER PARAMETERS`。
4. 在 OpenSCAD 中按 `F5` 预览，按 `F6` 渲染。
5. 导出 STL 后先打印局部试验件。

也可以直接使用已生成的 [`exports/tx02_integrated_mount.stl`](../exports/tx02_integrated_mount.stl)。先打印 [`exports/tx02_fit_test.stl`](../exports/tx02_fit_test.stl) 验证 55 mm 挡肩内间距。

## 通用挂灯适配参数

VESA 侧固定支持 75 / 100 双孔距，不逐台测量显示器。每个挂灯型号只需记录：

- 原装底座左右宽度 `base_width`
- 卡扣前后夹持深度 `clamp_depth`
- 有效夹持高度 `contact_height`，仅在明显小于 10 mm 时记录

## 默认值不是成品尺寸

默认值只是用于验证结构的起点。不同挂灯底座的宽度和卡扣深度仍需用试片验证。

## 打印方向

VESA 支架应让 VESA 板平放，立柱和桥接向上生长。顶部假屏幕边的前后厚度方向要与打印平台平行，避免夹紧力把层间粘接撕开。

圆杆头部应让 1/4 英寸螺纹嵌件孔朝向打印平台上方，安装嵌件后再夹紧。

