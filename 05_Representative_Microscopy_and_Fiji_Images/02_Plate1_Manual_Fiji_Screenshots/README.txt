MCF7 Image Informatics presentation assets

FINAL PROJECT TITLE: Spatial Reorganization of Actin and Microtubules and Its Association with Nuclear Morphology in Drug-Treated MCF-7 Cells

Plate 1 source: Week1_22123 / B02 / site_1. All TIFFs are original channels; Figure01 is the uploaded three-channel composite, and its PNG is display-only.

IMPORTANT: The uploaded Fiji screenshot shows w1B3A2C1A3..., which the BBBC021 metadata identifies as Week1_22161 / B02 / site_1 (Plate 3). DO NOT use it as Plate 1 segmentation evidence.

The Otsu QC image is an automatically generated illustrative threshold preview, not a validated Fiji measurement or an experimental result. Do not claim manual segmentation has been completed.

All scale, threshold, particle-size and watershed settings must be validated on real images and applied consistently to comparable fields.

CHECKPOINT 2 (Oct 24, 2026): Added Fiji screenshot 'Plate1_B02_S1_binary_mask_before_watershed_Fiji_screenshot.png', showing the user's pre-watershed 8-bit black-background/white-nuclei binary mask (UI caption "DMSO_B02_S1_Mask_BeforeWatershed.tif"). Screenshot only, not the original pixel-faithful binary-mask TIFF. Adjacent nuclei remain touching; screenshot is not a validated final segmentation. Request actual after-watershed mask or screenshot for comparison, and original mask TIFF if quantitative verification is needed.

CHECKPOINT 3 (Oct 24, 2026): Added the user's Fiji numbered Analyze Particles outlines screenshot and the Fiji Summary screenshot. The summary row explicitly names DMSO_B02_S1_Mask_BeforeWatershed.tif: Count=238, Total Area=226306 px², Average Size=950.866 px², Percent Area=17.266, Mean=255 (8-bit binary white-object intensity), Perimeter=114.003, Circularity=0.847, Solidity=0.949, Feret=39.601 px. These are preliminary object statistics, NOT validated after-watershed single-nucleus statistics. Border-truncated nuclei, small artifacts, and merged neighbors require QC. Do not display 238 as a confirmed number of cells. There is no supplied final binary mask TIFF or per-object results CSV yet. Screenshot-only artifacts are for process documentation; include numerical statistics in presentation only after re-analysis of the verified post-watershed mask. No physical pixel scale has been established, so use pixel units only.

CHECKPOINT 4 (user clarification): The user explicitly confirmed their reported mask and 238-object Analysis Particles Results were measured AFTER Watershed, despite source image name including BeforeWatershed. Retain as preliminary, unvalidated until boundary-touching objects, debris, and merged/split nuclei reviewed. 24 bounding boxes touch image border; 15 objects <100 px².

Checkpoint 5: Added original 16-bit tubulin-channel Fiji screenshot (Plate1/B02/site1). Screenshot is a visualization, not a segmentation or quantitative measurement. Do not interpret as tubulin filament segmentation. For next steps, transfer nuclear ROIs from the corresponding DAPI channel and test narrow perinuclear band measurement with careful assessment of neighbor overlap and background.

Checkpoint 6 (2026-10-24): Screenshot Fiji_Tubulin_DMSO_B02_S1_nuclear_ROI_overlay_preQC.png displays DAPI-derived ROI outlines aligned to raw Tubulin channel. ROI labels 215-428 strongly suggest repeated appended ROIs in ROI Manager; screenshot is for preliminary methods documentation only, not for finalized counts. Clean ROI Manager and re-export verified, edge-excluded ROI zip before perinuclear measurements.

Checkpoint 7 (2026-10-24): added Fiji screenshot showing the watershed-processed DMSO Plate1 B02 site1 nuclear binary image with 214 numbered edge-excluded ROI detections. Labels 1..214 are ROI indices, not validated biological nuclei. Some small detections need QC. Underlying image window retains filename BeforeWatershed, but user confirms processing included Watershed.
