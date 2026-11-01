MCF-7 / BBBC021 -- MANUAL IMAGE VALIDATION CHECKPOINT
===================================================
Date: 2026-10-25
Sample: DMSO, Week1_22141, B02, site_1
Original Fiji image: DAPI, 1280 x 1024 px, 16-bit
Segmentation workflow: Otsu threshold > 8-bit binary > Fill Holes > Watershed ONCE > Analyze Particles (size 0-Infinity, circularity 0-1, edge objects included).

VERIFICATION
- Results table: 333 entries, single DMSO DAPI image label.
- Summary table Count: 333.
- ROI ZIP entries: 333; ZIP integrity check passed.
- Sum of individual object areas: 262298 pixel^2; matches Fiji Summary.
- Numbered ROIs 1-333 appear in the saved file. The ROI corresponding to result row 17 was manually named ROIS.roi and is a single-pixel ROI located at x=712.5,y=13.5, matching the Results row 17. No row is missing. The original ROI ZIP remains unaltered.

DESCRIPTIVE QC FLAGS -- NOT A CLAIM OF NUCLEAR SEGMENTATION ACCURACY
- Area < 100 px^2: 33 objects.
- ROI bounding boxes touching the image border: 31 objects.
- Both flags: 10 objects.
- Objects passing both simple screens: 279.
- These are provisional screens only; crowded regions, false splits, merges and background artifacts can remain. Do not call remaining objects 'validated nuclei'.

PRESENTATION INTERPRETATION
- Manual Fiji outputs and screenshots establish the actual segmentation process and illustrate its errors.
- Three_treatment_single_field_descriptive_comparison.csv covers ONE manually processed image per treatment. Do not treat object counts as treatment efficacy, loss of cells, replicate-validated change or a statistical comparison.
- Use plate/field-level summaries of the full batch for any treatment comparisons, and report segmentation sensitivity and QC restrictions.
- Fixed-cell fluorescence microscopy; screenshots/video are sequential processing steps, not live imaging or drug-action time lapse.
- Actin/Tubulin perinuclear measures from another DMSO pilot field are separate; do not imply those numbers were calculated from this Plate2 B02 field.

FILES
Original_Fiji_Exports: unchanged Fiji data (only user-facing filenames standardized).
Manual_Screenshots: supplied Fiji screenshots of Otsu, binary, ROI mask and final original DAPI overlay.
QC_Analysis: per-object screening flags and cross-treatment one-field descriptive summary.
